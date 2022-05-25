#!/bin/bash
## Job Name
#SBATCH --job-name=alignment

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition=ckpt

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=40
#SBATCH --time=6:00:00

## Memory per Node
#SBATCH --mem=175G

## Ouput
#SBATCH --output=alignment_%j.out

echo "Run on `date`."
# Start Time
SECONDS=0

# Modules.
module load stf/bwa
module load stf/samtools

# Variables.
species=ltarentolae
assembly=ltarentolae_seattle_corrected
index_file="/gscratch/scrubbed/asur/results/index_results/${assembly}/${assembly}.fasta"
read_file="/gscratch/scrubbed/asur/data/genome_data/${species}/${species}_illumina.fastq.gz"

# Alignment. 
bwa mem \
    -t 40 \
    $index_file \
    $read_file > \
    alignment.sam

samtools sort \
    -@ 40 \
    -m 4G \
    -o alignment_sort.bam \
    alignment.sam

samtools depth \
    -@ 40 \
    -aa \
    -o coverage.txt \
    alignment_sort.bam

rm alignment.sam

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
