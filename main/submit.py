import subprocess
import argparse
import pathlib

# Local import.
import generate_defaults

def setup():
    parser = argparse.ArgumentParser(
        description = 'Run Hi-C Scaffolders')
    
    parser.add_argument(
        '-a',
        '--assembly',
        type = pathlib.Path, 
        required = True,
        metavar='',
        help = 'Genome assembly file.')
    
    parser.add_argument(
        '-r1',
        '--read-1',
        type = pathlib.Path, 
        metavar='',
        help = 'Read 1 of the Hi-C sequencing.')

    parser.add_argument(
        '-r2',
        '--read-2',
        type = pathlib.Path, 
        metavar='',
        help = 'Read 2 of the Hi-C sequencing.')

    parser.add_argument(
        '-c',
        '--coverage',
        type = int,
        metavar='',
        help = 'Target reads/kilobase coverage after alignment.')

    parser.add_argument(
        '-r',
        '--reference',
        type = pathlib.Path, 
        metavar='',
        help = 'Reference genome file.')

    parser.add_argument(
        '-m',
        '--method',
        metavar='',
        choices = ['lachesis', '3d-dna', 'hirise', 'salsa', 'allhic', 'baseline'],
        help = 'lachesis, 3d-dna, hirise, salsa, allhic')

    parser.add_argument(
        '-n',
        '--n-chromosomes',
        metavar='',
        help = 'Number of chromosomes. (Lachesis and AllHiC)')

    return parser.parse_args()

# Submit a job using the provided parameters and return the job id. 
def sbatch(template, parameters, job_id = False):
    with open(template) as infile:
        contents = infile.read()
    
    # Replace template parameters with specified values. 
    for key in parameters:
        contents = contents.replace(key, str(parameters[key]))
    
    # Save a temporary version of it.
    temporary = parameters['{debug_directory}'].joinpath(template.name)
    with open(temporary, 'w') as outfile:
        outfile.write(contents)

    dependencies = True
    # Submit to the cluster.
    if job_id:
        # If there multiple dependencies.
        if (type(job_id) == list) and any(job_id):
            job_ids = []
            for number in job_id:
                if number:
                    job_ids.append(number)
            job_id = ':'.join(job_ids)

        # If they are all false/completed.
        elif type(job_id) == list:
            dependencies = False
    else:
        dependencies = False

    if dependencies:
        job_id = subprocess.check_output([
            'sbatch',
            f'--dependency=afterok:{job_id}',
            temporary])
    else:
        job_id = subprocess.check_output([
            'sbatch',
            temporary])
    
    # Delete the script.
    pathlib.Path.unlink(temporary)

    # Return the job id of the job. 
    return job_id.decode('utf-8').split()[-1]

# Create a sizes file for a genome.
def generate_sizes(parameters, job_id = False):
    # Variables
    index_directory = parameters['{index_directory}']

    # Names and folders.
    sizes_file = index_directory.joinpath('sizes.txt')

    if not sizes_file.exists():
        print ('Submitting Sizes Job')
        template = pathlib.Path(__file__).parent.joinpath('utils', 'sizes.sh')
        return sbatch(template, parameters, job_id)

    # Otherwise return false.
    else:
        print ('Sizes already exists.')
        return False

# Index a FASTA file if it hasn't been indexed before. 
def generate_index(parameters, job_id = False):
    # Variables.
    assembly_file = parameters['{assembly_file}']
    index_directory = parameters['{index_directory}']

    # Names and folders.
    index_file = index_directory.joinpath(f'{assembly_file.name}.amb')
    
    # If the index doesn't exist, make it.
    if not index_file.exists():
        print ('Submitting Indexing Job')
        template = pathlib.Path(__file__).parent.joinpath('alignment', 'index.sh')
        return sbatch(template, parameters, job_id)

    # Otherwise return false. 
    else:
        print ('Index already exists.')
        return False

# Align paired-end reads if they haven't already.
def generate_alignment(parameters, job_id = False):
    # Variables
    project_name = parameters['{project_name}']
    alignment_directory = parameters['{alignment_directory}']

    # Names and folders.
    alignment_file = alignment_directory.joinpath(f'{project_name}.sam')
    alpha_file = alignment_directory.joinpath(f'{project_name}_alpha.bam')

    # Add to parameters.
    parameters['{alignment_file}'] = alignment_file

    # If the reads have not been aligned, send the job.
    if not alpha_file.exists():
        print ('Submitting Alignment Job')
        template = pathlib.Path(__file__).parent.joinpath('alignment', 'alignment.sh')
        parameters['{cleanup}'] = True
        parameters['{run_alignment}'] = True
        return sbatch(template, parameters, job_id)

    # Otherwise return false. 
    else:
        print ('Alignment already exists.')
        parameters['{alignment_file}'] = alpha_file
        parameters['{run_alignment}'] = False
        return False

# QC alignment. 
def generate_qc(parameters, job_id = False):
    # Variables
    alignment_directory = parameters['{alignment_directory}']

    # Names and folders.
    qc_file = alignment_directory.joinpath(f'qc_report.pdf')

    # Check if the alignment.sam file exists.
    if not qc_file.exists():
        if parameters['{run_alignment}']:
            print ('Submitting QC Job')
            template = pathlib.Path(__file__).parent.joinpath('alignment', 'qc.sh')
            return sbatch(template, parameters, job_id)
        else:
            print ('QC not possible, the preliminary alignment is no longer available.')
            return False

    # Otherwise return false. 
    else:
        print ('QC already exists.')
        return False

# Create a cooler file for a genome.
def generate_cooler(parameters, job_id = False):
    # Variables.
    cooler_file = parameters['{cooler_file}']

    if not cooler_file.exists():
        print ('Submitting Cooler Job')
        template = pathlib.Path(__file__).parent.joinpath('alignment', 'cooler.sh')
        return sbatch(template, parameters, job_id)

    # Otherwise return false.
    else:
        print ('Cooler already exists.')
        return False

# Plot the Hi-C matrix.
def generate_plot(parameters, job_id = False):
    # Variables
    project_name = parameters['{project_name}']
    alignment_directory = parameters['{alignment_directory}']

    # Add to parameters.
    if '{assignments_file}' not in parameters:
        parameters['{assignments_file}'] = False

    # Names and folders.
    if parameters['{assignments_file}'] == False:
        plot_file = alignment_directory.joinpath(f'{project_name}.png')
        parameters['{plot_file}'] = plot_file
    else:
        plot_file = parameters['{plot_file}']

    if not plot_file.exists():
        print ('Submitting Plot Job')
        template = pathlib.Path(__file__).parent.joinpath('utils', 'plot.sh')
        return sbatch(template, parameters, job_id)

    # Otherwise return false.
    else:
        print ('Plot already exists.')
        return False

# Downsample an alignment if possible.
def generate_downsample(parameters, job_id = False):
    # Variables.
    coverage = parameters['{coverage}']
    project_name = parameters['{project_name}']
    alignment_directory = parameters['{alignment_directory}']

    # Names and folders.
    alpha_file = alignment_directory.joinpath(f'{project_name}_{coverage}x_alpha.bam')

    # Add to parameters.
    parameters['{project_name}'] = f'{project_name}_{coverage}x'

    # If the alignment has not been downsampled, send the job and update alignment_file.
    if not alpha_file.exists():
        print ('Submitting Downsample Job')
        template = pathlib.Path(__file__).parent.joinpath('alignment', 'downsample.sh')
        job_id = sbatch(template, parameters, job_id)
        alignment_file = alignment_directory.joinpath(f'{project_name}_{coverage}x.sam')
        parameters['{alignment_file}'] = alignment_file
        parameters['{cleanup}'] = True
        return job_id
        
    # Otherwise replace the alignment file.  
    else:
        print ('Downsample already exists.')
        parameters['{alignment_file}'] = alpha_file
        return False
        
# Sort an alignment by read name.
def generate_sort(parameters, job_id = False):
    # Variables.
    project_name = parameters['{project_name}']
    alignment_directory = parameters['{alignment_directory}']
    
    # Names and folders.
    sort_file = alignment_directory.joinpath(f'{project_name}_sort.bam')

    # If the reads have not been aligned, send the job.
    if not sort_file.exists():
        print ('Submitting Sort Job')
        template = pathlib.Path(__file__).parent.joinpath('alignment', 'sort.sh')
        job_id = sbatch(template, parameters, job_id)
        return job_id

    # Otherwise return false. 
    else:
        print ('Sorted file already exists.')
        return False

# Sort an alignment by genomic coordinate.
def generate_alpha(parameters, job_id = False):
    # Variables.
    project_name = parameters['{project_name}']
    alignment_directory = parameters['{alignment_directory}']
    
    # Names and folders.
    alpha_file = alignment_directory.joinpath(f'{project_name}_alpha.bam')

    # If the reads have not been aligned, send the job.
    if not alpha_file.exists():
        print ('Submitting Alpha Job')
        template = pathlib.Path(__file__).parent.joinpath('alignment', 'alpha.sh')
        job_id = sbatch(template, parameters, job_id)
        return job_id

    # Otherwise return false. 
    else:
        print ('Alpha file already exists.')
        return False

# Cleanup sam files in alignment directory.
def generate_cleanup(parameters, job_id = False):    
    if parameters['{cleanup}']:
        print ('Submitting Cleanup Job')
        template = pathlib.Path(__file__).parent.joinpath('alignment', 'cleanup.sh')
        return sbatch(template, parameters, job_id)
    else:
        print ('Cleanup aleady finished.')
        return False

def process_alignment(parameters, job_ids = []):
    coverage = parameters['{coverage}']
    if not coverage:
        # Generate sizes file.
        sizes_job_id = generate_sizes(parameters)
        job_ids.append(sizes_job_id)

        # Generate bwa index. 
        index_job_id = generate_index(parameters)
        job_ids.append(index_job_id)

        # Generate bwa alignment. 
        alignment_job_id = generate_alignment(parameters, index_job_id)
        job_ids.append(alignment_job_id)

        # Generate QC report. 
        qc_job_id = generate_qc(parameters, alignment_job_id)
        job_ids.append(qc_job_id)

    # Generate downsample. 
    else:
        alignment_job_id = generate_downsample(parameters)
        job_ids.append(alignment_job_id)

    # Generate cooler. 
    cooler_job_id = generate_cooler(parameters, alignment_job_id)
    job_ids.append(cooler_job_id)

    # Generate plot. 
    generate_plot(parameters, cooler_job_id)

    # Generate coordinate sort.
    sort_job_id = generate_sort(parameters, alignment_job_id)
    job_ids.append(sort_job_id)

    # Generate alpha sort.
    alpha_job_id = generate_alpha(parameters, alignment_job_id)
    job_ids.append(alpha_job_id)

    # Cleanup
    generate_cleanup(parameters, job_ids)

def generate_juicer(parameters, job_id = False):
    if parameters['{method}'] != '3d_dna':
        return False

    # Variables.
    juicer_file = parameters['{juicer_file}']

    if not juicer_file.exists():
        print ('Submitting Juicer Job')    
        template = pathlib.Path(__file__).parent.joinpath('alignment', 'juicer.sh')
        return sbatch(template, parameters, job_id)
    else:
        print ('Juicer file already exists.')
        return False

def generate_scaffolding(parameters, job_id = False):
    # Variables.
    method = parameters['{method}']
    project_name = parameters['{project_name}']
    results_directory = parameters['{results_directory}']

    # Names and folders.
    plot_file = results_directory.joinpath(f'{project_name}_{method}.png')
    scaffold_file = results_directory.joinpath(f'{project_name}_{method}.fasta')
    assignments_file = results_directory.joinpath(f'{project_name}_{method}.agp')

    # Add to parameters.
    parameters['{plot_file}'] = plot_file
    parameters['{scaffold_file}'] = scaffold_file
    parameters['{assignments_file}'] = assignments_file

    if not assignments_file.exists():
        print ('Submitting Scaffolding Job')    
        template = pathlib.Path(__file__).parent.joinpath('scaffolding', f'{method}.sh')
        return sbatch(template, parameters, job_id)
    else:
        print ('AGP already exists.')
        return False

def generate_distance(parameters, job_id = False):
    # Variables. 
    method = parameters['{method}']
    project_name = parameters['{project_name}']
    results_directory = parameters['{results_directory}']

    # Names and folders.
    distance_file = results_directory.joinpath('edit_distance', f'{project_name}_{method}.json')

    if not distance_file.exists():
        
        # If a reference genome was not provided. 
        if parameters['{reference_file}'] is None:
            print ('Reference file not provided, skipping edit distance calculations.')
            return False

        print ('Submitting Edit Distance Job')
        template = pathlib.Path(__file__).parent.joinpath('distance', 'edit_distance.sh')
        return sbatch(template, parameters, job_id)
    else:
        print ('Distance file already exists.')
        return False

def process_scaffolding(parameters):
    # Generate juicer. 
    juicer_job_id = generate_juicer(parameters)

    # Generate scaffolding.
    scaffolding_job_id = generate_scaffolding(parameters, juicer_job_id)
    
    # Generate plot.
    generate_plot(parameters, scaffolding_job_id)

    # Generate distance. 
    generate_distance(parameters, scaffolding_job_id)

    # generate_distance(parameters)

def main():
    arguments = setup()
    parameters = generate_defaults.get_defaults(arguments)

    # If we have the necessary starting files.
    if parameters:

        # If we are doing the alignment section.
        if parameters['{method}'] is None:
            process_alignment(parameters)
        
        # If we are doing the scaffolding section. 
        else:
            process_scaffolding(parameters)

if __name__ == '__main__':
    main()
