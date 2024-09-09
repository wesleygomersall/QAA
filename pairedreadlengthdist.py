#!/usr/bin/env python

import argparse
import numpy as np
import matplotlib.pyplot as plt # type: ignore (thanks vs code)
import gzip

def get_args():
    parser = argparse.ArgumentParser(description="")
    parser.add_argument("-i", "--input", help="Input .fastq or .fastq.gz file", type=str, required=True) 
    parser.add_argument("-p", "--paired", help="Input .fastq or .fastq.gz file for second read if data is paired end.", type=str, required=False) 
    parser.add_argument("-o", "--output", help="Output .png file to write plot of read length distribution", type=str, required=True) 
    return parser.parse_args()

READ1 = get_args().input
READ2 = get_args().paired
OUTPUT = get_args().output

r1_lengthdist = dict()
r2_lengthdist = dict()

if READ1.endswith(".gz"): 
    compressed = True

    with gzip.open(READ1, 'r') as r1: # need to use gzip to open file
        for i, line in enumerate(r1):

            if (i + 1) % 4 == 2: # if it is sequence line
                # make sure to not include '\n' when counting read lengths
                lenread = len(line.strip('\n')) 

                if lenread not in r1_lengthdist.keys(): 
                    # add to dictionary, default value 1 (this is the first occurance)
                    r1_lengthdist.setdefault(lenread, 1)
                elif lenread in r1_lengthdist.keys(): 
                    r1_lengthdist[lenread] += 1

else: 
    compressed = False
    
    with open(READ1, 'r') as r1:
        for i, line in enumerate(r1):
            if (i + 1) % 4 == 2: # if it is sequence line
                lenread = len(line.strip('\n')) # make sure to not include '\n' when counting read lengths
                if lenread not in r1_lengthdist.keys(): 
                    # add to dictionary, default value 1 (this is the first occurance)
                    r1_lengthdist.setdefault(lenread, 1)
                elif lenread in r1_lengthdist.keys(): 
                    r1_lengthdist[lenread] += 1

if READ2 == None: 
    paired = False

else:
    paired = True

    if READ2.endswith(".gz"): 
        r2compressed = True
    
        with gzip.open(READ2, 'r') as r2: # need to use gzip to open file
            for i, line in enumerate(r2):
    
                if (i + 1) % 4 == 2:
                    lenread = len(line.strip('\n')) 
    
                    if lenread not in r2_lengthdist.keys(): 
                        r2_lengthdist.setdefault(lenread, 1)
                    elif lenread in r2_lengthdist.keys(): 
                        r2_lengthdist[lenread] += 1
    
    else:
        r2compressed = False 

        with open(READ2, 'r') as r2:
            for i, line in enumerate(r2):
    
                if (i + 1) % 4 == 2:
                    lenread = len(line.strip('\n')) 
    
                    if lenread not in r2_lengthdist.keys(): 
                        r2_lengthdist.setdefault(lenread, 1)
                    elif lenread in r2_lengthdist.keys(): 
                        r2_lengthdist[lenread] += 1

# First column is read length second column is count of reads of that particular length
npar_r1_len_dist = np.array(list(r1_lengthdist.items()))
npar_r1_len_dist = npar_r1_len_dist[npar_r1_len_dist[:,0].argsort()] 

if paired:
    npar_r2_len_dist = np.array(list(r2_lengthdist.items()))
    npar_r2_len_dist = npar_r2_len_dist[npar_r2_len_dist[:,0].argsort()] 

# plot output with matplotlib 
    # plot first file, if second exists, plot it on the same exact axes. 
    plt.figure(figsize=(10,6))
    print("plotting R1")
    print(npar_r1_len_dist)
    plt.plot(npar_r1_len_dist[:,0], npar_r1_len_dist[:,1])
    print("plotting R2")
    print(npar_r2_len_dist)
    plt.plot(npar_r2_len_dist[:,0], npar_r2_len_dist[:,1])
else: 
    plt.figure(figsize=(10,6))
    plt.plot(npar_r1_len_dist[:,0], npar_r1_len_dist[:,1])

plt.yscale("log")
plt.title('Read length distribution')
plt.xlabel('Read Length')
plt.ylabel('Frequency')

plt.savefig(OUTPUT)
