#!/usr/bin/env python
import re
v = open("Fasta.fa", "r")

def sliding_window(sequence, winSize, step):
        numOfChunks = ((len(sequence)-winSize)//step)+1
        for i in range(0,numOfChunks*step,step):
                yield sequence[i:i+winSize]


w = 10
for line in v:
	if line.startswith(">"):
		myseq1 = line.rstrip()		
			
	if not line.startswith(">"):
		myseq = line.rstrip()
		myvect = sliding_window(myseq, 10, 1)
		for r in myvect:
			print(myseq1 , r ,len(re.findall('D|E|R|H|K', r)))			
