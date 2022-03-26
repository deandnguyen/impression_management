# Project Overview

Existing research have shown how negative stereotypes affect perceptions of nonwhite employee’s work performance. One possible measure minorities may use to combat these negative stereotypes is through impression management. Impression management is where individuals behave in a certain way to influence how others perceive them (i.e. complimenting coworkers to increase likeability or reminding others of their achievements to show competency). This study aims to assess whether there is a difference between whites and minorities in their use of impression management behaviors.

To examine these variables, a multivariate regression tests was conducted on survey data from a large company to see the relationship between employee race, manager race, workgroup racial composition and impression management behavior. Through my analysis, I found that nonwhite employees display higher impression management behaviors around competency compared to white employees, except when they are in majority white employee workgroups. 

# Hypotheses and Empirical Plan
Through my research, I developed three hypotheses for comparing impression management behaviors against race:
•	Hypothesis 1: Nonwhite relative to white employees will exhibit greater competency and likeability related impression management behavior
•	Hypothesis 2: The impression management behavior for likeability and competency will be stronger when the manager is white relative to nonwhite for nonwhite employees
•	Hypothesis 3: Nonwhite relative to white employees will exhibit greater impression management behaviors around likeability and competency for workgroups with a lower percentage of nonwhites

To test these hypotheses, I ran a multivariate regression test against csv survey data using R. The survey used a Likert scale from 1 to 7, asking employees to rate, “how frequently do you use each of the following strategies at work?” The below questions were made to address impression management likeability measures:
•	Compliment your colleagues so they will see you as likeable
•	Take an interest in your colleagues’ personal lives to show them that you are friendly
•	Praise your colleagues for their accomplishments so they will consider you a nice person
The results of these questions were averaged out to create a variable representing impression management around likeability. Furthermore, the following questions addressed impression management around competency:
•	Make people aware of your talents or qualifications
•	Let others know that you are valuable to the organization
•	Let others know that you have a reputation for being competent in a particular area
Similarly, the results of the competency questions scores were averaged to make up an index to represent impression management competency. 

# Results
Through this research, I analyzed a survey of respondents rating how likely they are to display behaviors influencing other’s perception on how likeable and competent they are. I found that nonwhite employees are more likely than white employees to try to influence others on how competent they are in the workplace. The findings from the regression are shown in column 2 of the below table.
![image](https://user-images.githubusercontent.com/51719335/160255219-46da4dc1-157b-47fd-b52f-811de4957c61.png)

I find support for this hypothesis for Blacks at the 5% significance level, Asians at the 1% significance level, and Hispanics or Latinos at the 1% significance level. Therefore, there is a positive difference between all the minority subgroups and whites on impression management competency behaviors. Blacks report 0.286, Asians .349, and Hispanics or Latinos .405 higher for competence on a 7-point scale relative to white employees, controlling for gender, hours, experience, educational levels, and marriage. These differences can also be seen within Graph 3 of the box plot visualization below.
![image](https://user-images.githubusercontent.com/51719335/160255225-79f44726-5143-48cc-857d-0cf007a21501.png)


The regressions failed to support my other hypotheses that nonwhite employees would have to display higher impression management around likeability. The regressions also failed to support that nonwhite employees with a white manager would display higher impression management, or that nonwhite employees in a less diverse workgroup would display higher impression management.


