#!/bin/bash
#SBATCH -t 0-06:00:00 # execution time
#SBATCH -N 1 #number of nodes
#SBATCH -c 40    #number of cores max 64 per node
#SBATCH --mem=40Gb
#SBATCH -J iqtree

iqtree=/mnt/lustre/scratch/nlsas/home/csic/bbe/stm/software/iqtree2/build/iqtree2

cd /mnt/lustre/scratch/nlsas/home/csic/bbe/stm/Carles/Phakellia_mitogenomes/3phylogenies

for part in *.nex;
	do
		base=${part%%.nex}
		$iqtree -p $part -m GTR+I+G -nt AUTO -bnni --runs 10 -B 10000 -o NC_010496.1 -redo -pre $base
	done


for part in *.fasta;
        do
                base=${part%%.fasta}
                $iqtree -s $part -m GTR+I+G -nt AUTO -bnni --runs 10 -B 10000 -o NC_010496.1 -redo -pre $base
        done
