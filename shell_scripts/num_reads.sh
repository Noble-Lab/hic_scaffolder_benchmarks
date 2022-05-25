#!/bin/bash

## Job Name
#SBATCH --job-name=reads

## Allocation
#SBATCH --account=stf
#SBATCH --partition=compute

## Resources
#SBATCH --nodes=1      
#SBATCH --ntasks-per-node=1
#SBATCH --time=24:00:00
#SBATCH --mem=4G

echo "Run on `date`."

# Start Time
SECONDS=0

zgrep . JM365.fastq.gz |
     awk 'NR%4==2{c++; l+=length($0)}
          END{
                print "Number of reads: "c; 
                print "Number of bases in reads: "l
              }'

# End Time
echo "$((${SECONDS}/3600)) hours $((${SECONDS}%3600/60)) minutes and $((${SECONDS}%60)) seconds elapsed."
