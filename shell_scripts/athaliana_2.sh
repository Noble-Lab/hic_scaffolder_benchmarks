#!/bin/bash

################################## Downsample ##################################

# 10x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/athaliana/athaliana_10x.fasta \
    --coverage 100

# 20x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/athaliana/athaliana_20x.fasta \
    --coverage 1000

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/athaliana/athaliana_20x.fasta \
    --coverage 500

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/athaliana/athaliana_20x.fasta \
    --coverage 100

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/athaliana/athaliana_20x.fasta \
    --coverage 50

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/athaliana/athaliana_20x.fasta \
    --coverage 10

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/athaliana/athaliana_20x.fasta \
    --coverage 5

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/athaliana/athaliana_20x.fasta \
    --coverage 1

# 30x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/athaliana/athaliana_30x.fasta \
    --coverage 100

# 40x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/athaliana/athaliana_40x.fasta \
    --coverage 100

# 50x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/athaliana/athaliana_50x.fasta \
    --coverage 100

# 60x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/athaliana/athaliana_60x.fasta \
    --coverage 100

# 70x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/athaliana/athaliana_70x.fasta \
    --coverage 100

# 80x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/athaliana/athaliana_80x.fasta \
    --coverage 100

# 90x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/athaliana/athaliana_90x.fasta \
    --coverage 100

# 100x Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/assembly_genomes/athaliana/athaliana_100x.fasta \
    --coverage 100

# 10kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/athaliana/athaliana_10kb.fasta \
    --coverage 100

# 50kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/athaliana/athaliana_50kb.fasta \
    --coverage 100

# 100kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/athaliana/athaliana_100kb.fasta \
    --coverage 1000

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/athaliana/athaliana_100kb.fasta \
    --coverage 500

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/athaliana/athaliana_100kb.fasta \
    --coverage 100

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/athaliana/athaliana_100kb.fasta \
    --coverage 50 

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/athaliana/athaliana_100kb.fasta \
    --coverage 10

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/athaliana/athaliana_100kb.fasta \
    --coverage 5

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/athaliana/athaliana_100kb.fasta \
    --coverage 1

# 500kb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/athaliana/athaliana_500kb.fasta \
    --coverage 100

# 1mb Assembly

python ~/scripts/main/submit.py \
    --assembly /gscratch/scrubbed/asur/data/split_genomes/athaliana/athaliana_1mb.fasta \
    --coverage 100