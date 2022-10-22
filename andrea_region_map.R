map.file <- read.table("I:/psivakumar/AC_LD/plink_analysis/withMartin/andrea_region_haplo/AC_LD_4_cMSnps.map")

start.snp = "rs13425940"
end.snp = "rs9309065"

start.row = grep(start.snp, map.file$V2)
end.row = grep(end.snp, map.file$V2)

andrea.region.map = map.file[start.row:end.row, ]

write.table(andrea.region.map$V2, "I:/psivakumar/AC_LD/plink_analysis/withMartin/andrea_region_haplo/andrea_snps.txt", row.names = FALSE, quote = FALSE, sep = '\t')
