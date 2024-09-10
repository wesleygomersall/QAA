#!/usr/bin/env python

import argparse

def get_args():
    parser = argparse.ArgumentParser(description="Program to parse the contents of SAM file. Returns counts of mapped and unmapped (primary alignment) reads.")
    parser.add_argument("-i", "--input", help="Input SAM file relative path", type=str, required=True) 
    return parser.parse_args()

SAMFILE = get_args().input #"./dre/Aligned.out.sam"

mapcount: int = 0 #to increment
unmapped: int = 0

with open(SAMFILE, 'r') as fin: 
    for line in fin:
        if line.startswith('@'):
            continue #do not calculate, keep reading lines if line is a header
        flag = int(line.split()[1]) #get the 2nd column from SAMFILE
        if ((flag & 256) == 256): #check 0x256 (not primary alignment)
            continue #not primary alignment, dont even check if mapped or unmapped
        if ((flag & 4) == 4): # bitwise 4 (1): unmapped
            unmapped += 1
        if ((flag & 4) != 4): # bitwise 4 (0): mapped
            mapcount += 1
        
print(f"{mapcount} reads in {SAMFILE} are mapped.")
print(f"{unmapped} reads in {SAMFILE} are unmapped.")