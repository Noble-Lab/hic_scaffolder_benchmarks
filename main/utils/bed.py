import argparse
import pathlib

def setup():
    parser = argparse.ArgumentParser(
        description = 'Make a bed file with contigs split in half.')
    
    parser.add_argument(
        '-i',
        '--input',
        type = pathlib.Path, 
        required = True,
        help = 'Input sizes file.')

    parser.add_argument(
        '-o',
        '--output',
        default = 'graph.bed',
        type = pathlib.Path, 
        help = 'Output bed file.')

    return parser.parse_args()

def read_sizes(filename):
    sizes = {}
    with open(filename) as infile:
        for line in infile:
            contig, size = line.strip().split('\t')
            sizes[contig] = int(size)

    return sizes

def write_bed(sizes, filename):
    with open(filename, 'w') as outfile:
        for contig in sizes:
            size = sizes[contig]
            midpoint = int(size/2)

            # Write the bin for the first half of the contig.  
            line = f'{contig}\t0\t{midpoint}\n'
            outfile.write(line)

            # Write the bin for the second half of the contig.  
            line = f'{contig}\t{midpoint}\t{size}\n'
            outfile.write(line)

def main():
    arguments = setup()
    sizes = read_sizes(arguments.input)
    write_bed(sizes, arguments.output)

if __name__ == '__main__':
    main()

