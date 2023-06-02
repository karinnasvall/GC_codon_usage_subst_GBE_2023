#! /bin/bash -l

#SBATCH -A b2014034
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 50:00:00
#SBATCH -J phast


module load bioinfo-tools
module load prank


cd Lepidoptera_dnds_project/outputs/genes_fasta_files/

for i in $(ls *.fasta );
do
outfile=$(echo $i | cut -f 1 -d ".")
prank -d=$i -o=$i.out -f='fasta' -codon
echo $outfile"_done";
done

