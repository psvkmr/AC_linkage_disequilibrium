#!/bin/bash

# scp AC_LD_4_cMSnps* linkage_region_haplo/
# scp founders.txt linkage_region_haplo/
# scp keepSamplesWithMartin.txt linkage_region_haplo/

# created andrea_region.txt file containing only regions with SNPs of interest in andrea_region_map.R
# created update.pheno file with phenotype status for genotyped samples

plink --bfile AC_LD_4_cMSnps --keep keepSamplesWithMartin.txt --extract andrea_snps.txt --make-bed --recode --out AC_LD_5_keep

awk 'BEGIN {FS=OFS=" "}NR == FNR {a[FNR] = $B;next}{$A = a[FNR];print $0}' B=3 A=6 update.pheno AC_LD_5_keep.ped > tmp
cp founders.txt tmp2
sed -i 's/-9/0/g' tmp2
# remove bottom 3 rows as they are for family 
sed -i 11q tmp2
# get number of columns to add with awk '{print NF}' <ped file>, here 444-6=438
zeros=$(printf ' 0%.0s' {1..438})
sed -i "s/$/${zeros}/" tmp2
cat tmp1 tmp2 > andrea_region.ped

cut -f1-3 AC_LD_5_keep.map > andrea_region.map
cut -f2 andrea_region.map > andrea_region.dat
sed -i 's/^/M /g' andrea_region.dat

/data/kronos/Genetics_Software/MERLIN/merlin -p andrea_region.ped -d andrea_region.dat -m andrea_region.map --best --horizontal --tabulate --markerNames --prefix andrea_region_haplo_fam1 > andrea_region_haplo_fam1.out
