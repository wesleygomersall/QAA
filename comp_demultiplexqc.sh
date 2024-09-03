#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=4
#SBATCH --mem=16GB
#SBATCH --time=0-3 
#SBATCH --mail-user=wesg@uoregon.edu
#SBATCH --mail-type=END

cd /projects/bgmp/shared/2017_sequencing/demultiplexed

conda activate QAA
conda list 

/usr/bin/time -v fastqc -o /projects/bgmp/wesg/bioinfo/Bi623/QAA/fqcout_raw --noextract -f fastq 27_4C_mbnl_S19_L008_R1_001.fastq.gz

/usr/bin/time -v fastqc -o /projects/bgmp/wesg/bioinfo/Bi623/QAA/fqcout_raw --noextract -f fastq 27_4C_mbnl_S19_L008_R2_001.fastq.gz

/usr/bin/time -v fastqc -o /projects/bgmp/wesg/bioinfo/Bi623/QAA/fqcout_raw --noextract -f fastq 32_4G_both_S23_L008_R1_001.fastq.gz 

/usr/bin/time -v fastqc -o /projects/bgmp/wesg/bioinfo/Bi623/QAA/fqcout_raw --noextract -f fastq 32_4G_both_S23_L008_R2_001.fastq.gz 

conda deactivate

conda activate bgmp_py312
conda list
 
/usr/bin/time -v ./mean_qual.py -i 27_4C_mbnl_S19_L008_R1_001.fastq.gz -o /projects/bgmp/wesg/bioinfo/Bi623/QAA/fqcout_raw/27_R1_myplot.png

/usr/bin/time -v ./mean_qual.py -i 27_4C_mbnl_S19_L008_R2_001.fastq.gz -o /projects/bgmp/wesg/bioinfo/Bi623/QAA/fqcout_raw/27_R2_myplot.png

/usr/bin/time -v ./mean_qual.py -i 32_4G_both_S23_L008_R1_001.fastq.gz -o /projects/bgmp/wesg/bioinfo/Bi623/QAA/fqcout_raw/32_R1_myplot.png

/usr/bin/time -v ./mean_qual.py -i 32_4G_both_S23_L008_R2_001.fastq.gz -o /projects/bgmp/wesg/bioinfo/Bi623/QAA/fqcout_raw/32_R2_myplot.png

conda deactivate

cd /projects/bgmp/wesg/bioinfo/Bi623/QAA
