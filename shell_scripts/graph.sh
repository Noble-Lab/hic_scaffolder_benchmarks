#!/bin/bash
## Job Name
#SBATCH --job-name=graph

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition=compute

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=20
#SBATCH --time=6:00:00

## Memory per node
#SBATCH --mem=85G

echo "Run on `date`."
# Start Time
SECONDS=0

# Modules.
module load stf/samtools

assembly=paxillaris
size_file="/gscratch/scrubbed/asur/results/index_results/${assembly}/sizes.txt"
alignment_file="/gscratch/scrubbed/asur/results/alignment_results/${assembly}/${assembly}_alpha.bam"

# Create the bed file. 
python ~/scripts/main/utils/bed.py \
	-i $size_file \
	-o "${assembly}_graph.bed"

# Create the cooler file.
pairtools parse \
    --assembly $assembly \
    --chroms-path $size_file \
    --drop-sam \
    --nproc-in 20 \
    --nproc-out 20 \
    $alignment_file  | \
pairtools dedup \
    --nproc-in 20 \
    --nproc-out 20 \
    --mark-dups | \
pairtools select \
    --nproc-in 20 \
    --nproc-out 20 \
    "(pair_type=='UU') or (pair_type=='UR') or (pair_type=='RU')" | \
cooler cload pairs \
    --assembly $assembly \
    -c1 2 \
    -p1 3 \
    -c2 4 \
    -p2 5 \
    "${assembly}_graph.bed" \
    - \
    "${assembly}_graph.cool"

rm "${assembly}_graph.bed"

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
