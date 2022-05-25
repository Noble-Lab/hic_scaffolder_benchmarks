#!/bin/bash
## Job Name
#SBATCH --job-name=allhic

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
#   medium_queue_cores
#   medium_queue_time
#   medium_queue_mem
#   debug_directory
#   allhic_path

echo "Run on `date`."
# Start Time
SECONDS=0

# Directory.
rm -rf {results_directory}/run
mkdir -p {results_directory}/run
cd {results_directory}/run

# Link files.
chromosomes={n_chromosomes}
ln {alignment_file} alignment.bam
ln {assembly_file} assembly.fasta

# Run preprocessing and clustering.
{allhic_path} extract alignment.bam assembly.fasta
{allhic_path} partition alignment.counts_GATC.txt alignment.pairs.txt $chromosomes

# Run ordering and orientation for each cluster.
for i in $(seq 1 $chromosomes)
do
    echo "Building Group $i"
    echo "alignment.counts_GATC.${chromosomes}g${i}.txt"
    {allhic_path} optimize "alignment.counts_GATC.${chromosomes}g${i}.txt" alignment.clm
done

# Combine all the files.
{allhic_path} build alignment.counts_GATC.${chromosomes}g*.tour assembly.fasta scaffolds.fasta

# Cleanup.
mv scaffolds.agp ../{project_name}_{method}.agp
mv scaffolds.fasta ../{project_name}_{method}.fasta
rm -rf {results_directory}/run

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
echo "Seconds: ${SECONDS}"