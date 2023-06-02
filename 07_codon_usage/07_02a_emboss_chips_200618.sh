#get effective number of codons used in a sequence. Nr from 20 to 61 indicates a representation of the relative frequency of codons (heterozygosity) used in the sequence. Wright's Nc statistic. 
#module load bioinfo-tools emboss/6.6.0

#genewise effective nr of codons for the orthologous gene set
cd /proj/uppstore2017185/b2014034_nobackup/Karin/Lepidoptera_dnds_project/outputs/split_fasta_files_4687/
mkdir ../codon_usage/ENC_codon_nr_genewise_and_brachwise_200618/
for file in $(ls *.fa);do chips $file -odirectory_outfile ../codon_usage/ENC_codon_nr_genewise_and_brachwise_200618 -outfile ${file%.*}.enc;done


#branchwise codon usage frequency tables for the whole CDS set to compare with the conserved gene set
#for file in $(ls *.cds.fa)
#do chips $file -odirectory_outfile ../outputs/codon_usage/CUT_branchwise_total_CDS -outfile ${file%.*}.enc
#done

grep "Nc" *.enc > enc_genewise_orth_200618.txt
rm *.enc
