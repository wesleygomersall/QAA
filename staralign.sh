#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --mail-user=wesg@uoregon.edu
#SBATCH --mail-type=END

conda activate QAA
conda list

S1_READ1=/projects/bgmp/wesg/bioinfo/Bi623/QAA/27_4C_mbnl_S19_L008.R1.cut.trim.fastq.gz
S1_READ2=/projects/bgmp/wesg/bioinfo/Bi623/QAA/27_4C_mbnl_S19_L008.R2.cut.trim.fastq.gz
S2_READ1=/projects/bgmp/wesg/bioinfo/Bi623/QAA/32_4G_both_S23_L008.R1.cut.trim.fastq.gz
S2_READ2=/projects/bgmp/wesg/bioinfo/Bi623/QAA/32_4G_both_S23_L008.R2.cut.trim.fastq.gz

Mus_musculus.GRCm39.dna.primary_assembly.fa.gz
Mus_musculus.GRCm39.112.gtf

/usr/bin/time -v STAR --runThreadN 8 --runMode genomeGenerate \
	--genomeDir Mus_musculus.GRCm39.dna_ens112_STAR2.7.10b \
	--genomeFastaFiles mmu/Mus_musculus.GRCm39.dna.primary_assembly.fa.gz \
	--sjdbGTFfile Mus_musculus.GRCm39.112.gtf

# Need to copy this for sample 2
/usr/bin/time -v STAR --runThreadN 8 --runMode alignReads \
	--outFilterMultimapNmax 3 \
	--outSAMunmapped Within KeepPairs \
	--alignIntronMax 1000000 --alignMatesGapMax 1000000 \
	--readFilesCommand zcat \
	--readFilesIn $S1_READ1 $S1_READ2 \
	--genomeDir Mus_musculus.GRCm39.dna_ens112_STAR2.7.10b \
	--outFileNamePrefix ./mmu/27_

conda deactivate
conda activate bgmp_py312 #no python in the last env
conda list 

# ./countmappedSAM.py -i "./dre/Aligned.out.sam" # Part 2

conda deactivate
