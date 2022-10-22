library(dplyr)

AC_LD_tbl <- read.delim("I:/psivakumar/AC_LD/plink_analysis/bothFamilies/AC_LD_bothFamilies_wiped-parametric.tbl")
AC_LD_par <- read.table("I:/psivakumar/AC_LD/plink_analysis/bothFamilies/AC_LD_bothFamilies_wiped.par", header = T)

region <- AC_LD_tbl %>%
  filter(CHR == 2, LOD > 1)

region_par <- AC_LD_par %>%
  filter(LOD > 1)

cm_start <- min(region_par$POSITION)
cm_end <- max(region_par$POSITION)  

AC_LD_map <- read.delim("I:/psivakumar/AC_LD/plink_analysis/bothFamilies/AC_LD_6_bothFamilies_thinned.map", header = FALSE)

AC_LD_snps <- AC_LD_map %>%
  filter(V1 == 2, V3 > floor(cm_start), V3 < ceiling(cm_end))

bp_start <- min(AC_LD_snps$V4)
bp_end <- max(AC_LD_snps$V4)

AC_LD_region <- paste0("chr2:", bp_start, "-", bp_end, sep = "")
