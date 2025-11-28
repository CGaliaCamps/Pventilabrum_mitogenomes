#!/bin/bash
#SBATCH -t 0-06:00:00 # execution time
#SBATCH -N 1 #number of nodes
#SBATCH -c 40    #number of cores max 64 per node
#SBATCH --mem=40Gb
#SBATCH -J bwa-mem


module load cesga/2020 gcccore/system bwa/0.7.17 samtools/1.19

MITOPATH=/mnt/lustre/scratch/nlsas/home/csic/bbe/stm/Carles/Phakellia_mitogenomes/1mitochondrial_genomes/processed/
READS=/mnt/lustre/scratch/nlsas/home/csic/bbe/stm/Carles/Phakellia_WGS/1filtdata/paired/Phakellia/
OUTPUT=/mnt/lustre/scratch/nlsas/home/csic/bbe/stm/Carles/Phakellia_mitogenomes/1mitochondrial_genomes/DNA_backmap/

indv1=Deep_094_05
indv2=NwK_KB_61_2

###Map your reads###

		#index your mitogenome
		bwa index $MITOPATH/${indv1}.fasta

                ###map, sort, save and index your bam alignment###
                bwa mem $MITOPATH/${indv1}.fasta ${READS}/$indv2\_EKDN_forward_paired.fq ${READS}/${indv2}\_EKDN_reverse_paired.fq -t 40 -M  > ${OUTPUT}/ref${indv1}\_read${indv2}\_map.sam
                samtools addreplacerg ${OUTPUT}/ref${indv1}\_read${indv2}\_map.sam -r ID:$name -r SM:$name > ${OUTPUT}/ref${indv1}\_read${indv2}\_rg.sam
                rm ${OUTPUT}/ref${indv1}\_read${indv2}\_map.sam
                samtools view -S -b ${OUTPUT}/ref${indv1}\_read${indv2}\_rg.sam > ${OUTPUT}/ref${indv1}\_read${indv2}\_rg.bam
                rm ${OUTPUT}/ref${indv1}\_read${indv2}\_rg.sam
                samtools sort ${OUTPUT}/ref${indv1}\_read${indv2}\_rg.bam > ${OUTPUT}/ref${indv1}\_read${indv2}\_sorted.bam
                rm ${OUTPUT}/ref${indv1}\_read${indv2}\_rg.bam
                samtools index ${OUTPUT}/ref${indv1}\_read${indv2}\_sorted.bam

		#calculate coverage per position
		samtools depth ${OUTPUT}/ref${indv1}\_read${indv2}\_sorted.bam > ${OUTPUT}/ref${indv1}\_read${indv2}.coverage





		#index your mitogenome
                bwa index $MITOPATH/${indv2}.fasta

                ###map, sort, save and index your bam alignment###
                bwa mem $MITOPATH/${indv2}.fasta ${READS}/$indv1\_EKDN_forward_paired.fq ${READS}/${indv1}\_EKDN_reverse_paired.fq -t 40 -M  > ${OUTPUT}/ref${indv2}\_read${indv1}\_map.sam
                samtools addreplacerg ${OUTPUT}/ref${indv2}\_read${indv1}\_map.sam -r ID:$name -r SM:$name > ${OUTPUT}/ref${indv2}\_read${indv1}\_rg.sam
                rm ${OUTPUT}/ref${indv2}\_read${indv1}\_map.sam
                samtools view -S -b ${OUTPUT}/ref${indv2}\_read${indv1}\_rg.sam > ${OUTPUT}/ref${indv2}\_read${indv1}\_rg.bam
                rm ${OUTPUT}/ref${indv2}\_read${indv1}\_rg.sam
                samtools sort ${OUTPUT}/ref${indv2}\_read${indv1}\_rg.bam > ${OUTPUT}/ref${indv2}\_read${indv1}\_sorted.bam
                rm ${OUTPUT}/ref${indv2}\_read${indv1}\_rg.bam
                samtools index ${OUTPUT}/ref${indv2}\_read${indv1}\_sorted.bam

                #calculate coverage per position
                samtools depth ${OUTPUT}/ref${indv2}\_read${indv1}\_sorted.bam > ${OUTPUT}/ref${indv2}\_read${indv1}.coverage
