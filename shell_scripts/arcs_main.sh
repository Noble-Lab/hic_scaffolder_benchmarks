#!/bin/bash

## Job Name
#SBATCH --job-name=arcs

## Allocation
#SBATCH --account=stf
#SBATCH --partition=compute

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=40
#SBATCH --time=48:00:00
#SBATCH --mem=175G

echo "Run on `date`."

# Start Time
SECONDS=0

module load stf/arcs/1.2.1

arcs-make arcs \
    draft=masurca_corrected_all_v1_long_rna \
    reads=egracilis_10x \
    t=40 \
    c=2 \
    m=20-10000 \
    z=1000 \
    s=95 \
    l=3 \
    a=0.9

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
