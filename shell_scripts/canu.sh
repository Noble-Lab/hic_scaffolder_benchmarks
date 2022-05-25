module load mamslab/jdk/16.0.1
pfaendtner/gnuplot/5.4.1

/mmfs1/home/asur/software/canu/bin/canu \
    -p ldonovani \
    -d /gscratch/scrubbed/asur/assemblies/ldonovani/seattle_corrected \
    -pacbio /gscratch/scrubbed/asur/data/genome_data/ldonovani/ldonovani_196x_corrected.fasta.gz \
    gridOptions="--partition=ckpt --account=stf" \
    stopOnLowCoverage=1 \
    minInputCoverage=1 \
    batMemory=80 \
    batThreads=20 \
    cnsMemory=80 \
    cnsThreads=20 \
    genomeSize=32m

