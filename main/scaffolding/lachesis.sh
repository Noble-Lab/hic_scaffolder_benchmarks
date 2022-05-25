#!/bin/bash
## Job Name
#SBATCH --job-name=lachesis

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition={medium_queue}

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node={medium_queue_cores}
#SBATCH --time={medium_queue_time}

## Memory per Node
#SBATCH --mem={medium_queue_mem}

## Ouput
#SBATCH --output={debug_directory}/scaffold_%j.out

# Parameters - 
#   medium_queue
#   medium_queue_time
#   debug_directory
#   run_directory
#   assembly_file  
#   alignment_file
#   python_path
#   scripts_directory
#   project_name
#   n_chromosomes
#   enzyme

echo "Run on `date`."
# Start Time
SECONDS=0

# Modules.
module load singularity

# Directory.
rm -rf {results_directory}/run
mkdir -p {results_directory}/run
cd {results_directory}/run

# Link files.
ln {assembly_file} assembly.fasta
ln {alignment_file} alignment.bam
cp {main_directory}/scaffolding/lachesis.ini configuration.ini

# Edit config file. 
sed -i 's/enzyme/{enzyme}/g' configuration.ini
sed -i 's/chromosomes/{n_chromosomes}/g' configuration.ini

# Run scaffolding.
singularity run \
    --bind {results_directory}/run:/root \
    --home {results_directory}/run:/root \
    {lachesis_path} \
    lachesis \
    /root/configuration.ini   

# Make FASTA. 
singularity run \
    --bind {results_directory}/run:/root \
    --home {results_directory}/run:/root \
    {lachesis_path} \
    perl \
    /usr/local/bin/CreateScaffoldedFasta.pl \
    /root/assembly.fasta \
    /root/results

# Make AGP.
python {main_directory}/scaffolding/lachesis.py \
    --input results/main_results \
    --output {results_directory}/{project_name}_lachesis.agp \
    --assembly assembly.fasta

# Cleanup.
mv results/Lachesis_assembly.fasta {results_directory}/{project_name}_lachesis.fasta
rm -rf {results_directory}/run
    
# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
echo "Seconds: ${SECONDS}"