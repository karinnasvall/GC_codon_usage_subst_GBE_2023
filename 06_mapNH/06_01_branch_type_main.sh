#!/bin/bash -l

for file in $(cat list_genenames_4150.txt)
do

mkdir ../output/200629_mapNH/mapNH_${file}_dir

echo "alphabet = Codon(letter=DNA)
genetic_code=Standard

input.sequence.format=Phylip
input.sequence.file=../data/trimmed_files_4150/${file}.fasta.out.best_trimmed.phy

input.tree.file= RAxML_bestTree.2.dnd
input.tree.format = Newick

# Remove stop codons
input.sequence.remove_stop_codons=yes
input.sequence.sites_to_use = nogap

param = Lepid_optYN98m1.params

map.type = Combination(reg1=DnDs, reg2=SW)

output.counts = PerType(prefix=../output/200629_mapNH/mapNH_${file}_dir/${file}.counts_)

nullModelParams = YN98.omega*=1
" > ../scripts/200629_query/map_dnds_${file}.bpp

/Applications/bpp_dir/bin/mapnh param=../scripts/200629_query/map_dnds_${file}.bpp
done
