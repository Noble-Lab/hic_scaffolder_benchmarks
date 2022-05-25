#!/bin/bash
## Job Name
#SBATCH --job-name=purge_dups

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition=compute

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=40
#SBATCH --time=6:00:00

## Memory per node
#SBATCH --mem=175G

echo "Run on `date`."
# Start Time
SECONDS=0

module load stf/purge_dups

pri_asm=masurca_uncorrected_all_primary
reads=/gscratch/scrubbed/asur/data/genome_data/egracilis/egracilis_long_corrected.fasta.gz

# Step 0
minimap2 -t 40 -xmap-pb $pri_asm.fasta $reads | gzip -c - > $pri_asm.paf.gz
pbcstat *.paf.gz 
calcuts PB.stat > cutoffs 2>calcults.log

# Step 1
split_fa $pri_asm.fasta > $pri_asm.split
minimap2 -t 40 -xasm5 -DP $pri_asm.split $pri_asm.split | gzip -c - > $pri_asm.split.self.paf.gz

# Step 2
purge_dups -2 -T cutoffs -c PB.base.cov $pri_asm.split.self.paf.gz > dups.bed 2> purge_dups.log

# Step 3
get_seqs -e dups.bed $pri_asm.fasta 

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
