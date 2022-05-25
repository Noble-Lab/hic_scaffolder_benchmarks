from matplotlib.patches import Rectangle
from matplotlib import pyplot as plt
import numpy as np
import argparse
import pathlib
import cooler

def setup():
    parser = argparse.ArgumentParser(
        description = 'Plot the Hi-C matrix from a cooler file.')

    parser.add_argument(
        '-i',
        '--input',
        type = pathlib.Path,
        required = True,
        help = 'Input cooler file.')
    
    parser.add_argument(
        '-o',
        '--output',
        type = pathlib.Path,
        default = 'sample.png',
        help = 'Output image file.')
    
    parser.add_argument(
        '-s',
        '--scaffolds',
        type = pathlib.Path,
        default = False,
        help = 'AGP file.')

    return parser.parse_args()

# Read the AGP file and return a permutation vector. 
def read_agp(filename, indicies, length, resolution):

    # List of scaffold lengths. 
    scaffolds = []

    # Complete list of indicies in the assembly. 
    complete = np.arange(length)

    last_scaffold = None
    with open(filename) as infile:
        
        # Keep track of scaffold lengths in terms of matrix rows. 
        scaffold_start = 0
        scaffold_length = 0

        index = []
        for line in infile:

            # Skip comments.
            if line[0] == '#':
                continue

            # Split using the tab delimiter. 
            split = line.split('\t')

            # We are interested in only the genomic segments, and not gaps. 
            segment_type = split[4]
            if segment_type == 'W':

                # Get the scaffold name and contig name. 
                current_scaffold = split[0]
                contig_name  = split[5]

                # Calculate which rows we want. 
                start = int(np.floor(int(split[6])/resolution))
                end = int(np.ceil(int(split[7])/resolution))
                try:
                    section = indicies[contig_name][start:end]
                except KeyError:
                    continue

                # Iterate scaffold length.
                scaffold_length += len(section)

                # Add scaffold information. 
                if (last_scaffold != current_scaffold) and (len(index) > 0):
                    scaffolds.append((scaffold_start, scaffold_length))
                    scaffold_start += scaffold_length
                    scaffold_length = 0
            
                # Add contig section to indicies. 
                index += list(section)
                
                last_scaffold = current_scaffold
            
        # Add the last scaffold. 
        scaffolds.append((scaffold_start, scaffold_length))

        # Add any unused indicies to the end. 
        unused = set(list(complete)) - set(index)
        index += list(unused)

        return index, scaffolds

# Generate index list without scaffolding. 
def get_default(indicies):

    # List of chromosome lengths. 
    chromosomes = []

    # All indicies. 
    index = []

    for chromosome in indicies:
        section = indicies[chromosome]

        # Figure out chromosome boundaries. 
        chromosome_start = min(section)
        chromosome_length = max(section) - min(section)
        chromosomes.append((chromosome_start, chromosome_length))

        # Add to the index. 
        index += list(section)

    return index, chromosomes

def main():
    arguments = setup()
    if str(arguments.scaffolds) == 'False':
        arguments.scaffolds = False

    # Lowest resolution available. 
    project_name = arguments.input.stem
    coolers = cooler.fileops.list_coolers(str(arguments.input))

    resolutions = []
    for uri in coolers:
        resolutions.append(int(uri.split('/')[-1]))

    # Select the best resolution given the number of pixels in a row. 
    pixels = 2000
    largest = resolutions[-1]
    data = cooler.Cooler(f'{arguments.input}::/resolutions/{largest}')
    total_length = data.chromsizes.sum()
    ideal_resolution = total_length/pixels
    difference = np.abs(np.array(resolutions) - ideal_resolution)
    resolution = resolutions[np.argmin(difference)]
    
    # Load cooler. 
    data = cooler.Cooler(f'{arguments.input}::/resolutions/{resolution}')

    # Swap out nan for 0, if balanced weights are present, use them, otherwise
    # use the unbalanced weights. 
    try:
        matrix = np.nan_to_num(data.matrix(balance = True)[:], copy = False)
    except ValueError:
         matrix = np.nan_to_num(data.matrix(balance = False)[:], copy = False)

    # Extract the chromosome to bins pairings.
    series = data.bins()[:]['chrom'].values

    # Create a dictionary for the indicies corresponding to chromosome rows and columns.
    indicies = {}
    for chromosome in series.unique():
        value = np.argwhere(series == chromosome).T[0]
        indicies[chromosome] = value

    # Get the permutation vector and scaffold boundaries. 
    if arguments.scaffolds:    
        filename = arguments.scaffolds
        length = len(series)
        index, boundaries = read_agp(
            filename = filename, 
            indicies = indicies, 
            length = length, 
            resolution = resolution)

    # Otherwise just plot without scaffolding. 
    else: 
        index, boundaries = get_default(indicies)

    # Plot the matrix.
    index = np.ix_(np.hstack(index), np.hstack(index))
    plt.figure(figsize = (10,10), dpi = 200)
    plt.title('Hi-C Scaffolding Map')
    plt.imshow(np.log10(matrix[index] + 1),
        interpolation = 'none',
        vmax = np.mean(np.log10(matrix[index] + 1)) * 10,
        cmap = 'YlOrRd')
    plt.xticks([],[])
    plt.yticks([],[])
    plt.xlabel(project_name)

    # Add the square boundaries around chromosomes. 
    for coordinates in boundaries:
        start = coordinates[0]
        width = coordinates[1]
        rectangle = Rectangle(
            (start - 1, start - 1),
            width = width + 1,
            height = width + 1, 
            fill = False)
        plt.gca().add_patch(rectangle)
    
    # Save the image. 
    plt.tight_layout()
    plt.savefig(arguments.output)

if __name__ == '__main__':
    main()
