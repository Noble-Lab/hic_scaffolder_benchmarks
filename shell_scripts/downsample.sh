#!/bin/bash
## Job Name
#SBATCH --job-name=downsample

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition=compute 

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=40
#SBATCH --time=48:00:00

## Memory per node
#SBATCH --mem=750G

# Directory
cd /gscratch/stf/asur/data/hic_data/hsapiens

# Downsample
seqtk sample -s 0 read1.fq 10000 > sub1.fq
seqtk sample -s100 read2.fq 10000 > sub2.fq


~/software/pigz/pigz -p 40 500mil_R1.fastq
~/software/pigz/pigz -p 40 500mil_R2.fastq
