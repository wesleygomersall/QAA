#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=4
#SBATCH --mem=16GB
#SBATCH --time=0-3 
#SBATCH --mail-user=wesg@uoregon.edu
#SBATCH --mail-type=END

conda activate QAA
conda list 

/usr/bin/time -v fastqc -o /projects/bgmp/wesg/bioinfo/Bi623/QAA/fqcout_raw --noextract -f fastq 27_4C_mbnl_S19_L008_R1_001.fastq.gz

/usr/bin/time -v fastqc -o /projects/bgmp/wesg/bioinfo/Bi623/QAA/fqcout_raw --noextract -f fastq 27_4C_mbnl_S19_L008_R2_001.fastq.gz

/usr/bin/time -v fastqc -o /projects/bgmp/wesg/bioinfo/Bi623/QAA/fqcout_raw --noextract -f fastq 32_4G_both_S23_L008_R1_001.fastq.gz 

/usr/bin/time -v fastqc -o /projects/bgmp/wesg/bioinfo/Bi623/QAA/fqcout_raw --noextract -f fastq 32_4G_both_S23_L008_R2_001.fastq.gz 

## WIP: 

# now create the plots from demultiplex (copy that python script over to this dir) 

# run that scipt on each of these files. 

# use `/usr/bin/time -v` command to compare the performance of this algorithm compared to fastqc. 
