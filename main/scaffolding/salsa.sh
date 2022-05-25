#!/bin/bash
## Job Name
#SBATCH --job-name=salsa

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
#	medium_queue_cores
#   medium_queue_time
#	medium_queue_mem
#   debug_directory
#	results_directory
#	alignment_file
#	assembly_file
#	enzyme

echo "Run on `date`."
# Start Time
SECONDS=0

# Modules.
module load singularity
module load stf/samtools
module load stf/bedtools

# Directory.
rm -rf {results_directory}/run
mkdir -p {results_directory}/run
cd {results_directory}/run

# Link files.
ln {alignment_file} alignment.bam
ln {assembly_file} assembly.fasta

# Index assembly.
samtools faidx \
    assembly.fasta

# Bam to bed. 
bedtools bamtobed \
    -i alignment.bam | \
    sort -k 4 > \
    alignment.bed

# Scaffolding.
singularity run \
	--bind $PWD:/root/results \
	--home $PWD:/root/results \
	~/software/salsa/salsa_latest.sif \
	salsa \
	-a assembly.fasta \
	-l assembly.fasta.fai \
	-b alignment.bed \
	-e {enzyme} \
	-o scaffolds

# Rename.
mv {results_directory}/run/scaffolds/scaffolds_FINAL.agp {results_directory}/{project_name}_salsa.agp
mv {results_directory}/run/scaffolds/scaffolds_FINAL.fasta {results_directory}/{project_name}_salsa.fasta

# Cleanup.
rm -rf {results_directory}/run

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
echo "Seconds: ${SECONDS}"