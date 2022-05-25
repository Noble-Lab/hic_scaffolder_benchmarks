#!/bin/bash
## Job Name
#SBATCH --job-name=busco

## Allocation Definition
#SBATCH --account=stf
#SBATCH --partition=compute

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=40
#SBATCH --time=12:00:00

## Memory per node
#SBATCH --mem=175GB

echo "Run on `date`."
# Start Time
SECONDS=0

module load singularity

singularity run \
    --bind $PWD:/busco_wd \
    --home $PWD:/busco_wd \
    /gscratch/scrubbed/asur/results/busco_results/busco_v5.2.2.sif \
    busco \
    --in assembly.fasta \
    --out euglenozoa \
    --mode genome \
    --lineage_dataset euglenozoa \
    --cpu 40

singularity run \
    --bind $PWD:/busco_wd \
    --home $PWD:/busco_wd \
    /gscratch/scrubbed/asur/results/busco_results/busco_v5.2.2.sif \
    busco \
    --in assembly.fasta \
    --out eukaryota \
    --mode genome \
    --lineage_dataset eukaryota \
    --cpu 40

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
