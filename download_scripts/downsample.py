import subprocess
import argparse
import time
import os

def setup():
    parser = argparse.ArgumentParser(
        description = 'Downsample FASTQs')

    parser.add_argument(
        '-i',
        '--input',
        required = True,
        help = 'Input FASTQ file.')
        
    parser.add_argument(
        '-c',
        '--coverage',
        type = float,
        required = True,
        help = 'Starting coverage.')

    return parser.parse_args()

# Downsample FASTQ file.
def sample(infile, depth, coverage):
    # Expected to be like human_140x.fastq or something.
    basename = os.path.basename(infile).split('_')[0]
    filename = f'{basename}_{depth}x.fastq'
    filename = os.path.join(os.path.dirname(infile), filename)

    with open(filename, 'w') as outfile:
        subprocess.call([
            '/usr/lusers/asur/software/seqtk/seqtk',
            'sample',
            infile, 
            str(coverage)],
            stdout = outfile)
            
    # Parallel gzip
    subprocess.call([
        'pigz', 
        '--force',
        filename])

def main():
    arguments = setup()

    # Downsample with increments of 10x coverage starting at 100x.
    depths = range(10, 110, 10)
    for depth in depths:
        if depth >= arguments.coverage:
            continue 

        fraction = depth/arguments.coverage
        start = time.time()
        
        sample(arguments.input, depth, fraction)

        # Figure out time elapsed
        seconds = time.time() - start
        hours, seconds =  seconds // 3600, seconds % 3600
        minutes, seconds = seconds // 60, seconds % 60
        print (f'{hours:02.0f}:{minutes:02.0f}:{seconds:02.0f} Elapsed for {depth}x Sampling')

if __name__ == '__main__':
	main()

