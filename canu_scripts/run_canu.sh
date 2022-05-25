#!/bin/bash
## Job Name
#SBATCH --job-name=canu

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition=build

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=1
#SBATCH --time=8:00:00

## Memory per node
#SBATCH --mem=20GB

echo "Run on `date`."
# Start Time
SECONDS=0

python ~/scripts/canu_scripts/run_canu.py -i /gscratch/stf/asur/data/genome_data/human -s 3.1g

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
