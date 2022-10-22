library(dplyr)

AC_sexcheck <- read.table("I:/psivakumar/AC_LD/AC_4_checkSex.sexcheck", header = T)
AC_IBS <- read.table("I:/psivakumar/AC_LD/AC_3_IBS.genome", header = T)

sex_check_hist <- hist(AC_sexcheck$F)
isTRUE(nrow(AC_sexcheck) == nrow(filter(AC_sexcheck, PEDSEX == SNPSEX)))

pihat_checker <- function(df, Ind1, Ind2) {
  filt <- df[grep(paste(c(Ind1, Ind2), collapse = "|"), df$IID1), ]
  filt2 <- filt[grep(paste(c(Ind1, Ind2), collapse = "|"), filt$IID2), ]
  return(filt2$PI_HAT)
}

AC_LD_samples <- c("201429410141_R01C02", "201429410141_R02C02", "201429410141_R03C02", 
                   "201429410141_R04C02", "201429410141_R05C02", "201429410141_R07C02", 
                   "201429410141_R09C02", "201429410141_R11C02", "95645")

AC_LD_fam <- read.table("I:/psivakumar/AC_LD/AC_17052018.fam")

AC_LD_keepSamples <- filter(AC_LD_fam, V2 %in% AC_LD_samples) %>%
  dplyr::select(V1, V2)

write.table(AC_LD_keepSamples, "I:/psivakumar/AC_LD/AC_keepSamples.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)
