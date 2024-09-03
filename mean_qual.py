#!/usr/bin/env python

import bioinfo
import matplotlib.pyplot as plt # type: ignore (thanks vs code)
import gzip
import argparse

def get_args():
    parser = argparse.ArgumentParser(description="Program to read through fastq file and calculate the mean quality per base position of the reads. All reads must be untrimmed, lenght 101.")
    parser.add_argument("-i", "--input", help="Input fastq file relative path", type=str, required=True) 
    parser.add_argument("-o", "--output", help="Output plot relative path", type=str, required=True) 
    return parser.parse_args()

# SAMFILE = get_args().input #"./dre/Aligned.out.sam"
file1 = get_args().input
plot1 = get_args().output

def init_list(lst: list, n: int, value: float=0.0) -> list:
    '''This function takes an empty list and populates it with
    the value passed in "value" for a total length of n.
    '''
    for i in range(n):
        lst.append(value)
    return lst

def populate_list(file: str, n:int) -> tuple[list, int]:
    """Takes a fastq file path as string input. Also needs to know n, the length of untrimmed sequences.
    Does some counting and outputs the sum of quality scores at each postition 
    in the sequence, for read lengths of exactly 101 bases.
    Also outputs the total line number. 
    """
    list = []
    list = init_list(list, n)
    with gzip.open(file, 'rt') as fqall:
        for index, line in enumerate(fqall):
            if (index+1) % 4 == 0:
                # print(line.strip('\n'))
                # print(len(line.strip('\n')))
                for col, pchar in enumerate(line.strip('\n')):
                    list[col] += bioinfo.convert_phred(pchar)
    return list, (index+1)

my_list1, num_lines1 = populate_list(file1, 101)
my_list1 = [n/(num_lines1/4) for n in my_list1] # turns sum to average

plt.figure(figsize=(10,6))
plt.bar(range(len(my_list1)), height = my_list1) # no need to have std dev on plots 
plt.title('Average Phred Quality Scores')
plt.xlabel('Position in sequence')
plt.ylabel('Converted quality score')
plt.savefig(plot1)

