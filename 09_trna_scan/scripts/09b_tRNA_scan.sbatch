#!/bin/bash -l

#SBATCH -A snic2022-5-34
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 96:00:00
#SBATCH -J Lept_sel
#SBATCH -e Lept_sel_trna.error
#SBATCH --mail-user karin.nasvall@ebc.uu.se
#SBATCH --mail-type=ALL


module load bioinfo-tools tRNAscan-SE/2.0.9

wd=/proj/uppstore2017185/b2014034_nobackup/Karin/Lepidoptera_dnds_project/outputs/trna_scan
input=/proj/uppstore2017185/b2014034_nobackup/Karin/Lepidoptera_dnds_project/data/GCA_905404315.1_ilLepSina1.1_genomic.filt.fna.gz.split

cd $wd
output=output2

mkdir $output

for file in $(ls $input)
do echo $file 
tRNAscan-SE -HQ -o# -f# -m# -s# -a# --detail -p $output/${file} ${input}/${file}
date 
done 
wait
