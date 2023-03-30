# Q1 

# Imported and read the IrelandCrime.csv file into Rstudio and assigned the csv to the variable called Ireland_crime and recode the spaces as NA

Ireland_crime <- read.csv("IrelandCrime.csv", na = "")



# Showed the structure of the dataframe by using the str funtion. This shows the number of observations and variables 
# and also the datatypes of each variable.
str(Ireland_crime)

# Called the first 10 rows of the dataset to further see the structure
head(Ireland_crime, 10)





#Q2
# Filtering the datset to include crime figures from 2015 to 2019
Ireland_crime <- Ireland_crime[,c(1,2,3,4,5, 54:72)]

# Confirming that the only the years of 2015 to 2019 were included in the filtered list
Ireland_crime

#Updating the column names of the names of some variables to more readable names
colnames(Ireland_crime)[1] <- "Region"
colnames(Ireland_crime)[2] <- "Divison"
colnames(Ireland_crime)[3] <- "OffenceCode"
colnames(Ireland_crime)[4] <- "Offence"
colnames(Ireland_crime)[5] <- "OffenseType"

#Calling the filtered list to show the changes I made to the variable names and also calling only the years 2015 to 2019
Ireland_crime

 

#Q3
# The names of some of the offence descriotions are too risky so I will replace the lengthy names with more easily readable names.

Ireland_crime[Ireland_crime == "ATTEMPTS/THREATS TO MURDER/ASSAULTS/ HARASSMENTS AND RELATED OFFENCES"] <- "Murder/assault/harassment"
Ireland_crime[Ireland_crime == "DANGEROUS OR NEGLIGENT ACTS"] <- "Dangerous acts "
Ireland_crime[Ireland_crime == "KIDNAPPING AND RELATED OFFENCES "] <- "Kidnapping"
Ireland_crime[Ireland_crime == "ROBBERY/EXTORTION AND HIJACKING OFFENCES "] <- "Robbery"
Ireland_crime[Ireland_crime == "THEFT AND RELATED OFFENCES "] <- "Theft"
Ireland_crime[Ireland_crime == "FRAUD/DECEPTION AND RELATED OFFENCES "] <- "Fraud"
Ireland_crime[Ireland_crime == "PUBLIC ORDER AND OTHER SOCIAL CODE OFFENCES"] <- "Public order"
Ireland_crime[Ireland_crime == "OFFENCES AGAINST GOVERNMENT/ JUSTICE PROCEDURES AND ORGANISATION OF CRIME "] <- "Offences against government"


#Q4
# Here I summed up all the columns in the dataframe to get a summary of the number of crimes commited and assigned it to the CrimeSummary variable
CrimeSummary <- rowSums(Ireland_crime[,c(6:24)])
summary(CrimeSummary)
# The summary of the crimes commited goes thus. The minimum crimes comminted is 0, the maximum is 22,812, the first quartile is 7, the median is 38, the mean is 629.4, the 3rd quartile is 22,812


#Q5

# Installed the VIM package and checked the missing values and saw that there were 13 missing values in the Offense variable
install.packages("VIM")
library(VIM)
missing_values <- aggr(Ireland_crime$OFFENCE, prop = FALSE, numbers = TRUE)
summary(missing_values)

# The offence data was not missing at random (NMAR). Thisis because all the missing values had very little crimes reported and they were all Weapons and exposive offenses. 

Newmissingvlaues <- na.omit(Ireland_crime)
Newmissingvlaues

# I went ahead and dropped the missing values from the dataframe because the missing values were categorical data. I learnt in class not to replace categorical values. In this case, I know the pattern of the missing values all fall under the weapons and explosive offences but I can't tell the exact offence to classify it under so I decided to drop all 13 rows of missing values.








#Q6
region <- aggregate(Ireland_crime$borough, by = list(borough), FUN = mean)
