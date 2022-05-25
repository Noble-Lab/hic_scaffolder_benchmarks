import pathlib
import json
import math

# Create all the directories, as needed. 
def make_directories(parameters):
    for key in parameters:
        value = parameters[key]
        if ('directory' in key) and (type(value) is pathlib.PosixPath):
            pathlib.Path.mkdir(
                value,
                parents = True,
                exist_ok = True)


def check_files(parameters):
    method = parameters['{method}']
    coverage = parameters['{coverage}']
    project_name = parameters['{project_name}']
    alignment_directory = parameters['{alignment_directory}']
    
    # If doing an alignment.
    if (method is None) and (coverage is None):
        read_1 = parameters['{read_1}']
        read_2 = parameters['{read_2}']
        if (read_1 is None) or (read_2 is None):
            print ('Please include read files for alignments.')
            return False
    
    # If downsampling alignments.
    if (method is None) and (coverage is not None):

        # Check if the alpha sorted alignment file exists.
        alignment_file = alignment_directory.joinpath(f'{project_name}_alpha.bam')
        parameters['{alignment_file}'] = alignment_file
        if not alignment_file.exists():
            print ('Please complete alignments before attempting to downsample.')
            return False
        
    # If scaffolding. 
    if method is not None:

        # Sort convention.
        if method == 'hirise':
            sort_type = 'sort'
        else:
            sort_type = 'alpha'

        n_chromosomes = parameters['{n_chromosomes}']
        if (method in ['allhic', 'lachesis']) and (n_chromosomes is None):
            print ('Please include the number of chromosomes for Lachesis and AllHiC.')
            return False

        # Check for alignment file. 
        if coverage is None:
            alignment_file = alignment_directory.joinpath(f'{project_name}_{sort_type}.bam')
        else: 
            alignment_file = alignment_directory.joinpath(f'{project_name}_{coverage}x_{sort_type}.bam')
            

        if not alignment_file.exists():
            print ('Please complete alignments before attempting to scaffold.')
            return False
            
        alignment_index = pathlib.Path(f'{alignment_file}.bai')
        parameters['{alignment_file}'] = alignment_file
        parameters['{alignment_index}'] = alignment_index
    
    return True

def get_alignment(parameters):
    # Variables.
    alignment_directory = parameters['{alignment_directory}']

    # Names and folders.
    debug_directory = alignment_directory.joinpath('debug')
    
    # Add to parameters.
    parameters['{cleanup}'] = False
    parameters['{debug_directory}'] = debug_directory

def get_scaffolding(parameters):
    # Dash convention.
    method = parameters['{method}']
    if method == '3d-dna':
        parameters['{method}'] = '3d_dna'
        method = '3d_dna'

    # Enzyme convention.
    enzyme = 'MboI'
    if method in ['lachesis', 'salsa']:
        enzyme = 'GATC'
    
    # Scaffolding directories.
    project_name = parameters['{project_name}']
    alignment_directory = parameters['{alignment_directory}']
    top_directory = pathlib.Path(parameters['{top_directory}'])
    scaffolding_directory = top_directory.joinpath(f'{method}_results')
    
    # Naming convention.
    coverage = parameters['{coverage}']
    if coverage is None:
        results_directory = scaffolding_directory.joinpath(f'{project_name}')
        juicer_file = alignment_directory.joinpath(f'{project_name}_juicer.txt')
    else:
        results_directory = scaffolding_directory.joinpath(f'{project_name}_genome_{coverage}x_hic')
        juicer_file = alignment_directory.joinpath(f'{project_name}_{coverage}x_juicer.txt')
    debug_directory = results_directory.joinpath('debug')

    # Add to parameters.
    if '{reference}' in parameters:
        parameters['{reference_file}'] = parameters['{reference}']
    parameters['{enzyme}'] = enzyme
    parameters['{juicer_file}'] = juicer_file
    parameters['{debug_directory}'] = debug_directory
    parameters['{scaffolding_directory}'] = scaffolding_directory 
    parameters['{results_directory}'] = results_directory

# Open the defaults.json file and double check that the appropriate file tree
# is available. 
def get_defaults(arguments):
    defaults_json = pathlib.Path(__file__).parent.joinpath('defaults.json')
    with open(defaults_json) as infile:
        parameters = json.load(infile)

    # Add the arguments to parameters. 
    for argument in vars(arguments):
        key = '{' + argument + '}'
        parameters[key] = getattr(arguments, argument)

    # Names and folders. 
    coverage = parameters['{coverage}']
    project_name = arguments.assembly.stem
    top_directory = pathlib.Path(parameters['{top_directory}'])
    index_directory = top_directory.joinpath('index_results', project_name)
    alignment_directory = top_directory.joinpath('alignment_results', project_name)
    
    if coverage is None:
        cooler_file = alignment_directory.joinpath(f'{project_name}.mcool')
    else:
        cooler_file = alignment_directory.joinpath(f'{project_name}_{coverage}x.mcool')
    
    # Memory per core calculations. 
    big_queue_mem = int(parameters['{big_queue_mem}'][:-1])
    cores = int(parameters['{big_queue_cores}'])
    big_queue_mem_per_core = f'{math.floor(big_queue_mem/cores)}G'
    
    # Update parameters.
    parameters['{cooler_file}'] = cooler_file
    parameters['{project_name}'] = project_name
    parameters['{index_directory}'] = index_directory
    parameters['{assembly_file}'] = parameters['{assembly}']
    parameters['{alignment_directory}'] = alignment_directory
    parameters['{big_queue_mem_per_core}'] = big_queue_mem_per_core

    # Check for starting files. 
    check = check_files(parameters)
    if not check:
        return False

    # Fill in run specific parameters.
    if parameters['{method}'] is None:
        get_alignment(parameters)
    else:
        get_scaffolding(parameters)
    
    # If we have a valid run.
    if parameters:
        make_directories(parameters)

    return parameters