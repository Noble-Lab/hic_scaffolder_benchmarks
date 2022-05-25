import argparse
import pathlib

def setup():
    parser = argparse.ArgumentParser(
        description = 'Get size related information about an assembly.')

    parser.add_argument(
        '-i',
        '--input',
        type = pathlib.Path,
        required = True,
        help = 'Fasta file.')

    parser.add_argument(
        '-o',
        '--output',
        help = 'Fasta file.')

    return parser.parse_args()

# Read a FASTA file and return sequence lengths.  
def get_lengths(filename):
	lengths = {}
	with open(filename) as infile:
		for line in infile:

			# Add a new sequence with each new header. 
			if '>' == line[0]:
				name = line[1:-1]
				lengths[name] = 0
			
			# Add to the running total. 
			else:
				lengths[name] += len(line.strip())

	return lengths

# Get the NX value of an assembly. 
def nx(values, total, percent):
    cutoff = total * percent
    current = 0
    for size in values:
        current += size
        if current >= cutoff:
            return size

def main():
    arguments = setup()

    # Check if file exists.
    if not arguments.input.exists():
        print (f'File   {arguments.input} not found.')
        return 

    lengths = get_lengths(arguments.input)

    # If no output filename is provided, print assembly stats instead. 
    if arguments.output is None:
        count = len(lengths)
        total = sum(lengths.values())
        largest = max(lengths.values())
        n50 = nx(sorted(lengths.values(), reverse = True), total, 0.50)

        print (f'{count:,} sequences')
        print (f'{total:,} bp total length')
        print (f'{largest:,} bp largest contig')
        print (f'{n50:,} bp N50')
    else:
        with open(arguments.output, 'w') as outfile:
            for chromosome in lengths:
                line = f'{chromosome}\t{lengths[chromosome]}\n'
                outfile.write(line)

if __name__ == '__main__':
    main()      
