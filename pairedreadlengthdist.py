#!/usr/bin/env python

import argparse

def get_args():
    parser = argparse.ArgumentParser(description="")
    parser.add_argument("-i", "--input", help="Input .fastq or .fastq.gz file", type=str, required=True) 
    parser.add_argument("-p", "--paired", help="Input .fastq or .fastq.gz file for second read if data is paired end.", type=str, required=False) 
    parser.add_argument("-o", "--output", help="Output .png file to write plot of read length distribution", type=str, required=True) 
    return parser.parse_args()

READ1 = get_args().input
READ2 = get_args().paired
OUTPUT = get_args().output

if READ2 == None: 
    paired = False

    if READ1.endswith(".gz"): 
        compressed = True

        # need to use gzopen or something
        
    else: 
        compressed = False

        r1_lengthdist = dict()
        with open(READ1, 'r') as r1:
            for i, line in enumerate(r1):
                if (i + 1) % 2 ==0: # if it is sequence line
                    lenread = len(line.strip('\n')) # make sure to not include '\n' when counting read lengths
                    if lenread in r1_lengthdist




else:
    paired = True


print(paired) 

# 
# Loop through first file 
    # only on sequence lines: get line length
    # create dictionary: keys: length values, number of occurances
    # if length not in dic
        # add key to dict, default value = 1 
    # if length is dic
        # inc key value
# 
# if second file exists
    # do this again, but for the second file now
# 
# turn these dictionaries into numpy arrays 
# Command to use for this: 
# np_ar_results = np.array(list(my_dictionary.items()))
# 
# plot output with matplotlib 
    # plot first file, if second exists, plot it on the same exact axes. 
