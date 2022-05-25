import argparse
import pathlib
import json
import sys

# Local imports. 
parent_directory = pathlib.Path(__file__).parent.parent
sys.path.append(str(parent_directory))
from utils import sizes

def setup():
    parser = argparse.ArgumentParser(
        description = 'Generate the appropriate downsampling rate.')

    parser.add_argument(
        '-i',
        '--input',
        type = pathlib.Path,
        help = 'Fasta file.')
    
    parser.add_argument(
        '-a',
        '--alignment',
        type = pathlib.Path,
        required = True,
        help = 'JSON of samtools flagstat.')

    parser.add_argument(
        '-c',
        '--coverage',
        type = int,
        help = 'Target coverage for alignment.')

    parser.add_argument(
        '-r',
        '--reads',
        type = int, 
        help = 'Target number of reads to extract.'
    )

    return parser.parse_args()

def main():
    arguments = setup()

    # Number of mapped reads.
    with open(arguments.alignment) as infile:
        report = json.load(infile)
    reads = int(report['QC-passed reads']['read1'])
    mapped_reads = int(report['QC-passed reads']['mapped'])

    if arguments.reads is not None:
        sample_rate = arguments.reads/reads
        if sample_rate >= 1:
            sample_rate = False
        print (f'{sample_rate:.12f}')
    
    if arguments.coverage is not None:
        # Length of genome.
        
        lengths = sizes.get_lengths(arguments.input)
        total_length = sum(lengths.values())
        
        # Calculate sampling rate.
        reads_per_kilobase = (mapped_reads/2)/(total_length/1000)
        if reads_per_kilobase < arguments.coverage:
            sample_rate = False
        else:
            sample_rate = arguments.coverage/reads_per_kilobase
        print (f'{sample_rate:.12f}')

if __name__ == '__main__':
    main()