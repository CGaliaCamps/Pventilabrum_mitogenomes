#!/bin/bash

SEQ=/mnt/lustre/scratch/nlsas/home/csic/bbe/stm/Carles/Phakellia_WGS/1filtered
MITOFOLD=/mnt/lustre/scratch/nlsas/home/csic/bbe/stm/Carles/Phakellia_WGS/2mitogenomes

cd $SEQ

for file in *1_trimmed.fq.gz;

        do
                base=${file%%_1_trimmed.fq.gz}
		name=${base%_EKDN*}

                echo $name >> $MITOFOLD/batch_file.txt
                echo $SEQ/$base\_1_trimmed.fq.gz >> $MITOFOLD/batch_file.txt
                echo $SEQ/$base\_2_trimmed.fq.gz >> $MITOFOLD/batch_file.txt
        done


