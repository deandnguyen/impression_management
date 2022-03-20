d <- read.csv("Deans Thesis.csv")

#Likeability
# .	imping_1 Compliment your colleagues so they will see you as likeable
# .	imping_2 Take an interest in your colleagues' personal lives to show them that you are friendly
# .	imping_3 Praise your colleagues for their accomplishments so they will consider you a nice person
# .	MISSING: Use flattery and favors to make your colleagues like you more
# .	MISSING: Do personal favors for your colleagues to show them that you are friendly

# Competence
# .	MISSING: Talk proudly about your experience or education
# .	impSP_1 Make people aware of your talents or qualifications
# .	impSP_2 Let others know that you are valuable to the organization
# .	impSP_3 Make people aware of your accomplishments

#CLEANING AND ADDING VALUES##############################################################################

#Select columns of interest, take off bonus,salary b/c they are more outcome
dc <-cbind.data.frame("imping_1" = d$imping_1, "imping_2" = d$imping_2, "imping_3" = d$imping_3,
                      "impsp_1" = d$impsp_1, "impsp_2" = d$impsp_2, "impsp_3" = d$impsp_3,
                      "race" = d$race, "managerrace" = d$managerrace,
                      "educ" = d$educ, "gender" = d$gender,
                      "workgroup_percentwhite" = d$workgroup_percentwhite,
                     "salary" = d$salary,"hours" = d$hours, "bonusactual" = d$bonusactual, "experience" = d$experience, "married_d" = d$married_d)


#Remove NA Values, 
library(tidyverse)

dc[dc==""]<-NA
dc <- drop_na(dc)
summary(dc)
#overall minority = 181, white = 1432...


#Adding Likeability and Competency Columns
dc$likeability <- rowMeans(dc[c('imping_1', 'imping_2', 'imping_3')])
dc$competence <- rowMeans(dc[c('impsp_1', 'impsp_2', 'impsp_3')])

#Employee Minority or Not, manager
dc$nonwhite <- dc$race != "White"
#dc$nonwhite <-as.integer(as.logical(dc$nonwhite))

dc$nonwhitemanager <- dc$managerrace != "White"
dc$whitemanager <- dc$managerrace == "White"

#Education level broken down to groups:
library(plyr) #do 3 groups, less than bachelor, bachelor, and more than bachelor
summary(dc$educ)
dc$educlevel <- revalue(dc$educ,
                             c("HS or less"="0", "2-yr degree"="0", 
                              "BA/BA degree"="1", "MA/MA degree"="2",
                                "Doctorate" = "2"))
dc$educlevel <- as.numeric(as.character(dc$educlevel))
summary(dc$educlevel)

#Gender
dc$ismale <- dc$gender == "Male"
dc$isfemale <- dc$gender == "Female"

#Percentage of non white employees
dc$workgroup_percentnonwhite <- 1-dc$workgroup_percentwhite
summary(dc$workgroup_percentwhite)

#CHANGE:select your variables, do a descriptive table, do a univariate and bivariate.
#Look at the distribution of key variables (ie performance, likeability)
#bivariate = 2 sample t test, boxplots, scatterplots,
#2 way table of own race, manager race (ie count how many people have own race and manager race the same, different, etc)
#do more data exploration first

table(dc$nonwhite, dc$whitemanager)
summary(dc$likeability)
summary(dc$competence)
summary(dc$gender)
summary(dc$educ)
summary(dc$experience)
summary(dc$married_d)


#likeability vs nonwhite/white
#regression with 4 dummy, but include 3 w/ manager race
#2 sample t test, to see if its different by own candidate racial status

shapiro.test(dc$likeability)
shapiro.test(dc$competence)

t.test(dc$nonwhite,dc$likeability, var.equal =TRUE)
t.test(dc$white, dc$likeability, var.equal = TRUE)
t.test(dc$likeability, dc$competence, alternative = "two.sided", var.equal = FALSE)

##########Regression#################################################################################################
#1st hypothesis:
# .	Hypothesis 1:  IM_Likeability_Competency = B0 + B1Non-White + B2Gender + 
#   B3Education level + B4Maritial status + B5Salary + 
#   B6Bonuses+ B7Hours worked per week + ...


summary(lm(likeability~nonwhite +ismale+hours+experience+educlevel+married_d,data=dc))
summary(lm(likeability~nonwhite, data=dc))

summary(lm(competence~nonwhite +ismale+hours+experience+educlevel+married_d,data=dc))
summary(lm(competence~nonwhite, data=dc))
#Results: nonwhite, ismale significant
#run without controls too

#Visualization########
boxplot(likeability~nonwhite,data=dc, main="Likeability vs Race",
        xlab="Nonwhite", ylab="Likeability")

boxplot(competence~nonwhite,data=dc, main="Competence vs Race",
        
        xlab="Nonwhite", ylab="Competence")
##########################################################################################################
#2nd hypothesis: 
# .	Hypothesis 2: IM = B0 + B1Non-White + B2Manager White + B3Non-White*Manager White + ...

summary(lm(likeability~nonwhite + whitemanager + nonwhite*whitemanager +ismale+isfemale+salary+bonusactual+hours+experience+educlevel+married_d,data=dc))
#results: nonwhite, ismale,hours, experience significant
summary(lm(competence~nonwhite + whitemanager + nonwhite*whitemanager +ismale+isfemale+salary+bonusactual+hours+experience+educlevel+married_d,data=dc))
#results: ismale significant

##########################################################################################################
#3rd hypothesis: 
#.	Hypothesis 3: IM_Likeability_Competency = B0 + B1Non-White + B2% of Non-White + B3% of Non-White*Non-White ...
        
summary(lm(likeability~nonwhite + workgroup_percentnonwhite + workgroup_percentnonwhite*nonwhite
             +ismale+isfemale+salary+bonusactual+hours+experience+educlevel+married_d,data=dc))
#results:workgroup_percentnonwhite, ismale, hours, experience significant
summary(lm(competence~nonwhite + workgroup_percentnonwhite + workgroup_percentnonwhite*nonwhite
           +ismale+isfemale+salary+bonusactual+hours+experience+educlevel+married_d,data=dc))
#results: ismale 1.864, otherwise else is insig

#Visualization########
ggplot(data = dc, aes(x = workgroup_percentnonwhite, y = likeability)) + geom_point() + geom_smooth(method= "lm", se = FALSE)

