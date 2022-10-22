library(dplyr)

map_file <- read.delim("I:/psivakumar/AC_LD/plink_analysis/AC_LD_2_prunedSNPs.map", header = F)
chr <- read.delim("J:/NGS_Reference/HapMap_Reference/genetic_map_HapMapII_GRCh37/genetic_map_GRCh37_autosomes.txt", header = F)

map_cm <- left_join(map_file, chr, by = c("V1", "V4" = "V2")) %>%
  dplyr::select(V1, V2, V4.y, V4)

snpsNocM <- map_cm %>%
  filter(is.na(V4.y)) %>%
  dplyr::select(V2)

write.table(na.omit(map_cm), "I:/psivakumar/AC_LD/plink_analysis/mapUpdate.txt", row.names = FALSE, quote = FALSE, col.names = FALSE, sep = '\t')
write.table(snpsNocM, "I:/psivakumar/AC_LD/plink_analysis/snpsNocMRemove.txt", row.names = FALSE, quote = FALSE, col.names = FALSE)
