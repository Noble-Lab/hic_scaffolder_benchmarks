import subprocess
import argparse
import requests
import json
import re
import os

def setup():
	parser = argparse.ArgumentParser(
		description = 'Download data from SRA.')

	parser.add_argument(
		'-i',
		'--input',
		required = True,
		help = 'File with list of accession numbers.')
	
	parser.add_argument(
		'-o',
		'--directory',
		default = os.getcwd(),
		help = 'Output directory. (Optional)')

	parser.add_argument(
		'-t',
		'--type',
		choices = ['pacbio','illumina'],
		required = True,
		help = 'File with list of accession numbers.')

	parser.add_argument(
		'-l',
		'--limit',
		type = int,
		default = 1,
		help = 'Target download size per job. (GB) (Optional)')

	return parser.parse_args()

def extract(accession: str):
	# Download the SRA webpage with all the links.
	response = requests.get(f'https://trace.ncbi.nlm.nih.gov/Traces/sra/?run={accession}')

	# Use the base name of the server to extract all the PacBio links. If this
	# part doesn't work, double check that the S3 site is still true. 
	s3_site = 'https://sra-pub-src-1.s3.amazonaws.com'
	regex = f'\"({s3_site}.*?)\"'
	matches = re.findall(regex, response.text)

	if len(matches) == 0:
		print ('Did not find any links, are you sure you selected the right data type?')
		return False

	return matches

def download_size(links: list):
	total_size = 0
	for link in links:
		request = requests.head(link)
		total_size += int(request.headers['content-length'])
	
	return total_size

# Create a temporary script from the template. 
def create_script(
		number: int, 
		template: str, 
		directory: str, 
		input_name: str = '{none}', 
		accession: str = '{none}'):

	with open(template) as infile:
		script = infile.read()
	
	# Naming gymnastics.
	job_name = f'down_{number}'
	output_name = f'download_{number}.sh'
	output_path = os.path.join(directory, output_name)

	# Modify the template script to create a temporary batch script.
	script = script.replace('{job_name}', job_name)
	script = script.replace('{input_name}', input_name)
	script = script.replace('{directory}', directory)
	script = script.replace('{accession}', accession)
	script = script.replace('{script}', output_path)

	# Save script.
	with open(output_path, 'w') as outfile:
		outfile.write(script)

	return output_path

def send_pacbio_job(i, current_list, infile, template, directory):
	input_name = os.path.basename(infile)
	input_name = '.'.join(input_name.split('.')[:-1])
	input_path = os.path.dirname(infile)
	filename = os.path.join(input_path, f'{input_name}_{i}.json')

	with open(filename, 'w') as outfile:
		json.dump(current_list, outfile)
			
		# Create the batch script.
		outfile = create_script(i, template, filename, directory)

		# Send the batch job. 
		subprocess.call(['sbatch', outfile])

def split_list(accessions, limit, infile, template, directory):
	i = 0
	total_size = 0
	current_list = {}
	for accession in accessions:
		total_size += accessions[accession]['size']
		current_list[accession] = accessions[accession]['links']

		# Check if current list exceeds target size. 
		if total_size > (limit * 1e9):
			send_pacbio_job(i, current_list, infile, template, directory)

			i += 1
			total_size = 0
			current_list = {}
	
	if len(current_list):
		send_job(i, current_list, infile, template, directory)
	
	print (f'Created {i} Jobs')

def run_pacbio(arguments, template, accessions):
	# Find the links and their size for each accession.
	links = {}
	for accession in accessions:
		links[accession] = {}
		links[accession]['links'] = extract(accession)

		# If there are no valid links, stop. 
		if links[accession]['links'] is False:
			return

		links[accession]['size'] = download_size(links[accession]['links'])
	
	# Split the list of accessions and send the jobs. 
	split_list(
		accessions = links,
		limit = arguments.limit, 
		infile = arguments.input,
		template = template, 
		directory = arguments.directory)

def run_illumina(arguments, template, accessions):
	i = 0
	for accession in accessions:
		i += 1
		download_directory = os.path.join(arguments.directory, accession)
		os.makedirs(download_directory, exist_ok = True)

		# Check if valid downloads are already present.
		name_1 = os.path.join(download_directory, f'{accession}_1.fastq')
		name_2 = os.path.join(download_directory, f'{accession}_2.fastq')
		name_3 = os.path.join(download_directory, f'{accession}.fastq')

		stop = False
		for name in [name_1, name_2, name_3]:
			if os.path.isfile(name):
				stop = True
		
		if stop:
			continue

		outfile = create_script(
			number = i,
			template = template, 
			directory = download_directory, 
			accession = accession)

		# Send the batch job. 
		subprocess.call(['sbatch', outfile])

def main():
	arguments = setup()

	# Read the accession list file.
	accessions = []
	with open(arguments.input) as infile:
		for line in infile:
			if line.strip():
				accessions.append(line.strip())
	
	if arguments.type == 'pacbio':
		template = '/usr/lusers/asur/scripts/sra_download/pacbio_template.sh'
		run_pacbio(
			arguments = arguments,
			template = template,
			accessions = accessions)
	
	elif arguments.type == 'illumina':
		template = '/usr/lusers/asur/scripts/sra_download/illumina_template.sh'
		run_illumina(
			arguments = arguments,
			template = template,
			accessions = accessions)

				

if __name__ == '__main__':
	main()
