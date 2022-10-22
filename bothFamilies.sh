mkdir bothFamilies
scp AC_LD_4_cMSnps* bothFamilies/
scp keepSamples.txt bothFamilies/
scp founders.txt bothFamilies/
scp merlin.model bothFamilies/merlin_bothFam.model

cd bothFamilies/

plink --bfile AC_LD_4_cMSnps --keep keepSamples.txt --recode --make-bed --out AC_LD_5_keepSamplesTwoFamilies

plink --bfile AC_LD_5_keepSamplesTwoFamilies --thin-count 5000 --recode --make-bed --out AC_LD_6_bothFamilies_thinned

cut -f 1,2,3 AC_LD_6_bothFamilies_thinned.map > merlin_bothFam.map
cut -f 2 merlin_bothFam.map > merlin_bothFam.dat
sed -i 's/^/M /g' merlin_bothFam.dat
sed -i '1 i\A dHMN' merlin_bothFam.dat

cat AC_LD_6_bothFamilies_thinned.ped founders.txt > merlin_bothFam.ped

zeros=$(printf ' 0%.0s' {1..10000})
sed -i "14s/$/${zeros}/" merlin_bothFam.ped
sed -i "15s/$/${zeros}/" merlin_bothFam.ped
sed -i "16s/$/${zeros}/" merlin_bothFam.ped
sed -i "17s/$/${zeros}/" merlin_bothFam.ped
sed -i "18s/$/${zeros}/" merlin_bothFam.ped
sed -i "19s/$/${zeros}/" merlin_bothFam.ped
sed -i "20s/$/${zeros}/" merlin_bothFam.ped
sed -i "21s/$/${zeros}/" merlin_bothFam.ped
sed -i "22s/$/${zeros}/" merlin_bothFam.ped
sed -i "23s/$/${zeros}/" merlin_bothFam.ped
sed -i "24s/$/${zeros}/" merlin_bothFam.ped
sed -i "25s/$/${zeros}/" merlin_bothFam.ped
sed -i "26s/$/${zeros}/" merlin_bothFam.ped
sed -i "27s/$/${zeros}/" merlin_bothFam.ped
sed -i 's/-9/0/g' merlin_bothFam.ped

awk 'FNR==1{$6=2};1' merlin_bothFam.ped > tmp1
awk 'FNR==2{$6=2};1' tmp1 > tmp2
awk 'FNR==3{$6=1};1' tmp2 > tmp3
awk 'FNR==4{$6=1};1' tmp3 > tmp4
awk 'FNR==5{$6=2};1' tmp4 > tmp5
awk 'FNR==6{$6=2};1' tmp5 > tmp6
awk 'FNR==7{$6=1};1' tmp6 > tmp7
awk 'FNR==8{$6=1};1' tmp7 > tmp8
awk 'FNR==9{$6=2};1' tmp8 > tmp9
awk 'FNR==10{$6=1};1' tmp9 > tmp10
awk 'FNR==11{$6=2};1' tmp10 > tmp11
awk 'FNR==12{$6=2};1' tmp11 > tmp12
awk 'FNR==13{$6=2};1' tmp12 > tmp13
mv tmp13 merlin_bothFam.ped

/data/kronos/Genetics_Software/pedstats-0.6.12/pedstats -d merlin_bothFam.dat -p merlin_bothFam.ped > pedstats_results.txt
