#!/bin/bash
## Job Name
#SBATCH --job-name=cooler

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition={medium_queue}

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node={medium_queue_cores}
#SBATCH --time={medium_queue_time}

## Memory per Node
#SBATCH --mem={medium_queue_mem}

## Ouput
#SBATCH --output={debug_directory}/cooler_%j.out

# Parameters - 
#   medium_queue
#   medium_queue_cores
#   medium_queue_time
#   medium_queue_mem
#   debug_directory
#   alignment_directory
#   project_name
#   index_directory
#   alignment_file

echo "Run on `date`."
# Start Time
SECONDS=0

# Modules.
module load stf/samtools

# Directory.
cd {alignment_directory}

# Create the cooler file. 
pairtools parse \
    --assembly {project_name} \
    --chroms-path {index_directory}/sizes.txt \
    --drop-sam \
    --nproc-in {medium_queue_cores} \
    --nproc-out {medium_queue_cores} \
    {alignment_file} | \
pairtools dedup \
    --nproc-in {medium_queue_cores} \
    --nproc-out {medium_queue_cores} \
    --mark-dups | \
pairtools select \
    --nproc-in {medium_queue_cores} \
    --nproc-out {medium_queue_cores} \
    "(pair_type=='UU') or (pair_type=='UR') or (pair_type=='RU')" | \
cooler cload pairs \
    --assembly {project_name} \
    -c1 2 \
    -p1 3 \
    -c2 4 \
    -p2 5 \
    {index_directory}/sizes.txt:1000 \
    - \
    {project_name}.cool

# Create the multi cooler file.
# If the coverage is less than 10 don't balance. 
coverage={coverage}

# If coverage is not specified, assume there is more than 10 coverage.
if [ $coverage = "None" ]
then
	coverage=100
fi

if [ $coverage -ge 10 ]
then
    echo "Balancing" 
    cooler zoomify \
        --nproc {medium_queue_cores} \
        --resolutions 4DN \
        --balance \
        --out {cooler_file} \
        {project_name}.cool
else
    echo "Not Balancing"
    cooler zoomify \
        --nproc {medium_queue_cores} \
        --resolutions 4DN \
        --out {cooler_file} \
        {project_name}.cool
fi

rm {project_name}.cool

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
