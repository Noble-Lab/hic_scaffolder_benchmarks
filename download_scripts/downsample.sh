#!/bin/bash
## Job Name
#SBATCH --job-name=sample

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition=stf

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=28
#SBATCH --time=24:00:00

## Memory per node
#SBATCH --mem=120GB

echo "Run on `date`."
# Start Time
SECONDS=0

module load contrib/pigz/2.4 
python downsample.py --input /gscratch/stf/asur/genome_data/arabidopsis/arabidopsis_370x.fastq.gz --coverage 370

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
