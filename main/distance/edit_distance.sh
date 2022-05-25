#!/bin/bash
## Job Name
#SBATCH --job-name=distance

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition={small_queue}

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node={small_queue_cores}
#SBATCH --time={small_queue_time}

## Memory per Node
#SBATCH --mem={small_queue_mem}

## Ouput
#SBATCH --output={debug_directory}/distance_%j.out

# Parameters - 
#   small_queue
#   small_queue_cores
#   small_queue_time
#   small_queue_mem
#   debug_directory
#   results_directory
#   main_directory
#   reference_file
#   scaffold_file

echo "Run on `date`."
# Start Time
SECONDS=0

# Load modules.
module load stf/mummer

# Remove and remake edit distance folder.
mkdir -p {results_directory}/edit_distance
cd {results_directory}/edit_distance

# Run edit distance. 
python {main_directory}/distance/edit_distance.py \
    --reference {reference_file} \
    --assembly {scaffold_file} \
    --outdir {results_directory}/edit_distance \
    --threads {small_queue_cores}

# # Run edit distance. 
# python {main_directory}/distance/edit_distance.py \
#     --reference {reference_file} \
#     --assembly ../*.fasta \
#     --outdir . \
#     --threads {small_queue_cores}

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."