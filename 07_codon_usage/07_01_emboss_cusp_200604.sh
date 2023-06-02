#modified 200604

#get codon usage from fasta files of the 4867 sequences used in paml BS test
#using the program cusp in emboss, get average codon usage from CDS and aligned geneset 4150 
#module load emboss/6.6.0

###########################

#branchwise codon usage frequency tables for the whole CDS set to compare with the aligned  gene set
for file in $(ls *.cds.fa)
do cusp $file -odirectory_outfile ../outputs/codon_usage/CUT_branchwise_total_CDS -outfile ${file%.*}.cusp
done

#get all results in one file
awk 'NR>7 {$(NF + 1) = "b_mori";print $0}' Bombyx_mori.cusp > cds_CUT_all.table
awk 'NR>8 {$(NF + 1) = "c_cecr";print $0}' Calycopis_cecrops.cusp >> cds_CUT_all.table
awk 'NR>8 {$(NF + 1) = "d_plex";print $0}' Danaus_plexippus.cusp >> cds_CUT_all.table
awk 'NR>8 {$(NF + 1) = "h_mel";print $0}' Heliconius_melpomene.cusp >> cds_CUT_all.table
awk 'NR>8 {$(NF + 1) = "l_acc";print $0}' Lerema_accius.cusp >> cds_CUT_all.table
awk 'NR>8 {$(NF + 1) = "l_sin";print $0}' Leptidea_sinapis.cusp >> cds_CUT_all.table
awk 'NR>8 {$(NF + 1) = "p_mac";print $0}' Papilio_machaon.cusp >> cds_CUT_all.table
awk 'NR>8 {$(NF + 1) = "p_sen";print $0}' Phoebis_sennae.cusp >> cds_CUT_all.table


#split files
for file in $(cat list_trimmed_filenames_200421_fasta.txt);do perl split_fasta.pl ../../../Venkat/Lepidoptera_dnds_project/outputs/genes_fasta_files/$file;done

mkdir ../outputs/split_fasta_files_4687/
mv *.fa ../outputs/split_fasta_files_4687/

#get a list of the specific branch genenames of the aligned geneset (4150)
awk '{print $1}' ../../outputs/paml_BS_trimmed_200421/summary/summary_results_BS_soft.csv | sort > ../../working/list_genenames_4150.txt
for line in $(cat ../../working/list_genenames_4150.txt);do grep $line ../../working/overlap_new.csv >> ../../working/overlap_4150.txt;done

#cat files per branch for the aligned gene set
cd ../outpus/split_fasta_files_4687/
for file in $(awk 'BEGIN{FS=","}{$2=$2".fa"; print $2}' ../../working/overlap_4150.txt);do cat $file >> cat_dpl_4150.fa;done
for file in $(awk 'BEGIN{FS=","}{$3=$3".fa"; print $3}' ../../working/overlap_4150.txt);do cat $file >> cat_bmor_4150.fa;done
for file in $(awk 'BEGIN{FS=","}{$4=$4".fa"; print $4}' ../../working/overlap_4150.txt);do cat $file >> cat_hmel_4150.fa;done
for file in $(awk 'BEGIN{FS=","}{$5=$5".fa"; print $5}' ../../working/overlap_4150.txt);do cat $file >> cat_lsin_4150.fa;done
for file in $(awk 'BEGIN{FS=","}{$6=$6".fa"; print $6}' ../../working/overlap_4150.txt);do cat $file >> cat_lac_4150.fa;done
for file in $(awk 'BEGIN{FS=","}{$7=$7".fa"; print $7}' ../../working/overlap_4150.txt);do cat $file >> cat_pma_4150.fa;done
for file in $(awk 'BEGIN{FS=","}{$8=$8".fa"; print $8}' ../../working/overlap_4150.txt);do cat $file >> cat_pse_4150.fa;done
for file in $(awk 'BEGIN{FS=","}{$9=$9".fa"; print $9}' ../../working/overlap_4150.txt);do cat $file >> cat_cce_4150.fa;done
grep ">" cat_dpl.fa | wc -l

mv cat* ../cat_fasta_files_per_branch_4150/

#per branch in the aligned geneset
mkdir ../outputs/codon_usage/CUT_branchwise_aligned_200618
cd ../outputs/cat_fasta_files_per_branch_4150/
for file in $(ls *.fa);do cusp $file -odirectory_outfile ../codon_usage/CUT_branchwise_aligned_200618 -outfile ${file%.*}.cusp;done

#summarise in one file (long format)
awk 'NR>6 {$(NF + 1) = "b_mori";print $0}' cat_bmor_4150.cusp > cat_4150_all.table
less cat_4150_all.table 
nano cat_4150_all.table #change header 
awk 'NR>7 {$(NF + 1) = "c_cecr";print $0}' cat_cce_4150.cusp >> cat_4150_all.table
less cat_4150_all.table 
awk 'NR>7 {$(NF + 1) = "d_plex";print $0}' cat_dpl_4150.cusp >> cat_4150_all.table
awk 'NR>7 {$(NF + 1) = "h_mel";print $0}' cat_hmel_4150.cusp >> cat_4150_all.table
awk 'NR>7 {$(NF + 1) = "l_acc";print $0}' cat_lac_4150.cusp >> cat_4150_all.table
awk 'NR>7 {$(NF + 1) = "l_sin";print $0}' cat_lsin_4150.cusp >> cat_4150_all.table
awk 'NR>7 {$(NF + 1) = "p_mac";print $0}' cat_pma_4150.cusp >> cat_4150_all.table
awk 'NR>7 {$(NF + 1) = "p_sen";print $0}' cat_pse_4150.cusp >> cat_4150_all.table

#############
# Redo with missing files, did not use, did the whole geneset instead
#sed 's/_trimmed.phy/.fas/g' list_trimmed_filenames_200421.txt > list_trimmed_filenames_200421_fasta.txt
#comm -23 list_trimmed_filenames_200421_fasta.txt list_trimmed_filenames_fasta.txt > list_trimmed_filenames_fasta_add200604.txt
###############

#codon usage tables for all genes in all branches, genewise and brachwise (4867 genes x 8)
cd ../outputs/split_fasta_files_/
for file in $(ls *.fa);do cusp $file -odirectory_outfile ../codon_usage/CUT_genewise_perbranch_200618 -outfile ${file%.*}.cusp;done

#genewise for comparing the different genesets (aligned, 100 most conserved and under pos selection), average over braches
mkdir ../outputs/codon_usage/CUT_genewise_4867/
for file in $(cat list_trimmed_filenames_200421_fasta.txt);do cusp ../../../Venkat/Lepidoptera_dnds_project/outputs/genes_fasta_files/$file -odirectory_outfile ../outputs/codon_usage/CUT_genewise_4867 -outfile ${file%.*}.cusp;done

#compiling the files into one file 
#creating temp files with only field 1 and frequency
for file in $(ls *.cusp);do FILENAME=${file%.*} awk 'NR>6{if(NR==7){$4=FILENAME;print $1,$4}else{print $1,$4}}' $file > ${file%.*}_temp;done

#one alternative to join all files (join only take two so have to loop)
#join GSN1.txt GSN2.txt > tmp.tmp     
#for f in GSN3.txt GSN4.txt GSN5.txt  
#do                                   
#    join tmp.tmp $f > tmpf           
#    mv tmpf tmp.tmp                  
#done                                 
#mv tmp.tmp GSN_ALL.txt               
#cat GSN_ALL.txt

#doing the first two separately, in the first i want both codon and aminoacid columns
awk 'NR>6{if(NR==7){$4="NM_001043315.1";print $1,$2,$4}else{print $1,$2,$4}}' NM_001043315.1.fasta.out.best.cusp > NM_001043315.1.fasta.out.best_temp1
awk 'NR>6{if(NR==7){$4="NM_001043365.1_1";print $1,$4}else{print $1,$4}}' NM_001043365.1_1.fasta.out.best.cusp > NM_001043365.1_1.fasta.out.best_temp1
join *temp1 > tmp.tmp

#another alternative is to transpose before and cat the lines together, meaning one gene per row and codons as columns
cut -f1 -d " " tmp.tmp | tr "\n" " " | awk '{print $0}' > CUT_genewise_frequency.txt 
cut -f2 -d " " tmp.tmp | tr "\n" " " | awk '{print $0}' >> CUT_genewise_frequency.txt 
cut -f3 -d " " tmp.tmp | tr "\n" " " | awk '{print $0}' >> CUT_genewise_frequency.txt 
cut -f4 -d " " tmp.tmp | tr "\n" " " | awk '{print $0}' >> CUT_genewise_frequency.txt 

for file in $(ls *_temp); do cut -f2 -d " " $file | tr "\n" " " | awk '{print $0}' >> CUT_genewise_frequency.txt;done
sed 's/.fasta.out.best.cusp//g' CUT_genewise_frequency.txt > CUT_genewise_frequency.table

#######################
#Add column with RSCU to branchwise codon usage table and remove the stopcodons
#use uniq to fine nr of codons per aa
awk '{print $2}' result_200619/cat_4150_all.table | uniq -c | head -n 21 | sort -k1
      1 AA
      1 M
      1 W
      2 C
      2 D
      2 E
      2 F
      2 H
      2 K
      2 N
      2 Q
      2 Y
      3 I
      4 A
      4 G
      4 P
      4 T
      4 V
      6 L
      6 R
      6 S

awk '$2 ~ /[AGPTV]/{$(NF +1)= 0.25} $2 ~ /[LRS]/{$(NF +1)= 0.17} /I/{$(NF +1)= 0.33} $2 ~ /[CDEFHKNQY]/{$(NF +1)= 0.50} $2 ~ /[MW]/{$(NF +1)= 1.00} $2 ~ /\*/{next} {print;}' result_200619/cat_4150_all.table | awk 'NR==1{$7="Null_freq"; $(NF + 1)="RSCU"} NR>1{$(NF + 1)=$3/$7}1' > result_200619/cub_4150_all.csv

#final tables are 
cds_CUT_all.table
cub_4150_all.table
CUT_genewise_frequency.table


#####
#redo or find output
#codon usage tables for all genes in all branches, genewise and brachwise (4867 genes x 8)
cd ../outputs/split_fasta_files_/
for file in $(ls *.fa);do cusp $file -odirectory_outfile ../codon_usage/CUT_genewise_perbranch_200618 -outfile ${file%.*}.cusp;done

#add column for branch and gene name


