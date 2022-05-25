#!/bin/bash

gunzip -c egracilis_illumina.fastq.gz | \
    awk 'NR % 4 == 2' | \
    tr NT TN | \
    ropebwt2 -LR | \
    tr NT TN | \
    fmlrc2-convert illumina.npy 

fmlrc2 \
    --threads 40 \
    --cache_size 12 \
    illumina.npy \
    egracilis_pacbio.fastq.gz \
    egracilis_pacbio_corrected.fasta
