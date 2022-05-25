#!/bin/bash
## Job Name
#SBATCH --job-name=index

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition={small_queue}

## Resources
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time={small_queue_time}

## Memory per Node
#SBATCH --mem=20GB

## Ouput
#SBATCH --output={debug_directory}/index_%j.out

# Parameters - 
#   small_queue
#   small_queue_time
#   debug_directory
#   index_directory
#   project_name

echo "Run on `date`."
# Start Time
SECONDS=0

# Modules.
module load stf/bwa

# Directory.
cd {index_directory}

# Make index.
bwa index {project_name}.fasta

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."