import numpy as np
import argparse
import pathlib
import sys

# Local imports
import assign_contigs

parent_directory = pathlib.Path(__file__).parent.parent
sys.path.append(str(parent_directory))
from utils import fasta
from utils import sizes

def setup():
	parser = argparse.ArgumentParser(
		description = 'Run nucmer to find contig chromosome assignments.')

	parser.add_argument(
		'-r',
		'--reference',
		required = True,
		type = pathlib.Path,
		help = 'Reference genome sequence.')

	parser.add_argument(
		'-a',
		'--assembly',
		required = True,
		type = pathlib.Path,
		help = 'Assembly file.')

	parser.add_argument(
		'-t',
		'--threads',
		default = '1',
		help = 'Number of threads to use.')

	parser.add_argument(
		'-ml',
		'--min-length',
		type = int, 
		default = 5000,
		help = 'Minimum contig length to be considered. (bp)')
		
	parser.add_argument(
		'-ma',
		'--min-alignment',
		type = int, 
		default = 1000,
		help = 'Minimum alignment length to be considered. (bp)')

	parser.add_argument(
		'-mc',
		'--min-coverage',
		type = float, 
		default = 0.2,
		help = 'Minimum alignment percent to be considered. (0 - 1)')

	parser.add_argument(
		'-mo',
		'--max-overlap',
		type = float, 
		default = 0.1,
		help = 'Maximum overlap of contigs allowed to pass. (0 - 1)')

	return parser.parse_args()

def valid_contigs(df, min_length = 5000, max_overlap = 0.1):
	starting_contigs = len(df.index.get_level_values('query_name').unique())

	allowed = []
	reference_names = df.index.get_level_values('reference_name').unique()
	for reference_name in reference_names:
		section = df.xs(reference_name, level = 'reference_name')
		reference_length = int(section.iloc[0]['reference_length'])
		aligned = np.zeros(reference_length)

		section = section.sort_values(by = 'query_length', ascending = False)
		query_names = section.index.get_level_values('query_name').unique()
		for query_name in query_names:

			query_start = int(section.loc[query_name]['total_reference_start'])
			query_end = int(section.loc[query_name]['total_reference_end'])
			query_length = int(section.loc[query_name]['query_length'])
			revised_start = int(query_start + (max_overlap * query_length))
			revised_end = int(query_end - (max_overlap * query_length))

			if np.sum(aligned[revised_start:revised_end]) > 0:
				continue
			elif query_length < min_length:
				continue
			else:
				aligned[query_start:query_end] = 1
				allowed.append(query_name)
	
	pruned = starting_contigs - len(allowed)

	return allowed, pruned

# Be sure to have the nucmer, delta-filter, and show-coords, in your path. 
def main(reference, assembly, outdir, threads, min_length, min_alignment, min_coverage, max_overlap):

	# See assign_contigs.py for details. 
	alignment = assign_contigs.run_mummer(
		reference = reference,
		assembly = assembly,
		threads = threads)

	if alignment is None:
		return
	
	contig_lengths = sizes.get_lengths(assembly)
	reference_lengths = sizes.get_lengths(reference)
	aligned_contigs = len(alignment.index.get_level_values('query_name').unique())
	aligned_references = len(alignment.index.get_level_values('reference_name').unique())
	
	# Filter out contigs with low alignment coverage or low alignment lengths.
	filtered = alignment.groupby(
		by = ['query_name', 'reference_name']).filter(
			assign_contigs.remove_alignments,
			min_length = min_alignment, 
			min_coverage = min_coverage)
	
	filtered_contigs = len(filtered.index.get_level_values('query_name').unique())
	
	# Add total alignment length for each contig and reference pair. 
	filtered['total_reference_alignment_length'] = filtered.groupby(
		by = ['query_name','reference_name'])['reference_alignment_length'].transform(sum)

	# Only keep the query reference pair with the largest total alignment. 
	filtered = filtered.loc[filtered.groupby(
		by = 'query_name')['total_reference_alignment_length'].idxmax()]

	# Find the total reference starts and reference ends.
	filtered['total_reference_start'] = filtered.groupby(
		by = ['query_name'])['reference_start'].transform(min)
	filtered['total_reference_end'] = filtered.groupby(
		by = ['query_name'])['reference_end'].transform(max)
	
	# Drop duplicates query rows. 	
	filtered = filtered.loc[~filtered.index.duplicated()]

	# Find non-overlapping contigs. 
	allowed, pruned = valid_contigs(
		df = filtered, 
		min_length = min_length,
		max_overlap = max_overlap)

	# Write them into a file.
	assembly_sequences = fasta.read(assembly)
	new_sequences = {}
	for query_name in assembly_sequences:
		if query_name in allowed:
			new_sequences[query_name] = assembly_sequences[query_name]
	filename = outdir.joinpath(f'{assembly.stem}_no_overlaps.fasta')
	fasta.write(new_sequences, filename)
	
	# Alignment statistics.
	if len(filtered) > 0:
		minimum_alignment = ( \
			filtered['total_reference_alignment_length'] / \
			filtered['query_length']).min() * 100

		average_alignment = filtered.groupby(by = 'query_name').first() \
			['total_reference_alignment_length'].sum() / \
			filtered.groupby(by = 'query_name').first() \
			['query_length'].sum() * 100

	print()
	print( '     Contig Statistics     ')
	print( '-----------------------------')
	print(f'            Starting: {len(contig_lengths):>6}')
	print(f'  Missing Alignments: {len(contig_lengths) - aligned_contigs:>6}')
	print(f'      Low Alignments: {aligned_contigs - filtered_contigs:>6}')
	print(f'   Missing Reference: {len(reference_lengths) - aligned_references:>6}')	
	print(f'   Minimum Alignment: {minimum_alignment:>5.2f}%')
	print(f'   Average Alignment: {average_alignment:>5.2f}%')
	print(f'         Overlapping: {pruned:>6}')
	print(f'               Valid: {len(allowed):>6}')


if __name__ == '__main__':
	arguments = setup()
	main(
		reference = arguments.reference,
		assembly = arguments.assembly, 
		threads = arguments.threads, 
		min_length = arguments.min_length,
		min_alignment = arguments.min_alignment, 
		min_coverage = arguments.min_coverage,
		max_overlap = arguments.max_overlap,
		outdir = pathlib.Path.cwd())