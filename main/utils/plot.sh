#!/bin/bash
## Job Name
#SBATCH --job-name=plot

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition={small_queue}

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=1
#SBATCH --time={small_queue_time}

## Memory per Node
#SBATCH --mem={small_queue_mem}

## Ouput
#SBATCH --output={debug_directory}/plot_%j.out

# Parameters - 
#   small_queue
#   debug_directory
#   main_directory
#   cooler_file

echo "Run on `date`."
# Start Time
SECONDS=0

python {main_directory}/utils/plot.py \
    --input {cooler_file} \
    --scaffolds {assignments_file} \
    --output {plot_file}

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
