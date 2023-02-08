# NCPR_chargeblock_plot

The Net Charge Per Residue (NCPR) values were calculated for 10 amino acid sliding windows. If the sliding window NCPR values were greater than or equal to the absolute value of 5, then the respective window is defined as an acidic block or basic block based on the charge (negative: acidic blue, positive: basic, red).

Download and place the following files in a directory (doesn't matter where on your system). You could name the directory something like "NCPR_chargeblock_plot".

Files to have in this directory:

NCPR_code.sh 
findaminoacid_acidic.pl 
findaminoacid_basic.pl 
window.py 
Fasta.fa (modify the Fasta.fa file by adding protein of interest Fasta sequences, examples are given) 
plot.R

Open the Terminal app and go to the directory with the code (I will call it "NCPR_chargeblock_plot" for this example):

$ cd /path/to/NCPR_chargeblock_plot

Give permissions to the path if necessary.

$ chmod 777 NCPR_code.sh

To run the script, run the following function.

$ ./NCPR_code.sh

Requirements: R (v>3.0) and any perl and python version.

**OUTPUT**

This script will output each plot as a PDF

Path : /NCPR_chargeblock_plot/output/plots/

Acidic and basic block positions and sequences for each protein sequence will be also provided here.

Path : /NCPR_chargeblock_plot/output/files/

Columns: 1) window start position, 2) protein ID, 3)sequence, 4)NCPR score, 5)window end position
