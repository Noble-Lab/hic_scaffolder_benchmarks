#!/bin/bash

## Job Name
#SBATCH --job-name={job_name}

## Allocation
#SBATCH --account=stf
#SBATCH --partition=build

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=1
#SBATCH --time=8:00:00
#SBATCH --mem=8G

## Directory
#SBATCH --chdir={directory}
#SBATCH --output={directory}/slurm-%A.out

# Start Time
echo "Run on `date`."
SECONDS=0

cd {directory}
~/software/sratoolkit/bin/fasterq-dump --split-3 --threads 1 --force {accession}

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."

# Remove 
rm {script}