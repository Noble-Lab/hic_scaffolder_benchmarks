#!/bin/bash
## Job Name
#SBATCH --job-name=sizes

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition={small_queue}

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=1
#SBATCH --time=1:00:00

## Memory per Node
#SBATCH --mem=1GB

## Ouput
#SBATCH --output={debug_directory}/sizes_%j.out

# Parameters - 
#   small_queue
#   debug_directory
#   index_directory
#   assembly_file
#   project_name
#   main_directory

echo "Run on `date`."
# Start Time
SECONDS=0

# Directory.
cd {index_directory}

# Link assembly.
ln -f {assembly_file} {project_name}.fasta

# Make sizes file.
python {main_directory}/utils/sizes.py \
    -i {project_name}.fasta \
    -o sizes.txt

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."