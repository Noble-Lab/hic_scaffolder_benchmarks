#!/bin/bash
## Job Name
#SBATCH --job-name=download

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition=compute

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=10
#SBATCH --time=24:00:00

## Memory per node
#SBATCH --mem=40G

# Start Time
echo "Run on `date`."
SECONDS=0

module load stf/sratoolkit

fasterq-dump --split-3 --threads 10 --force --progress SRR3195326
fasterq-dump --split-3 --threads 10 --force --progress SRR3195327
fasterq-dump --split-3 --threads 10 --force --progress SRR3195329
fasterq-dump --split-3 --threads 10 --force --progress SRR3195331
fasterq-dump --split-3 --threads 10 --force --progress SRR3195332
fasterq-dump --split-3 --threads 10 --force --progress SRR3195334
fasterq-dump --split-3 --threads 10 --force --progress SRR3195335
fasterq-dump --split-3 --threads 10 --force --progress SRR3195338
fasterq-dump --split-3 --threads 10 --force --progress SRR3195339
fasterq-dump --split-3 --threads 10 --force --progress SRR3195340

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."

