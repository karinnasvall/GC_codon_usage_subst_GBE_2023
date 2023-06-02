#!/bin/bash -l

#SBATCH -A snic2017-1-615
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 10:00:00
#SBATCH -J raxml_tree
#SBATCH --mail-user karin.nasvall@ebc.uu.se
#SBATCH --mail-type=ALL

module load bioinfo-tools
module load raxml

cd /proj/uppstore2017185/b2014034_nobackup/Karin/Lepidoptera_dnds_project/outputs/raxml_result_180813/

#raxml tree created from subset of concatenated sequences (1091 genes)

#real run, unrooted tree
raxmlHPC-PTHREADS-AVX -m GTRGAMMA -p 12345 -s Lepidoptera_testconcatenated.phy -N 20 -n 1091tree

#-m GTRGAMMA 	GTR + Optimization of substitution rates + GAMMA model of rate heterogeneity (alpha parameter will be estimated).
#-p 12345 random seed
#-o outgroup optional but  PaML recommends not using an outgroup…
#-# or -N nr of alternative runs
#-n name of output


