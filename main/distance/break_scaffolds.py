import argparse
import pathlib
import sys

# Local imports. 
parent_directory = pathlib.Path(__file__).parent.parent
sys.path.append(str(parent_directory))
from utils import agp

def setup():
    parser = argparse.ArgumentParser(
        description = 'Split a scaffold into its component contigs.')

    parser.add_argument(
        '-i',
        '--input',
        required = True,
        type = pathlib.Path, 
        help = 'Input FASTA file with scaffolded sequences.')

    return parser.parse_args()

'''
Read a FASTA file and return a dictionary containing the sequence names and the
sequences. 
'''

def get_scaffolds(filename):
    sequences = {}
    with open(filename) as infile:
        sequence = ''

        for line in infile:
            # If it is a header line -  
            if '>' in line:

                # Add sequence to dictionary. 
                if len(sequence) > 0: 
                    sequences[name] = sequence
                sequence = ''
                
                # Trim header and newline. 
                name = line[1:-1]
                
            else:
                sequence += line.strip()

    # Add last sequence. 
    sequences[name] = sequence

    return sequences

'''
We want to split scaffolds whenever there is a run of more than some user
specified number of Ns. To achieve this, we scan a sequence from left to 
right and keep track of the number of consecutive Ns. If the number ever
exceeds the threshold we save the sequence, and wait until the next non N
base pair is seen to start saving the next sequence.
'''

def break_scaffold(sequence, n = 10):
    contigs = []
    n_count = 0
    current = ''
    for base in sequence:

        current += base

        # If the base is an N, add to the N counter, otherwise reset it. 
        if base != 'N':
            n_count = 0
        else:
            n_count += 1

        # If the N count is greater than the threshold add the contig. 
        if n_count >= n :
            if len(current[:-10]) > 0:
                contigs.append(current[:-10])
            current = ''

    # Add the last contig if it was not a run of Ns. 
    if len(current) > 0:
        contigs.append(current)

    return contigs

'''
Given a set of scaffolded sequences, break the sequences at runs of Ns and then
return a list of subsequences and the scaffolds they belonged to. 
'''

def get_contigs(sequences, n = 10):
    contigs = {}
    assembly = {}

    for scaffold in sequences:
        scaffold_name = scaffold.split(' ')[0]
        assembly[scaffold_name] = {}

        # Split the scaffold sequence at Ns.
        contig_sequences = break_scaffold(sequences[scaffold])

        contig_index = 1
        for sequence in contig_sequences:
            contig_name = f'{scaffold_name}.{contig_index}'
            contigs[contig_name] = sequence
            assembly[scaffold_name][contig_name] = {
                'start': 1,
                'end': len(sequence),
                'orientation': '+'}

            # Iterate contig index. 
            contig_index += 1

    return assembly, contigs

# Given a dictionary of sequences, write a fasta file. 
def write_fasta(sequences, filename):
    with open(filename, 'w') as outfile:
        for name in sequences:

            # Write the header. 
            header = f'>{name}\n'
            outfile.write(header)
            sequence = sequences[name]

            # Write 80 characters per line. 
            i = 0
            while i <= (len(sequence) - 80):
                line = f'{sequence[i:i+80]}\n'
                outfile.write(line)
                i += 80

            # Write the last line.        
            line = f'{sequence[i:]}\n' 
            outfile.write(line)

def main(infile, outdir):
    # Split scaffolds into contigs. 
    print ('Generating contigs from scaffolds.')
    scaffolds = get_scaffolds(infile)
    assembly, contigs = get_contigs(scaffolds)

    # Write contigs to FASTA.
    fasta_file = pathlib.Path(f'{infile.stem}_contigs.fasta')
    write_fasta(contigs, fasta_file)

    # Write the AGP file. 
    agp_file = outdir.joinpath(f'{infile.stem}_assembly.agp')
    agp.write(assembly, agp_file)
    
    return fasta_file, agp_file

if __name__ == '__main__':
    arguments = setup()
    main(
        infile = arguments.input, 
        outdir = pathlib.Path.cwd())