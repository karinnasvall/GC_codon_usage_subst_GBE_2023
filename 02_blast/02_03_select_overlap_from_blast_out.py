import sys
import os
import string
import pandas
import numpy as np
import matplotlib.pyplot as plt
import statsmodels.api as sm
import seaborn as sns
import itertools
import math
import time
import sys
import personal_popgen
from pandas.tools.plotting import scatter_matrix
import Bio.Data.CodonTable
from Bio.Seq import Seq
from Bio.Alphabet import IUPAC
import argparse


n=[stuff.strip() for stuff in open('Lepidoptera_dnds_project//scripts/output_files.txt')]
names=["Query","Target","Percent_identity","Alignment_length","Number_of_mismatches","Number_of_gap_opens","Start_position_in_query","End_position_in_query","Start_position_in_target","End_position_in_target","E_value","Bit_score"]
list_1=pandas.DataFrame( columns=["Query","Target"])

def best_hit_filter(table_file_name):
	names=["Query","Target","Percent_identity","Alignment_length","Number_of_mismatches","Number_of_gap_opens","Start_position_in_query","End_position_in_query","Start_position_in_target","End_position_in_target","E_value","Bit_score"]
	table=pandas.read_table(table_file_name,names=names, sep='\t', header=None)
	output=pandas.DataFrame( columns=names)
	for i in list(table.Target.unique()):
		temp=table[table.Target == i]
		if len(temp) == 1 or list(table.Query.unique()) == 1:
			output=output.append(temp[0:1], ignore_index=True)
		else:
			temp=temp.sort_values(by=['Alignment_length'], ascending=False)
			output=output.append(temp[0:1], ignore_index=True)
	return output



table0=best_hit_filter('Lepidoptera_dnds_project/outputs/BLAST_outputs/'+n[0])
table1=best_hit_filter('Lepidoptera_dnds_project/outputs/BLAST_outputs/'+n[1])
table2=best_hit_filter('Lepidoptera_dnds_project/outputs/BLAST_outputs/'+n[2])
table3=best_hit_filter('Lepidoptera_dnds_project/outputs/BLAST_outputs/'+n[3])
table4=best_hit_filter('Lepidoptera_dnds_project/outputs/BLAST_outputs/'+n[4])
table5=best_hit_filter('Lepidoptera_dnds_project/outputs/BLAST_outputs/'+n[5])
table6=best_hit_filter('Lepidoptera_dnds_project/outputs/BLAST_outputs/'+n[6])



list_1=list_1.append(table0[["Query","Target"]])
list_1=pandas.merge(list_1,table1[["Query","Target"]], on=['Target'], how='outer')
list_1=pandas.merge(list_1,table2[["Query","Target"]], on=['Target'], how='outer')
list_1=pandas.merge(list_1,table3[["Query","Target"]], on=['Target'], how='outer')
list_1=pandas.merge(list_1,table4[["Query","Target"]], on=['Target'], how='outer')
list_1=pandas.merge(list_1,table5[["Query","Target"]], on=['Target'], how='outer')
list_1=pandas.merge(list_1,table6[["Query","Target"]], on=['Target'], how='outer')

list_2=list_1.dropna(axis=0, how='any')
list_2=list_2.drop_duplicates()

list_2.to_csv("Lepidoptera_dnds_project/outputs/BLAST_outputs/overlap_new.csv")



