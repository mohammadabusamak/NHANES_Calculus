#install.packages("readr")    #if package is not installed already, then uncomment and run this line
#install.packages("dplyr")    #if package is not installed already, then uncomment and run this line
library(readr)
library(dplyr)


# the location where the .DAT file is saved:
setwd("/Users/mohammadabusamak/Library/Mobile Documents/com~apple~CloudDocs/Dalhousie/Research Side Projects/Calculus_NHANES/NHANES_Calculus")

# remove all objects from the R environment
rm(list=ls())


##############
#NHIS VERSION#
##############

# place survey name here (substitute survey name where <SURVEY> is):
srvyin <- paste("NHANES_III_MORT_2019_PUBLIC.dat")   # full .DAT name here
srvyout <- "NHANES_III" # shorthand dataset name here

# Example syntax:
#srvyin <- paste("NHIS_1986_MORT_2019_PUBLIC.dat")   
#srvyout <- "NHIS_1986"      


# read in the fixed-width format ASCII file
NHANES_III_MORT <- read_fwf(file=srvyin,
                col_types = "ciiiiiiidd",
                fwf_cols(publicid = c(1,14),
                         eligstat = c(15,15),
                         mortstat = c(16,16),
                         ucod_leading = c(17,19),
                         diabetes = c(20,20),
                         hyperten = c(21,21),
                         dodqtr = c(22,22),
                         dodyear = c(23,26),
                         wgt_new = c(27,34),
                         sa_wgt_new = c(35,42)
                ),
                na = c("", ".")
)



### import NHANES III (EXAM)
# install.packages("sascii")
library(SAScii)

# Load .DAT file using the .SAS input file
NHANES_III_General <- SAScii::read.SAScii("exam.dat", "exam.sas")
# Selecting approp. variables from NHANES III
NHANES_III <- NHANES_III_General %>% select(SEQN, HSAGEIR, HSSEX, DMARACER ,DEPEDENT,DEPCLFLG, starts_with("DEPUCL"), starts_with("DEPLCL"), MYPB5, MYPB6R, MYPB7R,DEPLAFLG,
                                            starts_with("DEPUMLA"), starts_with("DEPUBLA"), starts_with("DEPLMLA"), starts_with("DEPLBLA")) %>% 
  filter(HSAGEIR >= 75 & DEPEDENT == "3" & DEPCLFLG == "1")


%>% filter(!is.na(DEPCLFLG) & DEPCLFLG != 3)


