#!/bin/bash

## Job Name
#SBATCH --job-name=arcs

## Allocation
#SBATCH --account=stf
#SBATCH --partition=compute

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=40
#SBATCH --time=100:00:00
#SBATCH --mem=175G

echo "Run on `date`."

# Start Time
SECONDS=0

module load stf/arcs/1.2.1

/sw/contrib/stf-src/arcs/1.2.1/build/Examples/arcs-make arcs draft=masurca_corrected_matepair_primary reads=egracilis_10x

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
