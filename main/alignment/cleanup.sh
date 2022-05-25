#!/bin/bash
## Job Name
#SBATCH --job-name=cleanup

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition=ckpt

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=1
#SBATCH --time=1:00:00

## Memory per Node
#SBATCH --mem=1GB

## Ouput
#SBATCH --output=/dev/null

# Parameters - 
#   short_queue
#   debug_directory
#   alignment_directory

echo "Run on `date`."
# Start Time
SECONDS=0

rm -f {alignment_directory}/alignment.sam
rm -f {alignment_directory}/alignment.bam
rm -f {alignment_directory}/{project_name}.sam
rm -f {alignment_directory}/{project_name}_{coverage}x.sam

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."