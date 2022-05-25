import pathlib
import sys

sys.path.append('/mmfs1/home/asur/scripts/main')
from utils import agp

def main():
    genome_coverage = '100x'
    print (genome_coverage)
    for method in ['3d_dna', 'allhic', 'hirise', 'lachesis', 'salsa']:
        infile = pathlib.Path(f'/gscratch/scrubbed/asur/results/{method}_results/hsapiens_{genome_coverage}_genome_100x_hic/edit_distance_no_singles/hsapiens_{genome_coverage}_{method}_assembly_no_singles.agp')
        if infile.exists():
            assembly = agp.read(infile)
            
            total = 0
            for scaffold in assembly:
                for contig in assembly[scaffold]:
                    total += assembly[scaffold][contig]['end'] 

            print (method)
            print (total)

main()