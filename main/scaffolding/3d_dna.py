import argparse
import pathlib
import sys

# Local imports. 
parent_directory = pathlib.Path(__file__).parent.parent
sys.path.append(str(parent_directory))
from utils import agp

def setup():
    parser = argparse.ArgumentParser(
        description = 'Convert 3d-dna output into a scaffolding JSON.')

    parser.add_argument(
        '-i',
        '--input',
        type = pathlib.Path, 
        required = True,
        help = '3d-dna assembly file.')
    
    parser.add_argument(
        '-o',
        '--output',
        type = pathlib.Path,
        default = 'assignments.agp',
        help = 'AGP file.')

    return parser.parse_args()

def parse_assembly(filename):
    contigs = {}
    scaffolds = {}
    with open(filename) as infile:
        previous = None
        n = 1
        for line in infile:
            if '>' == line[0]:
                number = line.split()[1]
                contig_name = line[1:].split()[0].split(':')[0]
                length = int(line.split()[-1])

                # If there is a new contig.
                if contig_name != previous:
                    start = 1
                    end = length
                # If we are continuing in the same one. 
                else:
                    end = start + length

                contigs[number] = {
                    'name': contig_name, 
                    'start': start, 
                    'end': end}
                previous = contig_name
                start = end
            
            else:
                name = f'scaffold_{n}'
                scaffolds[name] = line.split()
                n += 1
    
    return contigs, scaffolds

def get_assignments(contig_mapping, scaffolds):

    assembly = {}
    for scaffold_name in scaffolds:
        scaffold = scaffolds[scaffold_name]
        contigs = {}

        for contig in scaffold:

            # Check orientation.
            if int(contig) > 0:
                orientation = '+'
            else:
                orientation = '-'
            
            number = str(abs(int(contig)))
            contig_name = contig_mapping[number]['name']
            start = contig_mapping[number]['start']
            end = contig_mapping[number]['end']

            if 'hic_gap' in contig_name:
                continue

            # Create the contig in the dictionary.
            contigs[contig_name] = {
                'start': start,
                'end': end, 
                'orientation': orientation}
        
        assembly[scaffold_name] = contigs
    
    return assembly

def main():
    arguments = setup()
    contigs, chromosomes = parse_assembly(arguments.input)
    assembly = get_assignments(contigs, chromosomes)
    
    # Save results.
    agp.write(assembly, arguments.output)

if __name__ == '__main__':
    main()