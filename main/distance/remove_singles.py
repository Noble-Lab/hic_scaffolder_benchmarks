import argparse
import pathlib
import sys

parent_directory = pathlib.Path(__file__).parent.parent
sys.path.append(str(parent_directory))
from utils import agp

def setup():
	parser = argparse.ArgumentParser(
		description = 'Remove single contig scaffolds from a set of AGPs.')

	parser.add_argument(
		'-r',
		'--reference',
		required = True,
		type = pathlib.Path,
		help = 'Reference genome AGP.')

	parser.add_argument(
		'-a',
		'--assembly',
		required = True,
		type = pathlib.Path,
		help = 'Assembly AGP.')

	return parser.parse_args()

def valid_contigs(agp):
    valid = []
    for scaffold in agp:
        if len(agp[scaffold]) > 1:
            for contig in agp[scaffold]:
               valid.append(contig)
    
    return valid

def remove_contigs(agp, valid):
    new_agp = {}
    for scaffold in agp:
        current_scaffold = {}
        
        for contig in agp[scaffold]:
            if contig in valid:
                current_scaffold[contig] = agp[scaffold][contig]

        if len(current_scaffold) > 0:
            new_agp[scaffold] = current_scaffold
    
    return new_agp

# Be sure to have the nucmer, delta-filter, and show-coords, in your path. 
def main():
    arguments = setup()
    reference = agp.read(arguments.reference)
    assembly = agp.read(arguments.assembly)

    valid = valid_contigs(assembly)
    new_reference = remove_contigs(reference, valid)
    new_assembly = remove_contigs(assembly, valid)

    new_reference_filename = f'{arguments.reference.stem}_no_singles.agp'
    agp.write(new_reference, new_reference_filename)
    new_assembly_filename = f'{arguments.assembly.stem}_no_singles.agp'
    agp.write(new_assembly, new_assembly_filename)

if __name__ == '__main__':
	main()
