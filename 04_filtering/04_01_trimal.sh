#!/bin/bash -l

module load bioinfo-tools
module load trimAl/1.4.1

cd /proj/uppstore2017185/b2014034_nobackup/Karin/Lepidoptera_dnds_project/working/

for file in $(ls Lepidoptera_dnds_project/outputs/genes_fasta_files/*fas_renamed.phy)
do
trimal -in $file -phylip3.2 -out ../outputs/trimal/trimmed/$(basename -s .fas_renamed.phy $file)_trimmed.phy -gt 0.50 -sgt -htmlout ../outputs/trimal/trimmed/$(basename -s .fas_renamed.phy $file)_trimmed.html > ../outputs/trimal/trimmed/$(basename -s .fas_renamed.phy $file).trimmed.summary.txt 
done
