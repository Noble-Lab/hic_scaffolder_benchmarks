#!/bin/bash
## Job Name
#SBATCH --job-name=hisat

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition=compute

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=40
#SBATCH --time=24:00:00

## Memory per node
#SBATCH --mem=175G

echo "Run on `date`."
# Start Time
SECONDS=0

module load stf/hisat

hisat2-build masurca_corrected_all_v1_purged_long.fasta masurca_corrected_all_v1_purged_long 

hisat2 \
    -x masurca_corrected_all_v1_purged_long \
    -1 /gscratch/scrubbed/asur/data/genome_data/egracilis/egracilis_rna_R1.fastq.gz \
    -2 /gscratch/scrubbed/asur/data/genome_data/egracilis/egracilis_rna_R2.fastq.gz \
    -k 3 \
    -p 40 \
    -S input.sam

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
