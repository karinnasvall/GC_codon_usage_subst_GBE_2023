#how to get hte enc result in to files with correct genes and order
#mod 200618

cd outputs/codon_usage/ENC_codon_nr_genewise_and_brachwise
grep "Nc" * > enc_genewise_orth.txt

#removed the original files and kept only the summary file (to many)

#split the file in branches, obs B mori and H. mel
cut -c 1-3 enc_genewise_orth_200618.txt | uniq 
cce
DPO
HME
Hme
HmG
HmI
KPJ
lac
lep
NM_
pse
XM_

grep "pse" enc_genewise_orth_200618.txt | sed 's/.enc/ /g' | awk '{print $1,$4}' > enc_psennae.txt
grep "leptidea" enc_genewise_orth_200618.txt | sed 's/.enc/ /g' | awk '{print $1,$4}' > enc_lsinapis.txt
grep "DPOG" enc_genewise_orth_200618.txt | sed 's/.enc/ /g' | awk '{print $1,$4}' > enc_d.plex.txt
grep -i "HM" enc_genewise_orth_200618.txt | sed 's/.enc/ /g' | awk '{print $1,$4}' > enc_hmelpom.txt
grep "lac" enc_genewise_orth_200618.txt | sed 's/.enc/ /g' | awk '{print $1,$4}' > enc_laccius.txt
grep "KPJ" enc_genewise_orth_200618.txt | sed 's/.enc/ /g' | awk '{print $1,$4}' > enc_pmachaon.txt
grep "cce" enc_genewise_orth_200618.txt | sed 's/.enc/ /g' | awk '{print $1,$4}' > enc_ccecrops.txt
grep -E "NM|XM" enc_genewise_orth_200618.txt | sed 's/.enc/ /g' | awk '{print $1,$4}' > enc_bmori.txt

#get the B. mori  name and order of the genes
cut -f 3,2 -d "," ../../../working/overlap_new.csv | sed 's/,/ /g' | sort | join enc_d.plex.txt - | sort -k3 > enc_dpl.table
cut -f 3,4 -d "," ../../../working/overlap_new.csv | sed 's/,/ /g' | sort -k2 | join -j1 1 -j2 2 enc_hmelpom.txt - | sort -k3 > enc_hmel.table 
cut -f 3,5 -d "," ../../../working/overlap_new.csv | sed 's/,/ /g' | sort -k2 | join -j1 1 -j2 2 enc_lsin.txt - | sort -k3 > enc_lsin.table 
cut -f 3,6 -d "," ../../../working/overlap_new.csv | sed 's/,/ /g' | sort -k2 | join -j1 1 -j2 2 enc_laccius.txt - | sort -k3 > enc_lac.table
cut -f 3,7 -d "," ../../../working/overlap_new.csv | sed 's/,/ /g' | sort -k2 | join -j1 1 -j2 2 enc_pmachaon.txt - | sort -k3 > enc_pma.table
cut -f 3,8 -d "," ../../../working/overlap_new.csv | sed 's/,/ /g' | sort -k2 | join -j1 1 -j2 2 enc_psennae.txt - | sort -k3 > enc_pse.table
#problem with join and sort with psennae
cut -f 3,8 -d "," overlap_new.csv | sed 's/,/ /g' | LC_COLLATE="en_US.UTF-8" sort -k2 | join -j1 1 -j2 2 ../outputs/codon_usage/result/enc_genewise_orth_phoebis_corr.txt - | sort -k5 > ../outputs/codon_usage/result/enc_genewise_orth_pse.table
#join: ../outputs/codon_usage/result/enc_genewise_orth_phoebis_corr.txt:15: är inte sorterad: pse10.11 :Nc = 43.522
#wc -l 4223
#work around...
for line in $(awk '{$1=$1",";print $1}' enc_psennae.txt);do grep $line ../../../working/overlap_new.csv >> enc_pse_overlap.table;done
awk 'BEGIN{FS=","} {print $3, $8}' enc_pse_overlap.table | join -j1 1 -j2 2 enc_psennae.txt - | sort -k3 > enc_pse.table

cut -f 3,9 -d "," ../../../working/overlap_new.csv | sed 's/,/ /g' | sort -k2 | join -j1 1 -j2 2 enc_ccecrops.txt - | sort -k3 > enc_cce.table

#merge all tables into one, this also contains the species name of the genes
for file in $(ls *.table);do awk '{print $3,$2,$1}' $file > ${file}_ordered;done

join enc_bmori.txt enc_cce.table_ordered | join - enc_dpl.table_ordered | join - enc_hmel.table_ordered | join - enc_lac.table_ordered | join - enc_lsin.table_ordered | join - enc_pma.table_ordered | join - enc_pse.table_ordered > enc_total.table

cat header_enc.txt enc_total.table > enc_total.csv
awk '{print NF}' enc_total.csv | uniq
#16
wc -l enc_total.csv
#4868
