Question 1: First Impression:  Although R programming can be very challenging to learn, its use is universal and powerful. Learners initially feel overwhelmed but quickly adjust to the language and activities. For this discussion, describe your first impression of R and in your response, please also include the following: 

Explain what aspects of R you like the best, which aspects give you the most trouble. 

If you have used R before, what did you use it for? If you have not used it before, please explain how you would like to use it and what you would like to accomplish using this programming  language.   
"""
My first hands-on experience with R was in 2022 while taking a biostatistics course. At first, I was excited about the course in general but quickly felt lost on the first day and took a whole personal review time to catch the concepts when it came to the programming aspect. R, as a programming language, was completely new to me, though I had a fair idea of what programming was about.
Getting the syntax correct and understanding the logic was something I struggled with initially. variable naming conventions, the use of brackets vs parentheses, and the application of functions were all foreign to me. 
But I enjoyed it overall, and some of the areas I loved were creating various plots depending on the data types that were involved. Aside looking numerical values and deriving meaning off them, I found graphical representation of data more intuitive and easier to interpret or get the entire picture. 
-I later TA'd for the same biostatistics course in 2023, helping other students overcome some of the initial hurdles I had faced. 
It was at this time the course introduced Rstudio, which I found more user-friendly and efficient for to work in, compared to base R.
At this stage, my interest in R was mainly confined to biostatistics and general field or biological data. But I am looking forward to expanding my horizons through this course, dealing with genomic data and other bioinformatics related analyses.




Response Posts: 

When replying to classmates, consider the following: 

Evaluate if the use cases and/or potential uses overlap with your interests. 

Suggest ways that you could help further the classmate's understanding of their application of R 

Discuss ways that you could collaborate together to further each others understanding and support each other.   

 

Question 2: Previous Experience: To better understand the class participants and provide opportunity to learn from one another, please describe your (previous) involvement with statistical analysis of data. Please also include: 

What aspects of statistics you struggle with, and if there are any areas you excel at. 

How you think statistics can be applied to “real world” situations, or be used to solve problems that face humanity. 
"""
Havinf TA'd for the biostatistics course, as mentioned in the previous response, I have a fair experience with R and statistics. some of the areas I am good at includes;
- reading in data (csv, excel,txt files) and loading package data ( penguins dataset, iris dataset, mtcars dataset, etc).
-the ggplot2 package - creating various types of plots to visualize data depending on the context.
-computing various statistics, summary statistics, and performing hypothesis testing.
-deciding which statistical test is appropriate for a given scenario.
-reading statistical results and communicating statistical results clearly.
-probability distributions and reading various statistical tables.(Z, chi.sq, t and F)

Other areas I struggle with;
-more advanced statistical modeling and inference, such as regression analysis.
-Deeper level inferential statatistics
For real world application of statistics, I will say it has very broad applications. To narrow down, I have supported a friend with financial data related research to tax purposes. Other real-world applications include public health decision making, policy formulation, census data analysis etc.

"""
Response Posts: 

When replying to classmates, consider the following: 

Discuss ways that you could collaborate together to further each others’ understanding and support each other.   

Discuss if there are any overlaps in your strengths and weaknesses with statistics. 

#---------

Hello everyone,
This is my first year in the MS bioinformatics program. My name is Martin, I am based in NYC and I support a biostatistics course at a community college. I’ve had a beginner to intermediate interaction with R and I am hoping to deepen my understanding through this course, especially with regard to genomics data and other bioinformatics-related data. 
I look forward to interacting and learning from you all.


#------------------------


by Toni Buchanan - Friday, October 30, 2026, 8:06 PM
Question 1
My experience with R is limited to what I have learned in my first semester of the Bioinformatics master’s program. My first impression of R was that it was intimidating and learning how to use it was going to be a challenge, as I had no experience with programming languages. Initially, the RStudio interface was very confusing as I tried to navigate all the different panes and the different information they display. I struggled with knowing if my code had executed correctly and distinguishing between files and objects in the Environment pane. What I like most about R are the packages that are available for biological and statistical analysis and visualization. I think my biggest challenge with R is understanding when to use the different functions and what their associated arguments mean.
I have used R before to complete several assignments, which all used different types of biological data. I used R in my previous course for microbiome analysis, which involved the use of operational taxonomic unit data to examine alpha diversity and microbial abundance of the samples, and then generated heatmaps to compare these samples. This assignment helped me to understand how the differences in microbial communities can be investigated and useful, informative visualizations can be generated using R. I also used R previously to analyze results from BLAST by calculating the mean E-values, identifying the highest bit score, and looking at the correlations between alignment measurements. The assignments highlighted some of the different ways that R can be used in analysis, sequence comparison and genetic research, which are skills I think are relevant to my long-term goal of pursuing a career in genetic screening for variants associated with inherited disorders.

Question 2
My experience with statistical analysis comes from one class during my undergraduate studies in forensic science and the recent exposure described above in the first semester of this master’s program. The main aspects of statistics I struggle with are choosing the right statistical method to address the question I am investigating and determining if the results I have obtained are statistically significant. On the other hand, I feel comfortable with basic topics like mean, median, and mode, as well as organizing biological data, which I just think comes from my love of organization and general process optimization.
Statistics play an important role in daily healthcare, especially in genetic carrier screening. For example, statistical analysis is used in investigating the genetic variations among populations, estimating carrier frequencies, and evaluating the tests developed for carrier screening in terms of their specificity and sensitivity. These are all important for investigating and addressing important biological questions. They are also useful in identifying gaps that may be present in the current approaches being used in genetic screening and variant detection analysis. I hope to apply the skills I learn from this course in variant analysis and interpretation, and in evaluating genetic carrier screening results, to hopefully support and facilitate informed healthcare decisions.

#Resp:

Hello @Toni,
Thanks for sharing your experience and how your journey has been with R. It's inspiring and i can relate to your situation very much. Regarding packages / functions arguments, aside googling to learn more about the arguments, I often find it helpful use the "?function" to pull up the help documentation for the function in RStudio. A quick scroll down usually have some default example use cases that you can run directly to see how the arguments and function works. Or better still, copying that default code into a new script and then modifying the arguments to see how it affects the output. 
For choosing the right statistical test, I often find it helpful to think about the kind of data i'm working with first,(type of data, eg numerical, categorical );
then proceed to check whether it's numerical VS numerical, categorical VS categorical, or numerical VS categorical. 
most test are divided into 2 categories; parametric and non-parametric. 
parametric simply means your data must follow certain criteria (eg. normality) before you can use it. then when such criteria are not met, you simply fallback on the non-parametric alternative.

For statistical significance, you start by defining alpha (usually 5% or 0.05). This simply you want to "correct" 95% of the time and only 5% chance of making a mistake. then you compare your p-value to your alpha. if the p-value is less than alpha, you can conclude that you have a statistically significant p-value. But this is not a 100% assurance that you've found whatever variable you were investigating, it simply means, this is an unusual result and wouldn't occur by chance and thus worth investigating further.


#-----------------

by Charles-William Ruel - Thursday, October 29, 2026, 8:56 PM

My first impression of R is that it is a very powerful language that has strong computational capabilities. I have used this program in the past, particularly in my undergrad as a statistical analysis tool. R is a great resource for data visualization, and seems to have greater control compared to python. Although these pros are great, I have some issues with the language. The first being, it is much more difficult to troubleshoot code in this language compared to python. In the issue that I faced with the data download function this week, it was much more difficult to analyze where the code had issues. Additionally, the syntax of R is not as clean as python. All-in-all it seems like R will be a bit of a learning curve as we jump to more difficult concepts, but well worth it due to its strong capabilities.

I have some relatively elementary experience with statistical analysis. My experience involves comparing treatment and control groups using paired t-tests or Tukey-HSD tests, and additionally assessing variance prior to analysis using ANOVA. All of my statistical experience is from using the JMP program from a license at work. One of the issues I struggle with involves choosing the correct statistical test for the application I am using, additionally I do have some issues correctly interpreting results.

I think that statistics is very important for solving real world applications, as it is an extremely useful tool to determine if differences between two (or more) groups is a meaningful difference. This can be of great importance when considering if a treatment group has different results over a control group, or if the measured difference is attributed to noise. Of course when considering evaluating these differences one must consider the amount of data that must be collected to make a result meaningful.

Hello @Charles

I think most of use happen to have touched R during undergrad and that's really been helpful to some degree to it's mainly introductory level stuff. Regarding the data download function, I also had the same issues, it actually spent more time getting the data than analyzing it.
I've had to rad data directly, usually csv files into R, load data from packages, but loading via DBs seems to be a whole new challenge.
My major experience so far with Python has been through the master's program, but i can agree that it's more clean in syntax and somehow more intuitive than R.
We seem to have some overlaping experience with hypothesis testing, ANOVA and t-tests. I've use those in my previous works.
Regarding your ordeal with choosing the right statistical test, it's a common issue, one that most researchers face. I have had the chance of looking at diferent biological data and perform some tests on them. One thing I find helpful before a test is decided on is correctly identifying the type of data you're working with; numerical VS categorical; then whether it's numerical VS numerical, categorical VS categorical, or numerical VS categorical.
For most tests, a parametric approach is often used, that simply means that you assess your data to see if it meets certain criteria, eg. if it's normally distributed. if it meets the criteria, you simply proceed with the parametric test; if not, you fallback to it's non-parametric alternative. For applications, I can relate to how statistical helps filter noise from signals, when dealing with real world problems.

