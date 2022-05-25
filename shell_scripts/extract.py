import pandas as pd
import pathlib

# Get the distance json file. 
def get_distance(filename):

    # If the file exists. 
    if filename.exists():
       series = pd.read_json(filename, typ = 'series')
    else:
        series = pd.Series({
            'grouping': '',
            'order': '',
            'orientation': '',
            'accuracy': '',
            'edit_distance': ''})
        
    return series

# Get scaffolding time. 
def get_time(filenames):
    seconds = ''

    # If the file exists.
    times = []
    for filename in filenames:
        if filename:
            with open(filename) as infile:
                for line in infile:
                    pass
            
            if 'Seconds' in line:
                seconds = int(line.strip().split(': ')[-1])
        times.append(seconds)
    
    if times:
        seconds = max(times)
        
    return pd.Series({'seconds': seconds})

# Get the N50 value of an assembly. 
def get_n50(filename, prefix):

    series = pd.Series({
        f'{prefix}_count': '',
        f'{prefix}_largest': '', 
        f'{prefix}_n50': ''})

    # If the file exists. 
    if filename.exists():
       
        # Get the lengths of all the scaffolds. 
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

        count = len(lengths)
        total = sum(lengths.values())
        largest = max(lengths.values())

        # N50
        cutoff = total * 0.50
        current = 0
        for size in sorted(lengths.values(), reverse = True):
            current += size
            if current >= cutoff:
                break

        series[f'{prefix}_count'] = count
        series[f'{prefix}_largest'] = largest
        series[f'{prefix}_n50'] = size

    return series

# Get metrics on each method for each run. 
def extract_method(method):
    parent = pathlib.Path(f'/gscratch/scrubbed/asur/results/{method}_results')

    array = []
    for directory in parent.iterdir():

        condition = directory.name
        split = condition.split('_')
        project_name = '_'.join(split[:2])
        species = split[0]
        genome_coverage = split[1]
        hic_coverage = split[3]

        series = pd.Series({
            'species': species,
            'method': method,
            'genome_coverage': genome_coverage,
            'hic_coverage': hic_coverage})

        if (species != 'hsapiens') or (hic_coverage != '100x'):
            continue 

        print (directory)
        
        # Distance metrics.
        filename = directory.joinpath('edit_distance_no_singles', f'{project_name}_{method}_assembly_no_singles.json')
        distance = get_distance(filename)

        # # Scaffolding time.
        # filename = list(directory.joinpath('debug').glob('scaffold*'))
        # time = get_time(filename)

        # # Scaffold metrics.
        # filename = directory.joinpath(f'{project_name}_{method}.fasta')
        # scaffolds = get_n50(filename, 'scaffold')

        # series = pd.concat([series, distance, time, scaffolds])

        series = pd.concat([series, distance])
        array.append(series)
    
    return pd.concat(array, axis = 1).transpose()

def main():
    array = []
    for method in ['hirise', 'lachesis', '3d_dna', 'salsa', 'allhic']:
        array.append(extract_method(method))
    
    df = pd.concat(array).sort_values(
        ['method', 'species', 'genome_coverage', 'hic_coverage'])

    # for species in ['scerevisiae', 'ltarentolae', 'athaliana', 'hsapiens']:
    #     filename = pathlib.Path(f'/gscratch/scrubbed/asur/data/reference_genomes/{species}_genome.fasta')
    #     reference = get_n50(filename, 'reference')
    #     for column, value in reference.iteritems():
    #         df.loc[df['species'] == species, column] = value
    
    df.to_csv('scaffolding_results_new.csv', index = False)

if __name__ == '__main__':
    main()
