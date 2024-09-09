#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=4
#SBATCH --mem=16GB
#SBATCH --time=0-3 
#SBATCH --mail-user=wesg@uoregon.edu
#SBATCH --mail-type=END

conda activate QAA 
mamba list 

S1R1='/projects/bgmp/shared/2017_sequencing/demultiplexed/27_4C_mbnl_S19_L008_R1_001.fastq.gz'
S1R2='/projects/bgmp/shared/2017_sequencing/demultiplexed/27_4C_mbnl_S19_L008_R2_001.fastq.gz'
S2R1='/projects/bgmp/shared/2017_sequencing/demultiplexed/32_4G_both_S23_L008_R1_001.fastq.gz'
S2R2='/projects/bgmp/shared/2017_sequencing/demultiplexed/32_4G_both_S23_L008_R2_001.fastq.gz'

S1NAME='27_4C_mbnl_S19_L008'
S2NAME='32_4G_both_S23_L008' 

ADAPTR1='AGATCGGAAGAGCACACGTCTGAACTCCAGTCA'
ADAPTR2='AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT'

mkdir fqcout_cutntrim
mkdir fqcout_cutntrim/report

# cut adapter sequences from the paired end data.
cutadapt -a $ADAPTR1 -A $ADAPTR2  -o "${S1NAME}.R1.cut.fastq.gz" -p "${S1NAME}.R2.cut.fastq.gz" $S1R1 $S1R2

# quality trimming data
trimmomatic PE "${S1NAME}.R1.cut.fastq.gz" "${S1NAME}.R2.cut.fastq.gz" \
	"${S1NAME}.R1.cut.trim.fastq.gz" "${S1NAME}.R1.cut.orph.trim.fastq.gz" \
	"${S1NAME}.R2.cut.trim.fastq.gz" "${S1NAME}.R2.cut.orph.trim.fastq.gz" \
	LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35

# FastQC on outputs
/usr/bin/time -v fastqc -o /projects/bgmp/wesg/bioinfo/Bi623/QAA/fqcout_cutntrim --noextract -f fastq "${S1NAME}.R1.cut.trim.fastq.gz"
/usr/bin/time -v fastqc -o /projects/bgmp/wesg/bioinfo/Bi623/QAA/fqcout_cutntrim --noextract -f fastq "${S1NAME}.R2.cut.trim.fastq.gz"

################## Second Sample

cutadapt -a $ADAPTR1 -A $ADAPTR2 -o "${S2NAME}.R1.cut.fastq.gz" -p "${S2NAME}.R2.cut.fastq.gz" $S2R1 $S2R2 

trimmomatic PE "${S2NAME}.R1.cut.fastq.gz" "${S2NAME}.R2.cut.fastq.gz" \
	something
	"${S2NAME}.R1.cut.trim.fastq.gz" "${S2NAME}.R1.cut.orph.trim.fastq.gz" \
	"${S2NAME}.R2.cut.trim.fastq.gz" "${S2NAME}.R2.cut.orph.trim.fastq.gz" \
	LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35

/usr/bin/time -v fastqc -o /projects/bgmp/wesg/bioinfo/Bi623/QAA/fqcout_cutntrim --noextract -f fastq "${S2NAME}.R1.cut.trim.fastq.gz"
/usr/bin/time -v fastqc -o /projects/bgmp/wesg/bioinfo/Bi623/QAA/fqcout_cutntrim --noextract -f fastq "${S2NAME}.R2.cut.trim.fastq.gz"

conda deactivate

conda activate bgmp_py.mplib
mamba list

### WIP
# custom python plot samples 1 and 2, R1 and R2
# script name pairedreadlengthdist.py
./pairedreadlengthdist.py -i "${S1NAME}.R1.cut.trim.fastq.gz" -p "${S1NAME}.R2.cut.trim.fastq.gz" -o "${S1NAME}.Rlendist.png"
./pairedreadlengthdist.py -i "${S2NAME}.R1.cut.trim.fastq.gz" -p "${S2NAME}.R2.cut.trim.fastq.gz" -o "${S2NAME}.Rlendist.png"

conda deactivate
