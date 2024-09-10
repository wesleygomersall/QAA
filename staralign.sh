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

/usr/bin/time -v STAR --runThreadN 8 --runMode genomeGenerate \
	--genomeDir Mus_musculus.GRCm39.dna_ens112_STAR2.7.10b \
	--genomeFastaFiles mmu/Mus_musculus.GRCm39.dna.primary_assembly.fa \
	--sjdbGTFfile Mus_musculus.GRCm39.112.gtf

/usr/bin/time -v STAR --runThreadN 8 --runMode alignReads \
	--outFilterMultimapNmax 3 \
	--outSAMunmapped Within KeepPairs \
	--alignIntronMax 1000000 --alignMatesGapMax 1000000 \
	--readFilesCommand zcat \
	--readFilesIn $S1_READ1 $S1_READ2 \
	--genomeDir Mus_musculus.GRCm39.dna_ens112_STAR2.7.10b \
	--outFileNamePrefix ./mmu/27_

/usr/bin/time -v STAR --runThreadN 8 --runMode alignReads \
	--outFilterMultimapNmax 3 \
	--outSAMunmapped Within KeepPairs \
	--alignIntronMax 1000000 --alignMatesGapMax 1000000 \
	--readFilesCommand zcat \
	--readFilesIn $S2_READ1 $S2_READ2 \
	--genomeDir Mus_musculus.GRCm39.dna_ens112_STAR2.7.10b \
	--outFileNamePrefix ./mmu/32_

/usr/bin/time -v htseq-count --stranded=yes -q mmu/27_Aligned.out.sam Mus_musculus.GRCm39.112.gtf > htseqout/27_str_count.txt 
/usr/bin/time -v htseq-count --stranded=reverse -q mmu/27_Aligned.out.sam Mus_musculus.GRCm39.112.gtf > htseqout/27_rstr_count.txt 

/usr/bin/time -v htseq-count --stranded=yes -q mmu/32_Aligned.out.sam Mus_musculus.GRCm39.112.gtf > htseqout/32_str_count.txt 
/usr/bin/time -v htseq-count --stranded=reverse -q mmu/32_Aligned.out.sam Mus_musculus.GRCm39.112.gtf > htseqout/32_rstr_count.txt 

conda deactivate
conda activate bgmp_py312 
conda list 

/usr/bin/time -v ./countmappedSAM.py -i mmu/27_Aligned.out.sam
/usr/bin/time -v ./countmappedSAM.py -i mmu/32_Aligned.out.sam 

conda deactivate
