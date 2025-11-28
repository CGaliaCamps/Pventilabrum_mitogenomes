#!/bin/bash
#SBATCH -t 0-06:00:00 # execution time
#SBATCH -N 1 #number of nodes
#SBATCH -c 64    #number of cores max 64 per node
#SBATCH --mem=170Gb
#SBATCH -J Trimmomatic

module load cesga/2020 trimmomatic/0.39

INPATH=/mnt/lustre/scratch/nlsas/home/csic/bbe/stm/Carles/Phakellia_mitogenomes/0RNAseq/raw_reads
OUTPATH=/mnt/lustre/scratch/nlsas/home/csic/bbe/stm/Carles/Phakellia_mitogenomes/0RNAseq/filtered_reads
EXTENSION=fastq

#gunzip ${INPATH}/*.gz

cd ${INPATH}

for file in  *_1.${EXTENSION};
	do
		name=${file%_*}
		java -jar $CLASSPATH PE -threads 64 -phred33 ${INPATH}/$name\_1.$EXTENSION ${INPATH}/$name\_2.$EXTENSION \
					${OUTPATH}/$name\_forward_paired.fq ${OUTPATH}/$name\_forward_unpaired.fq.gz \
					${OUTPATH}/$name\_reverse_paired.fq ${OUTPATH}/$name\_reverse_unpaired.fq.gz \
					ILLUMINACLIP:/mnt/lustre/scratch/nlsas/home/csic/bbe/stm/Carles/.TruSeq3-PE.fa:2:30:10 \
					LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
	done

#gzip ${INPATH}/*.fq
