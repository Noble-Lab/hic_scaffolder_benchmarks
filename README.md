# Benchmarking Hi-C Scaffolders

This repository contains all the scripts used to benchmark popular Hi-C scaffolders. As part of the study, we created docker containers of [Lachesis](https://hub.docker.com/repository/docker/aakashsur/lachesis), [HiRise](https://hub.docker.com/repository/docker/aakashsur/hirise), [3d-dna](https://hub.docker.com/repository/docker/aakashsur/3d-dna), and [Salsa](https://hub.docker.com/repository/docker/aakashsur/salsa). 

## Align
```
python main/submit.py \
    --assembly assembly.fasta \
    --read-1 R1.fastq.gz \
    --read-2 R2.fastq.gz
```

## Downsample
```
python main/submit.py \
    --assembly assembly.fasta \
    --coverage 100
```
## Scaffold
```
python ~/scripts/main/submit.py \
    --assembly assembly.fasta \
    --reference reference.fasta \
    --coverage 100 \
    --method 3d-dna
