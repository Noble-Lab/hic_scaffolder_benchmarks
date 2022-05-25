#!/bin/bash
## Job Name
#SBATCH --job-name=gzip

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition=compute

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=20
#SBATCH --time=1:00:00

## Memory per node
#SBATCH --mem=80G

echo "Run on `date`."
# Start Time
SECONDS=0

module load stf/pigz

pigz -p 20 cfasciculata_pacbio.fasta

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
