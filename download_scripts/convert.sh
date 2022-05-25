#!/bin/bash
## Job Name
#SBATCH --job-name=convert

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition=stf

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=28
#SBATCH --time=24:00:00

## Emails
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=asur@uw.edu

## Memory per node
#SBATCH --mem=120GB

echo "Run on `date`."
# Start Time
SECONDS=0

module load contrib/pigz/2.4 
source ~/.virtual/python2/bin/activate
python convert.py --input /gscratch/stf/asur/arabidopsis_raw_data

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
