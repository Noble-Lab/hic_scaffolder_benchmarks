#!/bin/bash
## Job Name
#SBATCH --job-name=jellyfish

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition=stf

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=28
#SBATCH --time=2:00:00

## Emails
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=asur@uw.edu

## Memory per node
#SBATCH --mem=120GB

echo "Run on `date`."
# Start Time
SECONDS=0

/usr/lusers/asur/software/jellyfish/bin/jellyfish count -C -m 21 -s 25G -t 28 -o ~/reads.jf <(zcat /gscratch/stf/asur/fastq_data/yeast/yeast_50x.fastq.gz)

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
