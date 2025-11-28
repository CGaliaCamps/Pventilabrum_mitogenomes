#!/bin/bash
#SBATCH -t 4-6:00:00 # execution time
#SBATCH -N 1 #number of nodes
#SBATCH -c 64    #number of cores max 64 per node
#SBATCH --mem=100Gb
#SBATCH -J novoplasty

perl /mnt/lustre/scratch/nlsas/home/csic/bbe/stm/software/NOVOPlasty/NOVOPlasty4.3.5.pl \
	-c /mnt/lustre/scratch/nlsas/home/csic/bbe/stm/Carles/Phakellia_WGS/3mitogenomes/Phakellia_config.txt
