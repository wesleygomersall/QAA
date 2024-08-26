# FastQC 

## 2024-08-22

The objective of this assignment is to use tools for quality assessment, adapter trimming and to compare these to my own software.

For the data I will be using, consult `/projects/bgmp/shared/Bi623/QAA_data_assignments.txt`:
```
$ cat /projects/bgmp/shared/Bi623/QAA_data_assignments.txt
Student	Fileset 1	Fileset 2
Abraham	32_4G_both_S23_L008	3_2B_control_S3_L008
Amelia	2_2B_control_S2_L008	19_3F_fox_S14_L008
Ben	7_2E_fox_S6_L008	Undetermined_S0_L008
Cam	21_3G_both_S15_L008	16_3D_mbnl_S12_L008
Carly	1_2A_control_S1_L008	24_4A_control_S18_L008
Carter	29_4E_fox_S21_L008	11_2H_both_S9_L008
Claire	11_2H_both_S9_L008	14_3B_control_S10_L008
Evan	28_4D_mbnl_S20_L008	2_2B_control_S2_L008
Grace	15_3C_mbnl_S11_L008	17_3E_fox_S13_L008
Jackson	Undetermined_S0_L008	29_4E_fox_S21_L008
Jules	16_3D_mbnl_S12_L008	6_2D_mbnl_S5_L008
Julia	34_4H_both_S24_L008	21_3G_both_S15_L008
Kenneth	6_2D_mbnl_S5_L008	1_2A_control_S1_L008
Lauren	8_2F_fox_S7_L008	22_3H_both_S16_L008
Lena	14_3B_control_S10_L008	8_2F_fox_S7_L008
Mahmoud	31_4F_fox_S22_L008	10_2G_both_S8_L008
Maura	4_2C_mbnl_S4_L008	34_4H_both_S24_L008
Ramzy	22_3H_both_S16_L008	23_4A_control_S17_L008
Shayal	24_4A_control_S18_L008	15_3C_mbnl_S11_L008
Tayana	17_3E_fox_S13_L008	27_4C_mbnl_S19_L008
Varsheni	19_3F_fox_S14_L008	7_2E_fox_S6_L008
Wes	27_4C_mbnl_S19_L008	32_4G_both_S23_L008
Zach	3_2B_control_S3_L008	28_4D_mbnl_S20_L008
```

My name is `Wes` so I will use files `27_4C_mbnl_S19_L008` and `32_4G_both_S23_L008`.  

The demultiplexed, gzipped `.fastq` files are here: ```/projects/bgmp/shared/2017_sequencing/demultiplexed/```

Do not move, copy, or unzip this data!

# Part 1
 


## 2024-08-25

Enter an interactive session on Talapas.
```srun --account=bgmp --partition=bgmp --time=2:00:00 --pty bash```

Create a new conda environment named `QAA`. Install `FastQC`
- Version should be 0.12.1
```
$ conda create -y -n QAA fastqc=0.12.1
$ conda activate QAA
$ conda list
```

<details>

  <summary>`conda list`</summary>

```
# packages in environment at /projects/bgmp/wesg/miniforge3/envs/QAA:                          
#                                                                                              
# Name                    Version                   Build  Channel                             
_libgcc_mutex             0.1                 conda_forge    conda-forge                       
_openmp_mutex             4.5                       2_gnu    conda-forge
alsa-lib                  1.2.12               h4ab18f5_0    conda-forge
bzip2                     1.0.8                h4bc722e_7    conda-forge
ca-certificates           2024.7.4             hbcca054_0    conda-forge
cairo                     1.18.0               hebfffa5_3    conda-forge
expat                     2.6.2                h59595ed_0    conda-forge
fastqc                    0.12.1               hdfd78af_0    bioconda
font-ttf-dejavu-sans-mono 2.37                 hab24e00_0    conda-forge
font-ttf-inconsolata      3.000                h77eed37_0    conda-forge
font-ttf-source-code-pro  2.038                h77eed37_0    conda-forge
font-ttf-ubuntu           0.83                 h77eed37_2    conda-forge
fontconfig                2.14.2               h14ed4e7_0    conda-forge
fonts-conda-ecosystem     1                             0    conda-forge
fonts-conda-forge         1                             0    conda-forge
freetype                  2.12.1               h267a509_2    conda-forge
giflib                    5.2.2                hd590300_0    conda-forge
graphite2                 1.3.13            h59595ed_1003    conda-forge
harfbuzz                  9.0.0                hda332d3_1    conda-forge
icu                       75.1                 he02047a_0    conda-forge
keyutils                  1.6.1                h166bdaf_0    conda-forge
krb5                      1.21.3               h659f571_0    conda-forge
lcms2                     2.16                 hb7c19ff_0    conda-forge
lerc                      4.0.0                h27087fc_0    conda-forge
libcups                   2.3.3                h4637d8d_4    conda-forge
libdeflate                1.21                 h4bc722e_0    conda-forge
libedit                   3.1.20191231         he28a2e2_2    conda-forge
libexpat                  2.6.2                h59595ed_0    conda-forge
libffi                    3.4.2                h7f98852_5    conda-forge
libgcc-ng                 14.1.0               h77fa898_0    conda-forge
libglib                   2.80.3               h315aac3_2    conda-forge
libgomp                   14.1.0               h77fa898_0    conda-forge
libiconv                  1.17                 hd590300_2    conda-forge
libjpeg-turbo             3.0.0                hd590300_1    conda-forge
libpng                    1.6.43               h2797004_0    conda-forge
libstdcxx-ng              14.1.0               hc0a3c3a_0    conda-forge
libtiff                   4.6.0                h46a8edc_4    conda-forge
libuuid                   2.38.1               h0b41bf4_0    conda-forge
libwebp-base              1.4.0                hd590300_0    conda-forge
libxcb                    1.16                 hb9d3cd8_1    conda-forge
libxcrypt                 4.4.36               hd590300_1    conda-forge
libzlib                   1.3.1                h4ab18f5_1    conda-forge
ncurses                   6.5                  h59595ed_0    conda-forge
openjdk                   22.0.1               h8651b0f_1    conda-forge
openssl                   3.3.1                hb9d3cd8_3    conda-forge
pcre2                     10.44                hba22ea6_2    conda-forge
perl                      5.32.1          7_hd590300_perl5    conda-forge
pixman                    0.43.2               h59595ed_0    conda-forge
pthread-stubs             0.4               h36c2ea0_1001    conda-forge
xorg-fixesproto           5.0               h7f98852_1002    conda-forge
xorg-inputproto           2.3.2             h7f98852_1002    conda-forge
xorg-kbproto              1.0.7             h7f98852_1002    conda-forge
xorg-libice               1.1.1                hd590300_0    conda-forge
xorg-libsm                1.2.4                h7391055_0    conda-forge
xorg-libx11               1.8.9                hb711507_1    conda-forge
xorg-libxau               1.0.11               hd590300_0    conda-forge
xorg-libxdmcp             1.1.3                h7f98852_0    conda-forge
xorg-libxext              1.3.4                h0b41bf4_2    conda-forge
xorg-libxfixes            5.0.3             h7f98852_1004    conda-forge
xorg-libxi                1.7.10               h4bc722e_1    conda-forge
xorg-libxrender           0.9.11               hd590300_0    conda-forge
xorg-libxt                1.3.0                hd590300_1    conda-forge
xorg-libxtst              1.2.5                h4bc722e_0    conda-forge
xorg-recordproto          1.14.2            h7f98852_1002    conda-forge
xorg-renderproto          0.11.1            h7f98852_1002    conda-forge
xorg-xextproto            7.3.0             h0b41bf4_1003    conda-forge
xorg-xproto               7.0.31            h7f98852_1007    conda-forge
xz                        5.2.6                h166bdaf_0    conda-forge
zlib                      1.3.1                h4ab18f5_1    conda-forge
zstd                      1.5.6                ha6fb4c9_0    conda-forge
```

</details>

## TODO

Read `man` page for FastQC 

Produce plots of:
- per-base quality score distributions for R1 and R2 reads
- per-base N content

Comment on whether or not they are consistent with the quality score plots.

Run quality score plotting script from Demultiplexing assignment in Bi622. (make sure this is using a running sum strategy). 
Describe how these plots differ from FastQC.

If different, propose an explanation. 
Does the runtime differ? Mem/CPU usage? If so, why?

Comment on overall quality. make a recommendation on whether this data is suited to use for further analysis. 

# Part 2

Install:
- `cutadapt` Version 4.9
- `trimmomatic` Version 0.39

Read `man` page for `cutadapt`. 

Using `cutadapt` trim adapter sequences from these files. Use default settings. WHat proportion of reads (both R1 and R2) were trimmed?

Use unix commands to search for the adapter sequences in the data sets and confirm the expected sequence orientations. Report commands used for this and the reasoning behind them and how the adapter sequences are confirmed. 

Use `trimmomatic` to quality trim reads. Specify the fillowing, **in this order**:
- LEADING: quality of 3
- TRAILING: quality of 3
- SLIDING WINDOW: window size of 5 and required quality of 15
- MINLENGTH: 35 bases

Output compressed files to this directory 
`/projects/bgmp/wesg/bioinfo/Bi623/QAA`
and clear out intermediate files. 

Plot the trimmed read length distributions for both the R1 and R2 reads on the same plot (see ICA4).
Produce 2 different plots for the 2 different RNA samples.

Comment on whether you ecpect R1a dn R2s to be adapter-trimmed at different rates and why.

Run `FastQC` on trimmed data. Comment on differences between the trimmed and untrimmed data. Include any figures needed to support your conclusions.


# Part 3
















10. Install sofware (record details in lab notebook!!!). In your QAA environment, use conda to install:
    - star
    - numpy
    - matplotlib
    - htseq

11. Find publicly available mouse genome fasta files (Ensemble release 112) and generate an alignment database from them. Align the reads to your mouse genomic database using a splice-aware aligner. Use the settings specified in PS8 from Bi621.

  > [!IMPORTANT]
  > You will need to use gene models to perform splice-aware alignment, see PS8 from Bi621.
    
12. Using your script from PS8 in Bi621, report the number of mapped and unmapped reads from each of your 2 sam files. Make sure that your script is looking at the bitwise flag to determine if reads are primary or secondary mapping (update/fix your script if necessary).

13. Count reads that map to features using `htseq-count`. You should run htseq-count twice: once with `--stranded=yes` and again with `--stranded=reverse`. Use default parameters otherwise.

14. Demonstrate convincingly whether or not the data are from "strand-specific" RNA-Seq libraries. Include any comands/scripts used. Briefly describe your evidence, using quantitative statements (e.g. "I propose that these data are/are not strand-specific, because X% of the reads are y, as opposed to z.").

  > [!TIP]
  > Recall ICA4 from Bi621.

# Challenge (optional!)

Review the [metadata](./metadata) available to you and see if this information leads to any additional insight of your analysis.

# To turn in your work for this assignment

## Upload your:
- [ ] lab notebook,
- [ ] Talapas batch script/code, 
- [ ] FastQC plots, 
- [ ] counts files generated from htseq-count (in a folder would be nice),
- [ ] pdf report (see below), 
- [ ] and any additional plots, code, or code output

to GitHub.
    
## You should create a pdf file (using Rmarkdown) with a high-level report including:
- [ ] all requested plots
- [ ] answers to questions
- [ ] mapped/unmapped read counts from PS8 script (in a nicely formatted table)
    
The three parts of the assignment should be clearly labeled. Be sure to title and write a descriptive figure caption for each image/graph/table you present. 
> [!TIP]
> Think about figure captions you've read and discussed in Journal Club. Find some good examples to model your captions on.

The file should be named `QAA_report.pdf`, and it should be a the top level of your repo AND submitted to Canvas.
