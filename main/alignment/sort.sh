#!/bin/bash
## Job Name
#SBATCH --job-name=sort

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition={big_queue}

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node={big_queue_cores}
#SBATCH --time={big_queue_time}

## Memory per Node
#SBATCH --mem={big_queue_mem}

## Ouput
#SBATCH --output={debug_directory}/sort_%j.out

# Parameters - 
#   big_queue
#   big_queue_cores
#   big_queue_time
#   big_queue_mem
#   debug_directory
#   alignment_directory
#   big_queue_mem_per_core
#   project_name
#   alignment_file

echo "Run on `date`."
# Start Time
SECONDS=0

# Modules.
module load stf/samtools

# Directory.
cd {alignment_directory}

# Sort the files.
samtools sort \
    -@ {big_queue_cores} \
    -m {big_queue_mem_per_core} \
    -o {project_name}_sort.bam \
    {alignment_file}

# Index the sort.
samtools index \
    -@ {big_queue_cores} \
    {project_name}_sort.bam

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."