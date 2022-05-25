import subprocess
import warnings
import argparse
import os

def setup():
	parser = argparse.ArgumentParser(
		description = 'Convert PacBio data into FASTQs.')

	parser.add_argument(
		'-i',
		'--input',
		required = True,
		help = 'Input directory with accession data.')

	return parser.parse_args()

def convert(infolder, prefix):
    groupname = os.listdir(infolder)[0].split('.')[0]
    filename = '{0}.bas.h5'.format(groupname)
    filepath = os.path.join(infolder, filename)
    
    # Convert .h5 to fastq
    subprocess.call([
        '/usr/lusers/asur/software/pbh5tools/bin/bash5tools.py', 
        '--readType', 'subreads', 
        '--outFilePrefix', prefix, 
        '--outType', 'fastq', 
        filepath],
        stderr = open(os.devnull, 'w'))
    
    # Parallel gzip
    filename = '{0}.fastq'.format(prefix)
    subprocess.call([
        'pigz', 
        '--force',
        filename])

def main():
    warnings.filterwarnings('ignore')
    arguments = setup()

    outdir = os.path.join(arguments.input, 'fastq')
    if not os.path.exists(outdir):
        os.makedirs(outdir)    

    accessions = os.listdir(arguments.input)
    for accession in accessions:
        if accession == 'fastq':
            continue
        if accession[0] == '.':
            continue

        print (accession)
        infolder = os.path.join(arguments.input, accession)
        prefix = os.path.join(outdir, accession)
        convert(infolder, prefix)

if __name__ == '__main__':
	main()

