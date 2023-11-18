if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version = "3.18")

BiocManager::install("org.At.tair.db")

# refseqIDをtairIDに変換
setwd("~/refseq2tair") # 任意のディレクトリに移動
getwd()

library(org.At.tair.db)

table = read.table("input.txt", header = TRUE, sep="\t")
library(stringr)
table$refseq <- str_sub(table$RefSeq, end = -3)

ID <- as.list(org.At.tairREFSEQ2TAIR)
table$tair <- ID[table$refseq]
sapply(table, class)
table <- dplyr::mutate(table, tair = as.character(tair)) # list型をcharacter型に変換
sapply(table, class)

write.table(table, file = "output.txt", col.names = T, row.names = F, sep="\t", quote = F)