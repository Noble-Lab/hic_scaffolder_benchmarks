import subprocess
import argparse
import os

def setup():
    parser = argparse.ArgumentParser(
        description = 'Run canu on downsampled fastq files.')

    parser.add_argument(
        '-i',
        '--infolder',
        required = True,
        help = 'Directory containing fastq files.')

    parser.add_argument(
        '-s',
        '--size',
        required = True,
        help = 'Genome size, use Canu syntax.')

    return parser.parse_args()

def main():
    arguments = setup()

    basename = os.path.basename(arguments.infolder)
    directory = os.path.join('/gscratch/stf/asur/assemblies', basename)
    for filename in os.listdir(arguments.infolder):
        fullpath = os.path.join(arguments.infolder, filename)
        assembly_name = filename.split('.')[0]
        assembly_directory = os.path.join(directory, assembly_name)
        os.makedirs(assembly_directory, exist_ok = True)
        subprocess.call([
            '/usr/lusers/asur/software/canu/build/bin/canu',
            '-p', assembly_name,
            '-d', assembly_directory,
            '-pacbio', fullpath,
            'gridOptions = --partition=ckpt --account=ckpt --time=24:00:00',
            'stopOnLowCoverage = 1',
            'minInputCoverage = 1',
            'batMemory = 90',
            'batThreads = 20',
            'cnsMemory = 90',
            'cnsThreads = 20', 
            f'genomeSize = {arguments.size}'])

if __name__ == '__main__':
    main()

