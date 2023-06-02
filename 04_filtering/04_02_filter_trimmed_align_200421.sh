#filter alignments with more than 50% of the original alignmentlength removed (not representative for the original gene...)
#filter seq with less than 8 seqences
#creat a list with alignments to proceed with

###### GLEAN DATA
 
cd ../outputs/trimal/trimmed/

grep -A 1 "Selected Seq" *_trimmed.html > ../summary_trimmed_prel.txt
NM_001043315.1.fasta.out.best_trimmed.html:    <span class=sel>Selected Sequences:     8 /Selected Residues:    1014</span>
NM_001043315.1.fasta.out.best_trimmed.html-    <span class=nsel>Deleted Sequences:      0 /Deleted Residues:      141</span>
--
NM_001043362.1.fasta.out.best_trimmed.html:    <span class=sel>Selected Sequences:     8 /Selected Residues:     411</span>
NM_001043362.1.fasta.out.best_trimmed.html-    <span class=nsel>Deleted Sequences:      0 /Deleted Residues:      519</span>
--
awk '{printf "%s%s",$0,(NR%2?FS:RS)}' file
Explanation:

printf will not include a new line character at the end of line (unlike print)
(NR%2?FS:RS) decides new line (RS) or field seperator (FS) based on NR%2
If your columns should be seperated by \t

cd ../

#check
#awk 'NF==8{print $1,$5,$8}' summary_trimmed_prel.txt | awk '{printf "%s%s", $0, (NR%2?FS:RS)}' | awk '{$4=""; print $0 }' | sed 's|</span>||g' | awk 'NF==5{print $0}' | wc -l
awk 'NF==8{print $1,$5,$8}' summary_trimmed_prel.txt | awk '{printf "%s%s", $0, (NR%2?FS:RS)}' | awk '{$4=""; print $0 }' | sed 's|</span>||g' > summary_trimmed_200421.table

less summary_trimmed_200421.table
NM_001043315.1.fasta.out.best_trimmed.html: 8 1014  0 141
NM_001043362.1.fasta.out.best_trimmed.html: 8 411  0 519
NM_001043365.1_1.fasta.out.best_trimmed.html: 8 2493  0 444
NM_001043367.1.fasta.out.best_trimmed.html: 8 1311  0 3777
NM_001043369.1.fasta.out.best_trimmed.html: 8 2823  0 267
NM_001043371.1.fasta.out.best_trimmed.html: 8 576  0 105


###### #FILTERING

#check the lines with less than 8 sequences
[karnas@rackham2 trimal]$ awk '$4>0{print $0}' summary_trimmed_200421.table
XM_004924305.1.fasta.out.best_trimmed.html: 7 543  1 1008
XM_004927966.2.fasta.out.best_trimmed.html: 7 2256  1 1146
XM_012691329.1.fasta.out.best_trimmed.html: 7 690  1 1839
XM_012694221.1.fasta.out.best_trimmed.html: 7 1083  1 1797
XM_012696388.1.fasta.out.best_trimmed.html: 7 3735  1 18519

#filtering1 - remove lines with less than 8 sequences
awk '$4==0{print $0}' summary_trimmed_200421.table > summary_trimmed_200421_filtered1_seq.table
# of alignments remaining 
#6069

#check the files with >= 50% of original seq length removed by trimal
#nr of files removed
awk '$3<$5{print $0}' summary_trimmed_200421_filtered1_seq.table | wc -l
#1157

#remove the files with less than 50% of original seq length and shorter than 300nt
awk '$3>$5{print $0}' summary_trimmed_200421_filtered1_seq.table | awk '$3<300{print $0}' | wc -l
#43

awk '$3>$5{print $0}' summary_trimmed_200421_filtered1_seq.table | awk '$3>=300{print $0}' > 
# of alignments remaining 
#4867

#make a list of filenames for codeml
cut -f 1 -d ":" summary_trimmed_200421_filtered2_length.table | sed 's/html/phy/g' > list_trimmed_filenames_200421.txt

#next run codeml!


