#!/bin/bash
## Job Name
#SBATCH --job-name=juicer

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition={big_queue}

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node={big_queue_cores}
#SBATCH --time={big_queue_time}

## Memory per Node
#SBATCH --mem={big_queue_mem}

## Ouput
#SBATCH --output={debug_directory}/juicer_%j.out

# Parameters
#	big_queue, 
#	big_queue_cores
#	big_queue_time
#	big_queue_mem
#	debug_directory
#   alignment_directory
#   project_name
#   coverage
#   main_directory
#   enzyme
#   assembly_file
#   alignment_file
#   index_directory
#	juicer_path
#	project_name

echo "Run on `date`."
# Start Time
SECONDS=0

# Modules.
module load singularity
module load stf/samtools

# Directory.
cd {alignment_directory}
rm -rf {project_name}_{coverage}x_juicer
mkdir -p {project_name}_{coverage}x_juicer
cd {project_name}_{coverage}x_juicer
mkdir fastq

# Make the fragments file.
python {main_directory}/alignment/fragments.py \
    {enzyme} \
    {project_name} \
    {assembly_file}

mv {project_name}_{enzyme}.txt fragments.txt

# Generate fastq reads.
samtools fastq \
    -1 fastq/reads_R1.fastq \
    -2 fastq/reads_R2.fastq \
    {alignment_file}

# Link all the needed files.
ln -f {index_directory}/sizes.txt sizes.txt
ln -f {index_directory}/{project_name}.fasta.amb assembly.fasta.amb
ln -f {index_directory}/{project_name}.fasta.ann assembly.fasta.ann
ln -f {index_directory}/{project_name}.fasta.bwt assembly.fasta.bwt
ln -f {index_directory}/{project_name}.fasta.pac assembly.fasta.pac 
ln -f {index_directory}/{project_name}.fasta.sa assembly.fasta.sa
ln -f {index_directory}/{project_name}.fasta assembly.fasta

# Run Juicer.
singularity run \
    --bind $PWD:/data,$PWD:/juicedir \
    {juicer_path} \
    -g {project_name} \
    -d /data \
    -z /juicedir/assembly.fasta \
    -y /juicedir/fragments.txt \
    -p sizes.txt \
    -s {enzyme} \
    -S early \
    -t {big_queue_cores} 

# Cleanup.
mv aligned/merged_nodups.txt {juicer_file}
cd {alignment_directory}
rm -rf {project_name}_{coverage}x_juicer

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."