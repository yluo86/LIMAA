########################################
# Working with 1000GP Phase 3 data and various tasks
# Assume we have 1000GP Phase 3 data download from ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/
######################

###################
# Converting to PLINK format
##################

#Define Software locations
PLINK='/medpop/srlab/yang/software/plink'
ADMIXTURE='/medpop/srlab/yang/software/admixture_linux-1.23/admixture'
#####################
# Working with bi-allelic SNPs only
##################
G1K='/medpop/srlab/TB/1000g/all'


######################
# Principal component analysis
####################
#1. pruning common variants
$PLINK --bfile $G1K --maf 0.01 --indep-pairwise 50 10 0.1 --out all
#2. output pruned file
$PLINK --bfile $G1K --extract all.prune.in --make-bed --out prunedALL
#3. pca analysis
$PLINK --bfile prunedALL --pca --out all 
#ploting
R CMD BATCH g1k_pc_plot.R

################
# ADMIXTURE 
################
# 1. Prune dataset for common SNPs (MAF >= 1%)
$PLINK --bfile $G1K --snps-only --indep-pairwise 50 10 0.1 --maf 0.01 --make-bed --out all --threads 32
# 2. Extract variants that are LD independent
plink --bfile all --extract all.prune.in --make-bed --out prunedALL --threads 32
# 3. Choose the optimal K
for K in {3..20}
do
 $ADMIXTURE --cv prunedALL.bed $K -j32 | tee log${K}.out; done
done

#ploting admixture results
R CMD admixture_plots.R
