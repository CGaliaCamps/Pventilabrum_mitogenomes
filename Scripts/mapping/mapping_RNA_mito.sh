#!/bin/bash
#SBATCH -t 0-06:00:00 # execution time
#SBATCH -N 1 #number of nodes
#SBATCH -c 40    #number of cores max 64 per node
#SBATCH --mem=100Gb
#SBATCH -J bwa-mem


module load cesga/2020 gcccore/system bwa/0.7.17 samtools/1.19

MITOPATH=/mnt/lustre/scratch/nlsas/home/csic/bbe/stm/Carles/Phakellia_mitogenomes/1mitochondrial_genomes/
READS=/mnt/lustre/scratch/nlsas/home/csic/bbe/stm/Carles/Phakellia_mitogenomes/0RNAseq/filtered_reads
OUTPUT=/mnt/lustre/scratch/nlsas/home/csic/bbe/stm/Carles/Phakellia_mitogenomes/1mitochondrial_genomes/RNA_backmap/

###Map your reads###
cd $MITOPATH

for file in *fasta;

        do
		name=${file%.fasta}


		#index your mitogenome
		bwa index $MITOPATH/$name.fasta

                ###map, sort, save and index your bam alignment###
                bwa mem $file ${READS}/SRR10246249_forward_paired.fq ${READS}/SRR10246249_reverse_paired.fq -t 40 -M  > ${OUTPUT}/$name\_map.sam
                samtools view -S -b ${OUTPUT}/$name\_map.sam > ${OUTPUT}/$name\_map.bam
                rm ${OUTPUT}/$name\_map.sam
                samtools sort ${OUTPUT}/$name\_map.bam > ${OUTPUT}/$name\_sorted.bam
                rm ${OUTPUT}/$name\_map.bam
                samtools index ${OUTPUT}/$name\_sorted.bam

		#calculate coverage per position
                samtools depth ${OUTPUT}/$name\_sorted.bam > ${OUTPUT}/$name.coverage
        done


