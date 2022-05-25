#!/bin/bash

## Job Name
#SBATCH --job-name={job_name}

## Allocation
#SBATCH --account=stf
#SBATCH --partition=build

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=1
#SBATCH --time=8:00:00
#SBATCH --mem=8G

## Directory
#SBATCH --chdir={directory}
#SBATCH --output={directory}/slurm-%A.out

# Start Time
echo "Run on `date`."
SECONDS=0

python execute_download.py --input {input_name} --directory {directory}

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."

rm {input_name}
rm {script}