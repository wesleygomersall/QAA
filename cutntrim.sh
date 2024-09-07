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

S1R1='/projects/bgmp/shared/file1_r1'
S1R2='/projects/bgmp/shared/file1_r2'
S2R1='/projects/bgmp/shared/file2_r1'
S2R2='/projects/bgmp/shared/file2_r2'

ADAPTR1='AGATCGGAAGAGCACACGTCTGAACTCCAGTCA'
ADAPTR2='AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT'

# cutadapt file 1
# cutadapt file 2

# trimmomatic file 1
# trimmomatic file 2

# custom python plot sample 1 R1 and R2
# custom python plot sample 2 R1 and R2

# FastQC sample 1 R1 and R2 
# FastQC sample 2 R1 and R2 

conda deactivate

