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
 


## TODO 

Enter an interactive session on Talapas.

Create a new conda environment named `QAA`. Install `FastQC`
- Check version with `fastqc --version` (should be 0.12.1)  




