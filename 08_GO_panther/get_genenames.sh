do
grep "$line" overlap_new.csv >> list_sign_180606_sinapis_dmel.txt                       
done
#get a list of sign genenames
cut -f 1,2,3 -d "." Lepidoptera_paml_BS_result.new.sign.selection.txt > lists_sign_genenames.txt

#sign selection sinapis
for file in $(cat ../paml_result/paml_BS/list_sign_180606)
do 
grep "sinap" $file >> ../paml_result/paml_BS/list_sign_180606_sinapis_names
done

#all aligned genes for ref
for file in $(cat list_bestalignments.txt)
do
grep "sinap" $file >> Lepidoptera.paml.genename.allref.table
done


#for sign genes in Leptidea
sed 's/>/ /g' list_sign.genename.sinapis.table > list_sign.genename.sinapis.table.corr

for line in $(cat list_sign.genename.sinapis.table.corr)
do 
grep "$line" overlap_new.csv >> list_sign.genename.sinapis_dmel.table
done 
#106 genes overlap

awk -F\-P '{print $1}' list_sign.genename.sinapis_dmel.table > list_sign.genename.sinapis_dmel.pantherinput


#for all genes as ref
sed 's/>/ /g' Lepidoptera.paml.lnL.sign.genename.allref.table > Lepidoptera.paml.lnL.sign.genename.allref.table.corr

for line in $(cat Lepidoptera.paml.lnL.sign.genename.allref.table.corr)
do
grep "$line" overlap_new.csv >> Lepidoptera.paml.lnL.sign.genename.sinapis_dmel.allref.table
done

awk -F\-P '{print $1}' Lepidoptera.paml.lnL.sign.genename.sinapis_dmel.allref.table > Lepidoptera.paml.lnL.sign.genename.sinapis_dmel.allref.pantherinput

for line in $(cat list_sign_180606_sinapis_corr)
do
grep "$line" overlap_new.csv >> list_sign_180606_sinapis_dmel.txt
done
#106 genes overlap


awk -F\-P '{print $1}' list_sign_180606_sinapis_dmel.txt > list_sign.genename.180606.sinapis_dmel.pantherinput

