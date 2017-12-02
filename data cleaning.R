#Rental_value
Rental <- X_rent_of_region
IL_Rental <- subset(Rental, subset = State=="IL")
list(IL_Rental)
which(is.na(IL_Rental))
na.exclude(IL_Rental)
IL_Rental <- na.exclude(IL_Rental)
list(IL_Rental)
levels(factor(IL_Rental$County))
library(dplyr)
IL_Rental_County <- IL_Rental %>%
  group_by(County) %>%
  summarise(Q = mean(QoQ))
write.csv(IL_Rental_County,file = "/Users/bijunlei/Documents/Github/STAT425-final/IL_Rental_County.csv")
#employment
list(IL_county_employment)
IL_County_employment <- IL_county_employment %>%
  group_by(GeoName)%>%
  summarise(employment_rate =mean(`2016`))
IL_County_employment <- data.frame(IL_County_employment)
which(is.na(IL_County_employment))
write.csv(IL_County_employment,file = "/Users/bijunlei/Documents/Github/STAT425-final/IL_County_employment.csv")
#income
IL_county_income$Description
IL_County_income <- subset(Il_county_income, subset = Description == "Personal income (thousands of dollars)")
IL_County_income <- data_frame(IL_County_income$GeoName,IL_County_income$`2016`)
IL_County_income
write.csv(IL_County_income,file = "/Users/bijunlei/Documents/Github/STAT425-final/IL_County_income.csv")
#population
IL_county_pop$`Population Estimate (as of July 1) - 2016 - Both Sexes; Total`
IL_County_pop <- data.frame(IL_county_pop$Geography,IL_county_pop$`Population Estimate (as of July 1) - 2016 - Both Sexes; Total`)
write.csv(IL_County_pop,file = "/Users/bijunlei/Documents/Github/STAT425-final/IL_County_pop.csv")
#room type
#one-bed
one_bed <- subset(County_Zhvi_1bedroom, subset = State == "IL")
attach(one_bed)
one_bed[,257:266]
one_bed_price <- rowMeans(one_bed[,257:266])
one_bed_county <- data.frame(RegionName,Metro,one_bed_price)
detach(one_bed)
#two-bed
two_bed <- subset(County_Zhvi_2bedroom, subset = State == "IL")
attach(two_bed)
two_bed[,257:266]
two_bed_price <- rowMeans(two_bed[,257:266])
two_bed_county <- data.frame(RegionName,Metro,two_bed_price)
detach(two_bed)
#three-bed
thr_bed <- subset(County_Zhvi_3bedroom, subset = State == "IL")
attach(thr_bed)
thr_bed[,257:266]
thr_bed_price <- rowMeans(thr_bed[,257:266])
thr_bed_county <- data.frame(RegionName,Metro,thr_bed_price)
detach(thr_bed)
#four-bed
four_bed <- subset(County_Zhvi_4bedroom, subset = State == "IL")
attach(four_bed)
four_bed[,257:266]
four_bed_price <- rowMeans(four_bed[,257:266])
four_bed_county <- data.frame(RegionName,Metro,four_bed_price)
detach(four_bed)
#five and more
fiv_bed <- subset(County_Zhvi_5BedroomOrMore, subset = State == "IL")
attach(fiv_bed)
fiv_bed[,257:266]
fiv_bed_price <- rowMeans(fiv_bed[,257:266])
fiv_bed_county <- data.frame(RegionName,Metro,fiv_bed_price)
detach(fiv_bed)
write.csv(
  one_bed_county, file = "/Users/bijunlei/Documents/Github/STAT425-final/onebed.csv")
write.csv(two_bed_county, file = "/Users/bijunlei/Documents/Github/STAT425-final/twobed.csv")
          
write.csv(thr_bed_county, file = "/Users/bijunlei/Documents/Github/STAT425-final/thrbed.csv")
write.csv(four_bed_county, file = "/Users/bijunlei/Documents/Github/STAT425-final/fourbed.csv")
write.csv(fiv_bed_county, file = "/Users/bijunlei/Documents/Github/STAT425-final/fivebed.csv")


