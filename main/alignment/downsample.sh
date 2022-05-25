#!/bin/bash
## Job Name
#SBATCH --job-name=downsample

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition={small_queue}

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node={small_queue_cores}
#SBATCH --time={small_queue_time}

## Memory per Node
#SBATCH --mem={small_queue_mem}

## Ouput
#SBATCH --output={debug_directory}/downsample_%j.out

# Parameters - 
#   small_queue
#   small_queue_cores
#   small_queue_time
#   small_queue_mem
#   debug_directory
#   alignment_directory
#   python_path
#   main_directory
#   assembly_file
#   alignment_file
#   alignment_report
#   coverage
#   samtools_path

echo "Run on `date`."
# Start Time
SECONDS=0

# Modules.
module load stf/samtools

# Directory.
cd {alignment_directory}

# Get the sampling rate.
python {main_directory}/alignment/sample_rate.py \
    --input {assembly_file} \
    --alignment final_alignment.json \
    --coverage {coverage} > \
    {project_name}_rate.txt

# Load the sampling rate.
sample_rate=`cat {project_name}_rate.txt`
rm {project_name}_rate.txt
echo "Sample Rate - $sample_rate"

# Down sample.
if [ $sample_rate == 'False' ]; then
    echo "Not enough reads to downsample."
    exit
else
    samtools view \
        -s $sample_rate \
        -h \
        -@ {small_queue_cores} \
        -o {project_name}.sam \
        {alignment_file}
fi

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
