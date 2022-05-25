import argparse
import pathlib
import sys

# Local imports. 
parent_directory = pathlib.Path(__file__).parent.parent
sys.path.append(str(parent_directory))
from utils import agp

def setup():
    parser = argparse.ArgumentParser(
        description = 'Convert HiRise output into AGP.')

    parser.add_argument(
        '-i',
        '--input',
        type = pathlib.Path, 
        required = True,
        help = 'HiRise scaffolding file.')
    
    parser.add_argument(
        '-o',
        '--output',
        type = pathlib.Path,
        default = 'assignments.agp',
        help = 'AGP filename.')

    return parser.parse_args()

def get_assignments(filename):
    assembly = {}
    with open(filename) as infile:
        for line in infile:
            split = line.split()

            description = split[1]
            if description == 'GAP':
                continue

            # There's a strange "bug", sometimes scaffold numbers have
            # decimals.
            scaffold = int(float(split[0])) - 1
            description = split[2]
            orientation = description[0]
            contig_name = description[1:-2]
            length = int(split[4]) - int(split[3])

            # Check if the scaffold already exists in the assembly. 
            # If not, make it. 
            scaffold_name = f'scaffold_{scaffold}'
            if scaffold_name not in assembly:
                assembly[scaffold_name] = {}

            assembly[scaffold_name][contig_name] = {
                'start': 1,
                'end': length,
                'orientation': orientation}
    
    return assembly

def main():
    arguments = setup()
    assembly = get_assignments(arguments.input)
    agp.write(assembly, arguments.output)

if __name__ == '__main__':
    main()