#!/bin/bash
#SBATCH -t 0-06:00:00 # execution time
#SBATCH -N 1 #number of nodes
#SBATCH -c 40    #number of cores max 64 per node
#SBATCH --mem=40Gb
#SBATCH -J bwa-mem


module load cesga/2020 gcccore/system bwa/0.7.17 samtools/1.19

MITOPATH=/mnt/lustre/scratch/nlsas/home/csic/bbe/stm/Carles/Phakellia_mitogenomes/1mitochondrial_genomes/
READS=/mnt/lustre/scratch/nlsas/home/csic/bbe/stm/Carles/Phakellia_WGS/1filtdata/paired/Phakellia/
OUTPUT=/mnt/lustre/scratch/nlsas/home/csic/bbe/stm/Carles/Phakellia_mitogenomes/1mitochondrial_genomes/DNA_backmap/

###Map your reads###
cd $READS

for file in *_forward_paired.fq;

        do
                base=${file%_forward*}
		name=${base%_EKDN*}


		#index your mitogenome
		bwa index $MITOPATH/$name.fasta

                ###map, sort, save and index your bam alignment###
                bwa mem $MITOPATH/$name.fasta ${READS}/$base\_forward_paired.fq ${READS}/$base\_reverse_paired.fq -t 40 -M  > ${OUTPUT}/$name\_map.sam
                samtools addreplacerg ${OUTPUT}/$name\_map.sam -r ID:$name -r SM:$name > ${OUTPUT}/$name\_rg.sam
                rm ${OUTPUT}/$name\_map.sam
                samtools view -S -b ${OUTPUT}/$name\_rg.sam > ${OUTPUT}/$name\_rg.bam
                rm ${OUTPUT}/$name\_rg.sam
                samtools sort ${OUTPUT}/$name\_rg.bam > ${OUTPUT}/$name\_sorted.bam
                rm ${OUTPUT}/$name\_rg.bam
                samtools index ${OUTPUT}/$name\_sorted.bam

		#calculate coverage per position
		samtools depth ${OUTPUT}/$name\_sorted.bam > ${OUTPUT}/$name.coverage
        done


