#!/bin/bash

## Job Name
#SBATCH --job-name=reads

## Allocation
#SBATCH --account=stf
#SBATCH --partition=compute

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=40
#SBATCH --time=24:00:00
#SBATCH --mem=185G

echo "Run on `date`."

# Start Time
SECONDS=0

zcat /gscratch/stf/asur/data/hic_data/hsapiens/hsapiens_hic_R1.fastq.gz | paste - - - - | awk -F"\t" '{ if (length($2) != length($4)) print $0 }' | wc -l

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
