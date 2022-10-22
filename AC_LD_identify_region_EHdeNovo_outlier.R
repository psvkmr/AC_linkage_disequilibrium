library(tidyverse)
library(data.table)

canvas.outlier <- read.delim("I:/psivakumar/CANVAS/EHdeNovo/EHdeNovo_CANVAS_outlier_analysis.txt", header = F)
canvas.comp <- read.delim("I:/psivakumar/CANVAS/EHdeNovo/EHdeNovo_CANVAS_anchIRRs_compared.txt", header = F)

ac.ld.outlier <- read.delim("I:/psivakumar/AC_LD/EHdeNovo/EHdeNovo_dHMN5_outlier_analysis.txt", header = F)
ac.ld.comp <- read.delim("I:/psivakumar/AC_LD/EHdeNovo/EHdeNovo_dHMN5_anchIRRs_compared.txt", header = F)
ac.ld.manifest <- read.delim("I:/psivakumar/AC_LD/EHdeNovo/EHdeNovo_dHMN5_sample_manifest.txt", header = F)

ac.ld.outlier.split <- ac.ld.outlier %>%
  separate(V6, into = as.character(ac.ld.manifest$V1), sep = ",") 

ac.ld.case.highest <- c()

for (i in 1:nrow(ac.ld.outlier.split)) {
  if (names(which.max(ac.ld.outlier.split[i, c(6:55)])) == "HOU0146") {
    ac.ld.case.highest <- c(ac.ld.case.highest, i)
  }
}

ac.ld.case.highest.df <- ac.ld.outlier.split[ac.ld.case.highest, ]
ac.ld.case.highest.df.linked <- filter(ac.ld.case.highest.df, 
                                       V1 == 2, 
                                       V2 >= 22800000, 
                                       V3 <= 41161000)

fwrite(ac.ld.case.highest.df.linked, "I:/psivakumar/AC_LD/EHdeNovo/highest_df_linked_region_repeats.csv")
