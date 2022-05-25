#!/bin/bash
## Job Name
#SBATCH --job-name=p_rna_scaffolder

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition=compute

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=40
#SBATCH --time=24:00:00
#SBATCH --mem=175G

## Only run one job with this job-name at a time
#SBATCH --dependency=singleton

echo "Run on `date`."
# Start Time
SECONDS=0

module load singularity

singularity run \
    --bind $PWD:/root/results \
    --home $PWD:/root/results \
    ~/software/p_rna_scaffolder/p_rna_scaffolder_latest.sif \
    p_rna_scaffolder \
        -d /root/P_RNA_scaffolder \
        -i input.sam \
        -j assembly.fasta \
        -F egracilis_rna_R1.fastq \
        -R egracilis_rna_R2.fastq \
        -t 40

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
