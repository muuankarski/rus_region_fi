library(rustfare)
ind <- IndicatorRosstat()

fedDist01 <- GetRosstat(indicator=ind[1,1],level="federal_district")
fedDist02 <- GetRosstat(indicator=ind[2,1],level="federal_district")
fedDist03 <- GetRosstat(indicator=ind[3,1],level="federal_district")
fedDist04 <- GetRosstat(indicator=ind[4,1],level="federal_district")
fedDist05 <- GetRosstat(indicator=ind[5,1],level="federal_district")
fedDist06 <- GetRosstat(indicator=ind[6,1],level="federal_district")
fedDist07 <- GetRosstat(indicator=ind[7,1],level="federal_district")
fedDist08 <- GetRosstat(indicator=ind[8,1],level="federal_district")
fedDist09 <- GetRosstat(indicator=ind[9,1],level="federal_district")
fedDist10 <- GetRosstat(indicator=ind[10,1],level="federal_district")
fedDist11 <- GetRosstat(indicator=ind[11,1],level="federal_district")
fedDist12 <- GetRosstat(indicator=ind[12,1],level="federal_district")
fedDist13 <- GetRosstat(indicator=ind[13,1],level="federal_district")
fedDist14 <- GetRosstat(indicator=ind[14,1],level="federal_district")
fedDist15 <- GetRosstat(indicator=ind[15,1],level="federal_district")
fedDist16 <- GetRosstat(indicator=ind[16,1],level="federal_district")
fedDist17 <- GetRosstat(indicator=ind[17,1],level="federal_district")
fedDist18 <- GetRosstat(indicator=ind[18,1],level="federal_district")
fedDist19 <- GetRosstat(indicator=ind[19,1],level="federal_district")
fedDist20 <- GetRosstat(indicator=ind[20,1],level="federal_district")
fedDist21 <- GetRosstat(indicator=ind[21,1],level="federal_district")

fedDistDat <- rbind(fedDist01,fedDist02,fedDist03,fedDist04,fedDist05,
                    fedDist07,fedDist08,fedDist09,fedDist10,
                    fedDist11,fedDist12,fedDist13,fedDist14,
                    fedDist15,fedDist16,fedDist17,fedDist18,
                    fedDist19,fedDist20,fedDist21)

fedDistDat$region_en <- paste("FD",fedDistDat$region_en,sep="_")
## --- REGIONAL LEVEL ---- ##


reg01 <- GetRosstat(indicator=ind[1,1],level="region")
reg02 <- GetRosstat(indicator=ind[2,1],level="region")
reg03 <- GetRosstat(indicator=ind[3,1],level="region")
reg04 <- GetRosstat(indicator=ind[4,1],level="region")
reg05 <- GetRosstat(indicator=ind[5,1],level="region")
reg06 <- GetRosstat(indicator=ind[6,1],level="region")
reg07 <- GetRosstat(indicator=ind[7,1],level="region")
reg08 <- GetRosstat(indicator=ind[8,1],level="region")
reg09 <- GetRosstat(indicator=ind[9,1],level="region")
reg10 <- GetRosstat(indicator=ind[10,1],level="region")
reg11 <- GetRosstat(indicator=ind[11,1],level="region")
reg12 <- GetRosstat(indicator=ind[12,1],level="region")
reg13 <- GetRosstat(indicator=ind[13,1],level="region")
reg14 <- GetRosstat(indicator=ind[14,1],level="region")
reg15 <- GetRosstat(indicator=ind[15,1],level="region")
reg16 <- GetRosstat(indicator=ind[16,1],level="region")
reg17 <- GetRosstat(indicator=ind[17,1],level="region")
reg18 <- GetRosstat(indicator=ind[18,1],level="region")
reg19 <- GetRosstat(indicator=ind[19,1],level="region")
reg20 <- GetRosstat(indicator=ind[20,1],level="region")
reg21 <- GetRosstat(indicator=ind[21,1],level="region")

regDat <- rbind(reg01,reg03,reg04,reg05,
                reg07,reg08,reg09,reg10,
                reg11,reg12,reg13,reg14,
                reg15,reg16,reg17,reg18,
                reg19,reg20)

datFedDist <- fedDistDat[,c("region_en","year","indicator","value","level")]
datReg <- regDat[,c("region_en","year","indicator","value","level")]

####### Load shapefile keys from my github

library(RCurl)
GHurl <- getURL("https://raw2.github.com/muuankarski/data/master/russia/regionkey.csv")
reg <- read.csv(text = GHurl)
GHurl <- getURL("https://raw2.github.com/muuankarski/data/master/russia/regionkey_fd.csv")
dist <- read.csv(text = GHurl)
# names(dist) <- c("idx","russian","ID","NAME_1","region_en")

# Join rosstat with geos
datFedDist <- merge(datFedDist,dist,by="region_en")
datReg <- merge(datReg,reg,by="region_en")

# Write each level indicidually
save(datReg, file="data/datReg.RData")
save(datFedDist, file="data/datFedDist.RData")