#!/bin/bash -l

#SBATCH -A snic2022-5-34
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 2:00:00
#SBATCH -J Lept_split
#SBATCH -e Lept_split.error
#SBATCH --mail-user karin.nasvall@ebc.uu.se
#SBATCH --mail-type=ALL



#split multifasta into multiple	fasta file by id

wd=/proj/uppstore2017185/b2014034_nobackup/Karin/Lepidoptera_dnds_project/data/
input=GCA_905404315.1_ilLepSina1.1_genomic.filt.fna.gz

module load bioinfo-tools SeqKit/0.15.0

cd $wd

seqkit split --by-id ${input} --two-pass
