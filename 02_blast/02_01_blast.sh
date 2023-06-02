#!/bin/bash -l

#SBATCH -A b2014034
#SBATCH -p core
#SBATCH -n 6
#SBATCH -t 10:00:00
#SBATCH -J Blast_Lepidoptera_dnds_project
#SBATCH -o Blast_Lepidoptera_dnds_project.out
#SBATCH -e Blast_Lepidoptera_dnds_project.error


module load bioinfo-tools 
module load blast

BLAST_outputs='Lepidoptera_dnds_project/outputs/BLAST_outputs/'

CDS='Lepidoptera_dnds_project/CDS'


cd $CDS
makeblastdb -in Bombyx_mori_ASM15162v1_-_protein.fa -dbtype prot -parse_seqids -out Bombyx_mori_ASM15162v1_-_protein.fa -title "Bombyx_mori_ASM15162v1_-_protein.fa"  

#aligning a query to the database

for i in $(cat file_names.txt)
do 
echo $i
blastp -db Bombyx_mori_ASM15162v1_-_protein.fa -query $i -outfmt 6 -out $BLAST_outputs$i'.tab' -num_threads 6
done

