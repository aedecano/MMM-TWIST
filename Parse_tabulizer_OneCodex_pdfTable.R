###Parse PDF summary outputs from OneCodex using Tabulizer

#Set the R session to 32 bit instead of the default 64 bit
#install.packages("remotes")
library(remotes)
#remotes::install_github(c("ropensci/tabulizerjars", "ropensci/tabulizer"), INSTALL_opts = "--no-multiarch", dependencies = c("Depends", "Imports"))
library(tidyverse)
library(tabulizer)

# Extract the table from PDF
pdf <- extract_tables("SCov2_10_6_NPS8PX.fastq.gz.report.pdf", pages = 1:2) #load with relevant PDF file and # of pages
# Extract the first and 2nd page of the pdf file
View(pdf[[1]])
df1 <- as.data.frame(pdf[[1]], row.names = FALSE)
df1$V4 <- c(0,0,0,0) # add another column with coverage corresponding non-detection
df1

View(pdf[[2]])
df2 <- as.data.frame(pdf[[2]], row.names = FALSE)
df2

df3 <- rbind(df1,df2)
colnames(df3) <- c("Genome", "Tax ID", "Detection Status", "Coverage/Depth/Identity")
df3

write.csv(df3, file = "sample_out.csv") #Rename output csv file as suits

##Interact with table (don't select column headers)
extract_areas('SCov2_10_6_NPS8PX.fastq.gz.report.pdf', pages = 1:2)

#By page
interact1 <- extract_areas('SCov2_10_6_NPS8PX.fastq.gz.report.pdf', pages = 1)
idf1 <- as.data.frame(interact1)
idf1

interact2 <- extract_areas('SCov2_10_6_NPS8PX.fastq.gz.report.pdf', pages = 2)
idf2 <- as.data.frame(interact2)
idf2

idf3 <- rbind(idf1, idf2)
colnames(idf3) <- c("Genome", "Tax ID", "Detection Status", "Coverage/Depth/Identity")

write.csv(idf3, file = "table_FromInteraction.csv")
###
