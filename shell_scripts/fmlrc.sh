#!/bin/bash

## Job Name
#SBATCH --job-name=fmlrc

## Allocation
#SBATCH --account=stf
#SBATCH --partition=compute

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=40
#SBATCH --time=200:00:00
#SBATCH --mem=185G

echo "Run on `date`."

# Start Time
SECONDS=0

module load singularity

singularity run \
    --bind $PWD:/root/results \
    --home $PWD:/root/results \
    ~/software/fmlrc/fmlrc_latest.sif \
    ./execute.sh

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
