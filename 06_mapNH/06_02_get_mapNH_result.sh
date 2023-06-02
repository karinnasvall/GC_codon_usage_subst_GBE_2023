#Created 200701 Karin Näsvall
#step by step gleaning data from mapNH result files in tree form (.dnd) to tip branch data in .csv form
#get all result trees in one file per substitution type, incl file name( gene ID) since some result files are empty after gap removal

for file in $(find ../output -name "*dN_X_S->S.dnd");do grep -H  "sinapis" $file >> result_dN_X_S_S.dnd;done

for file in $(find ../output -name "*dN_X_S->W.dnd");do grep -H  "sinapis" $file >> result_dN_X_S_W.dnd;done

for file in $(find ../output -name "*dN_X_W->S.dnd");do grep -H  "sinapis" $file >> result_dN_X_W_S.dnd;done

for file in $(find ../output -name "*dN_X_W->W.dnd");do grep -H  "sinapis" $file >> result_dN_X_W_W.dnd;done

for file in $(find ../output -name "*dS_X_S->S.dnd");do grep -H  "sinapis" $file >> result_dS_X_S_S.dnd;done

for file in $(find ../output -name "*dS_X_S->W.dnd");do grep -H  "sinapis" $file >> result_dS_X_S_W.dnd;done

for file in $(find ../output -name "*dS_X_W->S.dnd");do grep -H  "sinapis" $file >> result_dS_X_W_S.dnd;done

for file in $(find ../output -name "*dS_X_W->W.dnd");do grep -H  "sinapis" $file >> result_dS_X_W_W.dnd;done

#get the branch length in one csv file instead of tree files
# Header: (((L_accius:0.630707,((P_sennae:0.383499,L_sinapis:0.563962):0.108256,(C_cecrops:0.87217,(D_plexippus:0.458998,H_melpomene:0.482362):0.0921483):0.0791335):0.245401):0.0812543,P_machaon:0.6481):0.261208,B_mori:0.228138)
# Txt: gene_ID L_accius P_sennae L_sinapis node_whites C_cecrops D_plexippus H_melpomene node_nym node_blunym node_whiblunym node_ex_pap P_machaon node_bfly B_mori
#check
#cut -f 5- -d "/" result_dN_X_S_S.dnd | sed 's/[():,]/ /g' | sed 's/.counts/ /g' | tr -s " " | cut -f 1,4,6,8-9,11,13,15-19,21,22,24 -d " " | cat header_mapNH.txt - | awk '{print NF}' | uniq
#cut -f 5- -d "/" result_dN_X_S_S.dnd | sed 's/[():,]/ /g' | sed 's/.counts/ /g' | tr -s " " | cut -f 1,4,6,8-9,11,13,15-19,21,22,24 -d " " | cat header_mapNH.txt - | head


for file in $(ls result*);do cut -f 5- -d "/" $file | sed 's/[():,]/ /g' | sed 's/.counts/ /g' | tr -s " " | cut -f 1,4,6,8-9,11,13,15-19,21,22,24 -d " " | cat header_mapNH.txt - > ${file%.*}.csv;done

wc -l result_d*.csv
#4125 genes

#move csv files and delete treefiles
mkdir ../data/result_mapNH_csv
mv result_d*.csv ../data/result_mapNH_csv/
rm result*.dnd

#get only tip branch data
for file in $(ls ../data/result_mapNH_csv/*); do awk '{print $1,$2,$3,$4,$6,$7,$8,$13,$15}' $file > ${file%.*}_tip.csv; done


#filter >300nt and <30 branch length (repeat) NOT performed, filtering at later stage
#for line in $(cat list_genenames_3308.txt);do grep $line ../dnds_temp/bppML/working/result_dS_X_W_W.csv >> ../dnds_temp/bppML/working/result_dS_X_W_W_filtered.csv;done

#get alignment length after gap removal, oneliner to get a table with GeneID and length after gap removal from std.out 
grep -A 3 --no-group-separator "Sequence file" output/mapNH_std_out_200630.txt | cut -f2 -d ":" | awk 'ORS=NR%4?" ":"\n"' | cut -f4 -d "/" | sed 's/fasta.out.best_trimmed.phy//g' | awk '{print $1,$6}' > output/mapNH_al_length.table

#nano to change header
#and an extra awk to remove trailing dot (or add a dot in the previous sed step) 
awk '{sub(/\.$/,"",$1);print $0}' 08_03_subst_type_R/data/mapNH_al_length.txt > 08_03_subst_type_R/data/mapNH_al_length.table

#this is done in r not needed
#after filtering and counting dnds in r, calculate dn and ds for gc-conservative substitutions. OBS not exact because dN and dS are themselves ratios (dNs_s + dNw_w)/2 and (dSs_s + dSw_w)/2 then divide results to get dnds
#grep "s_s" subst_type.table | cut -f2- -d " " > s_s.table 
#grep "w_w" subst_type.table | cut -f2- -d " " > w_w.table 
#paste s_s.table w_w.table | awk '{$(NF + 1)= ($4 + $11)/2; $(NF + 2)= ($5 + $12)/2;print $0}' | awk '{$(NF + 1)=($(NF-1)/$NF);print $1,$2, $(NF-2), $(NF-1), $NF}' > gc_cons.table

#nano header

