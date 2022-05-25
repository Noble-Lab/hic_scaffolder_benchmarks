#!/bin/bash
## Job Name
#SBATCH --job-name=qc

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
#SBATCH --output={debug_directory}/qc_%j.out

# Parameters - 
#   medium_queue
#   medium_queue_cores
#   medium_queue_time
#   medium_queue_mem
#   debug_directory
#   qc_path

echo "Run on `date`."
# Start Time
SECONDS=0

# Modules.
module load singularity
module load stf/samtools

# Directory.
cd {alignment_directory}

# Convert to bam.
samtools view \
    -b \
    -h \
    -@ {medium_queue_cores} \
    -o alignment.bam \
    alignment.sam

# Make report.
singularity run \
    --bind $PWD:/root/results/ \
    --home $PWD:/root/results \
    {qc_path} \
    hic-qc \
    -b alignment.bam \
    -n -1

# Cleanup.
rm alignment.sam
rm alignment.bam
mv Read_mate_dist_qc_report.pdf qc_report.pdf
rm -rf Read_mate*

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."