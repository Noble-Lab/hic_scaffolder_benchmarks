#!/bin/bash

################################## Downsample ##################################

# 10x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_10x.fasta \
    --coverage 100

# 20x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_20x.fasta \
    --coverage 100

# 30x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --coverage 100

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --coverage 50

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --coverage 10

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --coverage 5

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_30x.fasta \
    --coverage 1

# 40x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_40x.fasta \
    --coverage 100

# 50x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_50x.fasta \
    --coverage 100

# 60x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_60x.fasta \
    --coverage 100

# 70x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_70x.fasta \
    --coverage 100

# 80x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_80x.fasta \
    --coverage 100

# 90x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_90x.fasta \
    --coverage 100

# 100x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/hsapiens/hsapiens_100x.fasta \
    --coverage 100

# 10kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_10kb.fasta \
    --coverage 100

# 50kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_50kb.fasta \
    --coverage 100

# 100kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --coverage 100

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --coverage 50 

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --coverage 10

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --coverage 5

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_100kb.fasta \
    --coverage 1

# 500kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_500kb.fasta \
    --coverage 100

# 1mb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/hsapiens/hsapiens_1mb.fasta \
    --coverage 100

