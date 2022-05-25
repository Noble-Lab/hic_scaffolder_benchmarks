import argparse
import pathlib
import json

def setup():
    parser = argparse.ArgumentParser(
        description = 'Trim canu alignment file headers.')

    parser.add_argument(
        '-i',
        '--input',
        type = pathlib.Path, 
        required = True,
        help = 'Genome assembly folder.')

    return parser.parse_args()

def trim(filename):
    project_name = str(filename).split('.')[0]
    infile = open(filename)
    out_filename = filename.parent.joinpath(f'{project_name}.fasta')
    outfile = open(out_filename, 'w')
    
    # Write a new FASTA without long headers. 
    headers = {}
    for line in infile:
        if line[0] == '>':
            old_header = line[1:].strip()
            contig_name = old_header.split()[0]
            headers[contig_name] = old_header

            new_header = f'>{contig_name}\n'
            outfile.write(new_header)
        else:
            outfile.write(line)
            
    infile.close()
    outfile.close()
    
    # Save original headers in JSON.
    out_filename = filename.parent.joinpath(f'{project_name}.json')
    with open(out_filename, 'w') as outfile:
        json.dump(headers, outfile, indent = 4)

    # Remove original file. 
    pathlib.Path.unlink(filename)

def main():
    arguments = setup()

    # Iterate through every file in a particular directory. 
    for filename in pathlib.Path.iterdir(arguments.input.resolve()):
        if 'contigs.fasta' in str(filename):
            print (f'Trimming {filename.name}.')
            trim(filename)

if __name__ == '__main__':
    main()
