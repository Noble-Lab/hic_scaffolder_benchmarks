#!/bin/bash

## Job Name
#SBATCH --job-name=longstitch

## Allocation
#SBATCH --account=stf
#SBATCH --partition=compute

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=40
#SBATCH --time=24:00:00
#SBATCH --mem=175G

echo "Run on `date`."

# Start Time
SECONDS=0

module load stf/longstitch

longstitch ntLink-arks \
    draft=test_15 \
    reads=reads \
    t=40 \
    k_ntLink=32 \
    w=100 

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
