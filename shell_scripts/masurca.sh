#!/bin/bash
## Job Name
#SBATCH --job-name=masurca

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition=compute-hugemem

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=40
#SBATCH --time=240:00:00

## Memory per node
#SBATCH --mem=740G

echo "Run on `date`."
# Start Time
SECONDS=0

module load stf/masurca

./assemble.sh

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
