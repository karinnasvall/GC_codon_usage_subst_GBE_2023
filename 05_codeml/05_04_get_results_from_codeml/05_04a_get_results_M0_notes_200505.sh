##Glean result from paml_M0 to get overall est of average omega per gene and to filter genetrees longer than 30 (based on my interpretation of Gharib & Robinson-Rechavi MBE 2013, dS>0.5 starting to los power and initially risk fasle positives but as dS increases - even more loss ov power and false negatives test for positive selection))

#get tree length, tree length for dS and dn/ds, kappa repeat for run2
grep -E "omega|kappa|tree length =|tree length for dS|tree length for dN" ../outputs/paml_M0_trimmed_200424/*mlc > ../outputs/paml_M0_trimmed_200424summary/summary_results_M0_prel.txt

#make a table
cut -f2- -d ":" summary_results_M0_prel.txt | tr ":" "=" | cut -f 2 -d "=" | awk 'ORS=NR%5?" ":"\n"' > > summary_results_M0_prel.table

#add filenames
cut -f 1 -d ":" summary_results_M0_prel.txt | uniq | cut -f 4 -d "/" | cut -f 1,2 -d "." | paste - summary_results_M0_prel.table > summary_results_M0_gene.table

#add header
cat ../../working/header.M0.txt summary_results_M0_gene.table > summary_results_M0run1.table

#filter high and low dS (dS is column $6)
awk '$6<30 {print $0}' summary_results_M0run1.table | cat header.txt - > summary_results_M0run1_filtered.table
Sequences left 4237 run1, 4239 run2

