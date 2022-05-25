#!/bin/bash
## Job Name
#SBATCH --job-name=alignment

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
#SBATCH --output={debug_directory}/alignment_%j.out

# Parameters - 
#   big_queue
#   big_queue_cores
#   big_queue_time
#   big_queue_mem
#   debug_directory
#   alignment_directory
#   index_directory
#   read_1
#   read_2

echo "Run on `date`."
# Start Time
SECONDS=0

# Modules.
module load stf/bwa
module load stf/samtools
module load stf/samblaster

# Directory.
cd {alignment_directory}

# Do alignment.  
bwa mem \
    -SP5 \
    -t {big_queue_cores} \
    {index_directory}/{project_name}.fasta \
    {read_1} \
    {read_2} | \
samblaster \
    --addMateTags > \
    alignment.sam

samtools flagstat \
    -@ {big_queue_cores} \
    -O json \
    alignment.sam > \
    initial_alignment.json
    
samtools view \
    -h \
    -@ {big_queue_cores} \
    -F 3340 \
    -o {project_name}.sam \
    alignment.sam

samtools flagstat \
    -@ {big_queue_cores} \
    -O json \
    {project_name}.sam > \
    final_alignment.json

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."