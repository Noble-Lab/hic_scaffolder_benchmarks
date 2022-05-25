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
        description = 'Parse lachesis run directory.')

    parser.add_argument(
        '--input',
        type = pathlib.Path, 
        help = 'Lachesis run directory.')

    parser.add_argument(
        '--output',
        type = pathlib.Path,
        help = 'AGP output.')

    parser.add_argument(
        '--assembly', 
        type = pathlib.Path, 
        help = 'Assembly file.')

    return parser.parse_args()

# Get all the files which have ordering information. 
def cluster_filepath(directory):
    filepaths = []
    for filepath in pathlib.Path.iterdir(directory):
        if '.ordering' in filepath.name:
            filepaths.append(filepath)

    return filepaths

# Extract information from all the clusters. 
def get_assignments(filepaths, lengths):
    i = 1
    assembly = {}
    for filepath in filepaths:
        contigs = {}
        with open(filepath) as infile:
            for line in infile:
                # Skip comments in cluster files.
                if line[0] == '#':
                    continue
                
                # Process the contig lines.
                split = line.split('\t')
                contig_name = split[1]
                
                # Translate encoding to + or -.
                if int(split[2]) == 0:
                    orientation = '+'
                else:
                    orientation = '-'
                
                # Create the contig in the dictionary.
                contigs[contig_name] = {
                    'start': 1,
                    'end': lengths[contig_name],
                    'orientation': orientation}
            
        if len(contigs) > 0:
            scaffold_name = f'scaffold_{i}'
            assembly[scaffold_name] = contigs
            i += 1

    return assembly

def main():
    arguments = setup()
    filepaths = cluster_filepath(arguments.input)
    lengths = sizes.get_lengths(arguments.assembly)
    assembly = get_assignments(filepaths, lengths)
    agp.write(assembly, arguments.output)

    print (f'{len(assembly)} chromosomes recovered.')

if __name__ == '__main__':
    main()