#!/bin/bash

## Job Name
#SBATCH --job-name=reads

## Allocation
#SBATCH --account=stf
#SBATCH --partition=compute

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=40
#SBATCH --time=8:00:00
#SBATCH --mem=185G

echo "Run on `date`."

# Start Time
SECONDS=0

~/software/samtools/bin/samtools flagstat -@ 40 --verbosity 9 /gscratch/stf/asur/results/alignment_results/hsapiens_100x/alignment.sam

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
