#!/bin/bash
## Job Name
#SBATCH --job-name=hirise

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
#SBATCH --output={debug_directory}/scaffold_%j.out

# Parameters - 
#   medium_queue
#   medium_queue_cores
#   medium_queue_time
#   medium_queue_mem
#   debug_directory
#   results_directory
#   alignment_file
#   alignment_index
#   assembly_file
#   hirise_path
#   main_directory

echo "Run on `date`."
# Start Time
SECONDS=0

# Modules.
module load singularity

# Directory.
rm -rf {results_directory}/run
mkdir -p {results_directory}/run
cd {results_directory}/run

# Link files.
ln {alignment_file} alignment.bam
ln {alignment_index} alignment.bam.bai
ln {assembly_file} assembly.fasta

# Run scaffolding.
singularity run \
    --bind $PWD:/root/results \
    --home $PWD:/root/results \
    {hirise_path} \
    hirise \
    alignment.bam \
    assembly.fasta

# Get AGP.
python {main_directory}/scaffolding/hirise.py \
    --input hirise.srf \
    --output {results_directory}/{project_name}_hirise.agp

# Make FASTA from AGP. 
python {main_directory}/utils/fasta.py \
    --input {assembly_file} \
    --agp {results_directory}/{project_name}_hirise.agp \
    --output {results_directory}/{project_name}_hirise.fasta

# Cleanup.
rm -rf {results_directory}/run

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
echo "Seconds: ${SECONDS}"