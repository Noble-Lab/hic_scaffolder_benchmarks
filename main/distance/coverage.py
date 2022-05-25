from matplotlib.backends.backend_pdf import PdfPages
from matplotlib import pyplot as plt
import numpy as np
import argparse
import pathlib
import sys

# Local imports. 
parent_directory = pathlib.Path(__file__).parent.parent
sys.path.append(str(parent_directory))
from utils import agp

def setup():
    parser = argparse.ArgumentParser(
        description = 'Create coverage maps of a genome.')

    parser.add_argument(
        '-i',
        '--input',
        required = True,
        type = pathlib.Path,
        help = 'Input coverage.')

    parser.add_argument(
        '-a',
        '--alignment',
        type = pathlib.Path,
        default = None, 
        help = 'AGP file describing alignment to the reference genome.')
    
    parser.add_argument(
        '-o',
        '--output',
        type = pathlib.Path,
        default = 'coverage.pdf',
        help = 'Output filename.')

    return parser.parse_args()

def read_coverage(filename):
    scaffolds = {}
    total = []
    with open(filename) as infile:
        for line in infile:
            scaffold_name, coordinate, coverage = line.strip().split('\t')
            total.append(int(coverage))

            if scaffold_name not in scaffolds:
                scaffolds[scaffold_name] = [int(coverage)]
            else:
                scaffolds[scaffold_name].append(int(coverage))
    
    return scaffolds, np.median(total)

def moving_average(array, window):
    return np.convolve(array, np.ones(window), 'valid') / window

def plot(coverage, median, filename, alignment = None):
    with PdfPages(filename) as pdf:
        if alignment:
            for chromosome in alignment:
                for contig in alignment[chromosome]:
                    contig_name = contig.split('.')[0]
                    contig_median = np.median(coverage[contig_name])

                    plt.figure(figsize = (8,4), dpi = 100)
                    plt.plot(moving_average(coverage[contig_name], 1000))
                    plt.axhline(median, color = 'black', linestyle = '--', label = f'Genome Median: {median}')
                    plt.axhline(contig_median, color = 'tab:blue', linestyle = '--', label = f'Contig Median: {contig_median}')
                    plt.title(f'{chromosome}: {contig_name} - {len(coverage[contig_name]):,} bp')
                    plt.xlabel('Position')
                    plt.ylabel('Coverage')
                    plt.ylim([0, contig_median * 3])
                    plt.legend(loc = 'upper right')

                    plt.tight_layout()
                    pdf.savefig()
                    plt.close()

        else:
            for contig in coverage:
                contig_median = np.median(coverage[contig])

                plt.figure(figsize = (8,4), dpi = 100)
                plt.plot(moving_average(coverage[contig], 1000))
                plt.axhline(median, color = 'black', linestyle = '--', label = f'Genome Median: {median}')
                plt.axhline(contig_median, color = 'tab:blue', linestyle = '--', label = f'Chromosome Median: {contig_median}')
                plt.title(f'{contig} - {len(coverage[contig]):,} bp')
                plt.xlabel('Position')
                plt.ylabel('Coverage')
                plt.ylim([0, contig_median * 3])
                plt.legend(loc = 'upper right')

                plt.tight_layout()
                pdf.savefig()
                plt.close()

def main():
    arguments = setup()
    coverage, median = read_coverage(
        filename = arguments.input)
    if arguments.alignment:
        plot(
            coverage = coverage, 
            median = median, 
            alignment = agp.read(arguments.alignment),
            filename = arguments.output)
    else:
        plot(
            coverage = coverage, 
            median = median, 
            filename = arguments.output)

if __name__ == '__main__':
    main()
