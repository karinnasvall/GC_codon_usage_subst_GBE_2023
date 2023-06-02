## Get filenames in a list 
#both B.mori and leptidea
grep "leptidea" ../results_summary/sign_fasta_files/* | tr ">" "." | cut -f 4 -d "/" | cut -f 1,2,7 -d "." > ../results_summary/list_sign_genenames190502_leptidea.txt

#get only leptidea
cut -f 3 -d "." ../results_summary/list_sign_genenames190502_leptidea.txt > ../results_summary/list_sign_genenames190502_leptidea2.txt

#compare with Drosophila
for line in $(cat ../results_summary/list_sign_genenames190502_leptidea2.txt);do grep $line ../scripts/overlap_new.csv; done > ../results_summary/list_sign_genenames190502_leptidea_Dr.mel.txt

#get input for Panther GO
cut -f 1 -d " " ../results_summary/list_sign_genenames190502_leptidea_Dr.mel.txt > ../results_summary/list_input_sign_pantherGO.txt



#for nonsign genes
cut -f 1 -d ";" ../results_summary/result_nonsign.csv | awk '{print $0, ".fasta.out.best.fas"}' | tr -d " " > ../results_summary/list_nonsign_genenames190502_fasta.txt
#remove the header
#get leptidea-names
for file in $(cat ../results_summary/list_nonsign_genenames190502_fasta.txt); do grep -H "leptidea" ../../../Venkat/Lepidoptera_dnds_project/outputs/genes_fasta_files/$file; done > ../results_summary/list_nonsign_genenames190502_Bmori_leptidea.txt

#clean up the table
cut -f 8 -d "/" ../results_summary/list_nonsign_genenames190502_Bmori_leptidea.txt | sed 's/.fasta.out.best.fas:>/ /g' > ../results_summary/list_nonsign_genenames_Bmori_leptidea.table
