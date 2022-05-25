import argparse
import requests
import json
import os

def setup():
    parser = argparse.ArgumentParser(
        description = 'Download links from a json.')

    parser.add_argument(
        '-i',
        '--input',
        required = True,
        help = 'File with list of links to download.')

    parser.add_argument(
        '-o',
        '--directory',
        default = '.',
        help = 'Output directory.')

    return parser.parse_args()

def download(directory, link):
    name = link.split('/')[-1]
    if name[-2:] == '.1':
        name = name[:-2]

    filename = os.path.join(directory, name)
    response = requests.get(link, stream = True)
    with open(filename, 'wb') as outfile:
        for chunk in response.iter_content(chunk_size = 1024):
            outfile.write(chunk)

def main():
    arguments = setup()

    with open(arguments.input) as infile:
        links = json.load(infile)

    # For each accession.
    for accession in links:
        download_directory = os.path.join(arguments.outdir, accession)
        os.makedirs(download_directory, exist_ok = True) 

        # For each link in the accession.
        for url in links[accession]:
            download(download_directory, url)
        
        print (accession)
    
if __name__ == '__main__':
    main()