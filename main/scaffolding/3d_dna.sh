#!/bin/bash
## Job Name
#SBATCH --job-name=3d-dna

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
#	medium_queue
#	medium_queue_cores
#	medium_queue_time
#	medium_queue_mem
#	debug_directory
#	results_directory
#	juicer_file
#	assembly_file
#	3d_dna_path
#	project_name

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
ln -f {juicer_file} merged_nodups.txt
ln -f {assembly_file} assembly.fasta

# Run scaffolding.
singularity run \
	--bind $PWD:/root/results \
	--home $PWD:/root/results \
	{3d_dna_path} \
	3d-dna \
	assembly.fasta \
	merged_nodups.txt

# Rename. 
mv assembly.rawchrom.assembly ../{project_name}_3d_dna.assembly
mv assembly.rawchrom.hic ../{project_name}_3d_dna.hic
mv assembly.FINAL.fasta ../{project_name}_3d_dna.fasta

# Make AGP.
python {main_directory}/scaffolding/3d_dna.py \
	--input {results_directory}/run/assembly.FINAL.assembly \
	--output {results_directory}/{project_name}_3d_dna.agp

# Cleanup.
rm -rf {results_directory}/run

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
echo "Seconds: ${SECONDS}"
