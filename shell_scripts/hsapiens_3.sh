#!/bin/bash

################################### 3d-dna #####################################

# 10x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_10x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method 3d-dna

# 20x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_20x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method 3d-dna

# 30x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method 3d-dna

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 50 \
    --method 3d-dna

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 10 \
    --method 3d-dna

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 5 \
    --method 3d-dna

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 1 \
    --method 3d-dna

# 40x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_40x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method 3d-dna

# 50x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_50x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method 3d-dna

# 60x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_60x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method 3d-dna

# 70x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_70x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method 3d-dna

# 80x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_80x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method 3d-dna

# 90x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_90x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method 3d-dna

# 100x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_100x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method 3d-dna

# 10kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_10kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method 3d-dna

# 50kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_50kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method 3d-dna

# 100kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method 3d-dna

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 50 \
    --method 3d-dna

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 10 \
    --method 3d-dna

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 5 \
    --method 3d-dna

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 1 \
    --method 3d-dna

# 500kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_500kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method 3d-dna

# 1mb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_1mb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method 3d-dna

################################### Hirise #####################################

# 10x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_10x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method hirise

# 20x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_20x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method hirise

# 30x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method hirise

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 50 \
    --method hirise

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 10 \
    --method hirise

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 5 \
    --method hirise

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 1 \
    --method hirise

# 40x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_40x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method hirise

# 50x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_50x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method hirise

# 60x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_60x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method hirise

# 70x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_70x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method hirise

# 80x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_80x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method hirise

# 90x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_90x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method hirise

# 100x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_100x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method hirise

# 10kb Assembly

# python ~/scripts/main/submit.py \
#     --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_10kb.fasta \
#     --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
#     --coverage 100 \
#     --method hirise

# 50kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_50kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method hirise

# 100kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method hirise

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 50 \
    --method hirise

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 10 \
    --method hirise

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 5 \
    --method hirise

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 1 \
    --method hirise

# 500kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_500kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method hirise

# 1mb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_1mb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method hirise

#################################### Salsa #####################################

# 10x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_10x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method salsa

# 20x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_20x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method salsa

# 30x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method salsa

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 50 \
    --method salsa

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 10 \
    --method salsa

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 5 \
    --method salsa

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 1 \
    --method salsa

# 40x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_40x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method salsa

# 50x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_50x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method salsa

# 60x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_60x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method salsa

# 70x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_70x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method salsa

# 80x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_80x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method salsa

# 90x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_90x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method salsa

# 100x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_100x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method salsa

# 10kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_10kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method salsa

# 50kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_50kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method salsa

# 100kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method salsa

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 50 \
    --method salsa

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 10 \
    --method salsa

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 5 \
    --method salsa

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 1 \
    --method salsa

# 500kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_500kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method salsa

# 1mb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_1mb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method salsa

#################################### AllHiC #####################################

# 10x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_10x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method allhic \
    --n-chromosomes 23

# 20x Assembly

# python ~/scripts/main/submit.py \
#     --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_20x.fasta \
#     --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
#     --coverage 100 \
#     --method allhic \
#     --n-chromosomes 23

# 30x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method allhic \
    --n-chromosomes 23

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 50 \
    --method allhic \
    --n-chromosomes 23

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 10 \
    --method allhic \
    --n-chromosomes 23

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 5 \
    --method allhic \
    --n-chromosomes 23

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 1 \
    --method allhic \
    --n-chromosomes 23

# 40x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_40x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method allhic \
    --n-chromosomes 23

# 50x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_50x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method allhic \
    --n-chromosomes 23

# 60x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_60x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method allhic \
    --n-chromosomes 23

# 70x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_70x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method allhic \
    --n-chromosomes 23

# 80x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_80x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method allhic \
    --n-chromosomes 23

# 90x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_90x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method allhic \
    --n-chromosomes 23

# 100x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_100x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method allhic \
    --n-chromosomes 23

# 10kb Assembly

# python ~/scripts/main/submit.py \
#     --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_10kb.fasta \
#     --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
#     --coverage 100 \
#     --method allhic \
#     --n-chromosomes 23

# 50kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_50kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method allhic \
    --n-chromosomes 23

# 100kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method allhic \
    --n-chromosomes 23

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 50 \
    --method allhic \
    --n-chromosomes 23

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 10 \
    --method allhic \
    --n-chromosomes 23

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 5 \
    --method allhic \
    --n-chromosomes 23

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 1 \
    --method allhic \
    --n-chromosomes 23

# 500kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_500kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method allhic \
    --n-chromosomes 23

# 1mb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_1mb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method allhic \
    --n-chromosomes 23

################################### Lachesis ###################################


# 10x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_10x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method lachesis \
    --n-chromosomes 23

# 20x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_20x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method lachesis \
    --n-chromosomes 23

# 30x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method lachesis \
    --n-chromosomes 23

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 50 \
    --method lachesis \
    --n-chromosomes 23

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 10 \
    --method lachesis \
    --n-chromosomes 23

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 5 \
    --method lachesis \
    --n-chromosomes 23

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 1 \
    --method lachesis \
    --n-chromosomes 23

# 40x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_40x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method lachesis \
    --n-chromosomes 23

# 50x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_50x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method lachesis \
    --n-chromosomes 23

# 60x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_60x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method lachesis \
    --n-chromosomes 23

# 70x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_70x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method lachesis \
    --n-chromosomes 23

# 80x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_80x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method lachesis \
    --n-chromosomes 23

# 90x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_90x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method lachesis \
    --n-chromosomes 23

# 100x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_100x.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method lachesis \
    --n-chromosomes 23

# 10kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_10kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method lachesis \
    --n-chromosomes 23

# 50kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_50kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method lachesis \
    --n-chromosomes 23

# 100kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method lachesis \
    --n-chromosomes 23

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 50 \
    --method lachesis \
    --n-chromosomes 23

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 10 \
    --method lachesis \
    --n-chromosomes 23

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 5 \
    --method lachesis \
    --n-chromosomes 23

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 1 \
    --method lachesis \
    --n-chromosomes 23

# 500kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_500kb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method lachesis \
    --n-chromosomes 23

# 1mb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_1mb.fasta \
    --reference /gscratch/scrubbed/asur/data/reference_genomes/hsapiens_genome.fasta \
    --coverage 100 \
    --method lachesis \
    --n-chromosomes 23