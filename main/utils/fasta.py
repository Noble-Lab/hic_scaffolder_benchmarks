import argparse
import pathlib
import sys

# Local imports. 
parent_directory = pathlib.Path(__file__).parent.parent
sys.path.append(str(parent_directory))
from utils import sizes
from utils import agp

def setup():
    parser = argparse.ArgumentParser(
        description = 'Create fasta files from other fasta and agp files.')

    parser.add_argument(
        '-i',
        '--input',
        required = True,
        type = pathlib.Path,
        help = 'Fasta file.')

    parser.add_argument(
        '-a',
        '--agp',
        type = pathlib.Path,
        help = 'AGP file.')
    
    parser.add_argument(
        '-l',
        '--largest',
        type = int, 
        help = 'Number of largest contigs save.')

    parser.add_argument(
        '-b',
        '--bp',
        type = int,
        help = 'Size of contigs to split into.')

    parser.add_argument(
        '-o',
        '--output',
        type = pathlib.Path, 
        help = 'Fasta file.')

    return parser.parse_args()

# Get the reverse complement of a sequence.  
def reverse_complement(sequence):
    conversion = {
        'A': 'T', 
        'T': 'A', 
        'C': 'G', 
        'G': 'C',
        'N': 'N'}
    
    new_sequence = ''
    for base in sequence[::-1]:

        # For ambigious bases just make them an N. 
        if base.upper() not in conversion:
            base = 'N'

        new_sequence += conversion[base.upper()]
    
    return new_sequence

# Make a scaffolded FASTA from an AGP and assembly FASTA. 
def convert_agp(agp_file, fasta_file, gap_length = 1000):
    assembly_agp = agp.read(agp_file)
    assembly_fasta = read(fasta_file)

    scaffolds = {}
    for scaffold_name in assembly_agp:
        scaffolds[scaffold_name] = []

        for contig_name in assembly_agp[scaffold_name]:
            sequence = assembly_fasta[contig_name]

            # If the orientation is reverse. 
            if assembly_agp[scaffold_name][contig_name]['orientation'] == '-':
                sequence = reverse_complement(sequence)
            
            # Append to the scaffold list. 
            scaffolds[scaffold_name].append(sequence)
        
        # Join the contigs in the scaffold with N's.
        scaffolds[scaffold_name] = ('N' * gap_length).join(scaffolds[scaffold_name])
    
    return scaffolds

# Get the n largest contigs. 
def get_largest(filename, n):
    sequences = read(filename)
    lengths = sizes.get_lengths(filename)
    
    if n > len(lengths):
        print (f'Fewer then {n} contigs present.')
        return
    
    else:
        return sorted(lengths, reverse = True, key = lengths.get)[:n], sequences

# Split a genome into n roughly equal pieces. 
def get_split(sequences, n):
    i = 0
    new_sequences = {}
    for name in sequences:
        sequence = sequences[name]

        # j is the base index, and i is the contig index.
        j = 0
        while j < len(sequence):
            contig_name = f'contig_{i}'
            new_sequences[contig_name] = sequence[j:j+n]
            j += n
            i += 1
            
    return new_sequences

# Return the sequences in a FASTA file.  
def read(filename):
    sequences = {}
    with open(filename) as infile:
        sequence = ''

        for line in infile:
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

# Given a dictionary of sequences, write a fasta file. 
def write(sequences, filename):
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

def main():
    arguments = setup()

    if arguments.largest:
        if arguments.output is None:
            arguments.output = 'trimmed.fasta'

        largest, sequences = get_largest(arguments.input, arguments.largest)

        if largest is not None:
            output = {}
            for name in largest:
                output[name] = sequences[name]
            
            write(output, arguments.output)
    
    elif arguments.bp:
        if arguments.output is None:
            arguments.output = 'split.fasta'

        sequences = read(arguments.input)
        output = get_split(sequences, arguments.bp)
        write(output, arguments.output)
    
    elif arguments.agp:
        if arguments.output is None:
            arguments.output = 'scaffold.fasta'
        
        sequences = convert_agp(arguments.agp, arguments.input)
        write(sequences, arguments.output)

if __name__ == '__main__':
    main()


