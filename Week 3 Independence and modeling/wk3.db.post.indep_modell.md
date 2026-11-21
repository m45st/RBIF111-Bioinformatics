Week 3 Discussion Questions
Wednesday, July 1, 2026, 2:28 PM
Number of replies: 5
Responses and replies to Week 3 Discussion Questions should be posted to this forum.

Please reply to my starter threads below the questions.

After you post your reply, you will be able to view the responses of other students.

This forum is reserved for Discussion Questions (graded activity). Please post all the questions and comments pertinent to this week's material, homework, etc in the Week 3 Class Discussions forum

Question 1: Null and Alternative Hypotheses in the Notes' Own Example: Week 3 Part 1 develops linear regression around a running example: modeling days-to-remission against a patient's gene expression level. Without fitting anything yourself, use that specific example to:

•       State, in your own words, the null and alternative hypotheses the Notes' example is actually testing.

•       Explain what rejecting the null hypothesis would tell us about that specific gene, and, just as importantly, what it would not tell us, for example about whether the gene causes faster remission.

Response Posts: Check a classmate's stated hypotheses against the actual example in the Notes.

•       Confirm they described the null and alternative in terms of the regression coefficient, not just in terms of the gene being 'related' or 'not related' to the outcome.

•       Point out one thing their answer implied that a rejected null does not actually establish.

Question 2: Why a Non-Parametric Test Can Beat a More Powerful One: Week 3 Part 3 compares parametric and non-parametric tests under both normally distributed and skewed data, and closes with a summary of when each is preferable. A common rule of thumb is to use a non-parametric test whenever you are not fully sure your data is normal. Using the Notes' own comparison of test power under normal and skewed data, explain why that rule of thumb is not quite right, and state a more precise version of it in your own words.

Response Posts: Test a classmate's rule against the Notes' actual comparison.

•       Ask whether their more precise version would still hold if the data were only mildly skewed rather than heavily skewed.

•       Point out anything in their explanation that the Notes' summary would actually contradict.

#

1. Null and Alternative hypothesis.

In this secttion of the notes, the example used to introduce the basic linear model is from the ALL dataset, attempting to model the relationship between gene expression level(34852_g_at) and days-to-remission.
The X-axis is gene expression (predictor) and Y-axis is days-to-remission (outcome).
Based on this setup, which follows the linear model 𝛾1=𝛽𝑜+𝛽1𝑥1+𝜀1, the null and alternative hypotheses about the relationship between gene expression level and days-to-remission are:
Ho: 𝛽1=0
HA: 𝛽1≠0
from the linear model 𝛾1=𝛽𝑜+𝛽1𝑥1+𝜀1,  if 𝛽1=0, then 𝛾1=𝛽𝑜+𝛽1𝑥1+𝜀1, which will imply that the gene expression level has no effect on the days-to-remission. 
The regression plot shows a negative trend between gene expression(x) and days-to-remission(y).
Since gene expression(x) is on the x-axis, it is the predictor variable. 

Rejecting Ho: 𝛽1≠0 will imply that we have statisitical evidence for a non-zero linear relationship between gene expression level and days-to-remission.
What it would not establish is that the gene expression level is the sole cause of the faster or slower remission. 
There could be other variables( 𝜀1) that are related to both the gene expression level and days-to-remission, which are not accounted for in the model.

2. Why a Non-Parametric Test Can Beat a More Powerful One
The similuation shows that under the nomal data, the t-test (power ≈ 0.672) is slightly more powerful than Wilcoxon (0.666), but under skewed data, both tests lose power test drops to 0.395 and Wilcoxon to 0.317. So the rule “non-parametric tests are more powerful when assumptions are violated” is not entirely accurate here because both tests are weak under skew in this small sample (n=20) setup. Taking sample size, skew, extra assessment need to be made before going with non-parametric or parametric test. In the case of the genomic data, what i have noticed so far is the fact that the sample sizes are often very large, so statistical test for normality (shapiro test) almost always comes back normal, but visual assesment of the data like QQ plot can reveal some issues, though the central limit theory significantly reduce the issues for t-test, it's important to assess in instance of the smaller sample size with outliers. 

#--


The rule of thumb, "use a non-parametric test whenever you are not fully sure your data is normal" is not entirely accurate as it overstates the cost of being wrong about the normality assumption and understates the benefits.

#------------- nov 16, 2026 . REsponses

by Heidy Lopez Lopez - Saturday, November 14, 2026, 7:59 PM
Question 1:
Something that helped me understand this example is noticing how the data were collected. Gene expression (probe 34852_g_at) was measured only once per patient, at diagnosis. It was not followed over time during treatment. Each patient contributes one point: their expression level and the number of days it took them to reach complete remission (D2R). So the question is do: patients who start with higher expression tend to reach remission faster or slower than patients with lower expression?

According to the Notes, the model fitted to the data is D2R = β₀ + β₁·G + ε, and the hypotheses should be stated in terms of the slope (β₁):
H0_real.png
H₀: β₁ = 0. If this were true, the G term would disappear from the equation, leaving D2R = β₀ + ε. A patient’s gene expression would add nothing to our expectation of how long they’ll take to reach remission. Any differences would just be noise.
H1_real.png
 
H₁: β₁ ≠ 0. The gene stays in the equation: changing G shifts the expected D2R.

The estimated slope was −21.9 with p = 2.96 × 10⁻⁷, so H₀ is rejected. Higher expression at diagnosis was associated with a faster remission in these 96 patients.

What this tells us: the gene works as a clue. Measuring it at diagnosis gives us information about how a patient is likely to respond, which is why the Notes mention it as a potential biomarker. For that purpose, it doesn’t matter whether the gene is the cause.
What it doesn’t tell us: whether the gene is the reason remission is faster. A clue and a cause produce the same tilted line. For example, a particular leukemia subtype could both raise this gene’s expression and respond better to chemotherapy. The data alone can’t separate these explanations, because nobody changed the gene: we only observed it. To test causation, we would need to intervene, for instance by silencing or knocking down the gene in a model system and checking whether remission slows down. Rejecting H₀ also doesn’t mean the clue is precise. The funnel in the residuals-vs-fitted plot shows the line works reasonably well for fast responders but misses badly for slow ones, and the gene accounts for only about a quarter of the variation in D2R.

by Heidy Lopez Lopez - Saturday, November 14, 2026, 8:27 PM
Question 2

Well, first I had to understand what each test is really looking at. The t-test uses the actual values we measured and compares the means. Wilcoxon doesn’t use the values; it puts all the data in order and only looks at the positions, like in a race where you only care who came 1st, 2nd, 3rd, and not by how much they won. So with Wilcoxon you lose information. If the data are normal and I don’t need to lose that information, I’d rather keep it. That’s why the t-test should be more powerful when the data are bell-shaped.

Before looking at the results of the Notes’ simulation (two groups of 20, with a real difference, repeated 1,000 times), I made my own prediction. I thought that with normal data both tests would be more or less tied, and that with skewed data the t-test wouldn’t be reliable anymore, so Wilcoxon would win, and probably by a lot.

With normal data I was right. The t-test had a power of 0.672 and Wilcoxon 0.666, so the difference is only 0.006, practically nothing. But with skewed data, the test with the higher number was actually the t-test: 0.395 vs. 0.317 for Wilcoxon. And this surprised me, because the text of the Notes says that with skewed data Wilcoxon becomes “substantially more powerful,” but their own table shows the opposite.

So why did the t-test still win? I think it’s because of the sample size. The data don’t become normal when you have more of them; skewed data stay skewed. But the t-test works with the mean, and by the Central Limit Theorem the mean starts behaving like a normal distribution, even if the data don’t. With 20 per group and no really extreme values, the means were stable enough. Where Wilcoxon really helps is when there are strong outliers or heavy tails, because a few huge values can pull the mean a lot, but they don’t change the positions much.

That’s why, for me, the rule of thumb isn’t quite right. “Not being sure” isn’t a good enough reason to switch, because sometimes there are no outliers or heavy tails, and then I’m just throwing away information for nothing. What I would do is try the parametric test first, because it keeps the original measurements. Then I would check the diagnostics, like Shapiro-Wilk, the QQ plot and the residuals. If there’s a clear violation of normality, especially outliers or heavy tails, and the sample isn’t big enough for the Central Limit Theorem to help, then I would go to the non-parametric test. And if both tests give similar results, that tells me the normality assumption wasn’t that important for the conclusion.


Hello @Heidy,
I thought you made a very comprehensive and insightful analysis, starting with the nature of the data, how it was collected, and the hypothesis that needed to be tested based on variables of interest. The plots you provided, visually demonstrating the H0: with respect to 0 slope (β₁), was very informative.

Your structure of the H0 and H1: following the linear model(D2R = β₀ + β₁·G + ε) directly captures the essence of the test.
The test result p-value for the slope(β₁) was 2.96*10^-7, which is much smaller than the significance level of 0.05, indicating a statistically significant  association between the gene expression and the time to complete remission.
How much does the regression coefficient -21.9 tells us about the practical significance of the association? does it mean that the time to complete remission decrease 21.9 days for each unit increase in gene expression? 

For part 2, the which focused on parametric vs non-parametric tests, and as you mentioned, it is very important to know when to use which test and would rather begin with a parametric test and then check the diagnostics, like shapiro-wilk, QQ plot and residuals, have you encountered a situation where both tests give different conclusions?
Following your line of thought, I assume that a mildly skewed data would always hold for a parametric test, and a non-parametric option wouldn't be required, is that correct?  
Using the case of racing where 1st , 2nd , 3rd places are of primary importance; to illustrate how non-parametric test works in terms of 'ranks' was a great representation. 

-Martin


#############################################################################
by Charles-William Ruel - Sunday, November 15, 2026, 3:24 PM
Question 2:
The general rule of thumb “use a non-parametric test whenever you are not fully sure your data is normal”. As we can see in the example from the notes, when we perform either a t-test or the Mann-Whitney U test on normally distributed data (sample size of 20) we observe a power of 0.672 and 0.666 respectively (effect value 0.8). This demonstrates that power is irrespective to which test is performed on normal data.

However, in the example of the skewed data we can observe that there is stronger power for the parametric t-test compared to the Mann-Whitney U test (0.395 vs 0.317). I’m not exactly sure what to make of this result, as the notes mention the power should be reversed and that is not what we observe.

A more precise version of the rule of thumb would be to first confirm if data distribution is normal or not before applying a statistical test. This allows for correctly applying the statistical test to the observed data.

Hello @Charles,
Thanks for sharing your thoughts on this topic. you mentioned that due to the minimal difference in power between the two options ( parametric vs non parametric) 0.672 and  0.666 in the case of normal data, power will be irrespective of the test type, is it correct to assume that it is only the case when the sample size is small? 
I do agree with your idea on what a more precise version will look like; performing diagnostics and checking for normality visually and through statistical tests before selecting an appropriate statistical test is indeed a more robust approach. But i've seen instances where test like shapiro-wilk or QQ plot use the residuals to check for normality  instead of the original data, which in this case, will require one to have fitted the linear model first and check the residuals. 
In that regard, I wonder whether one should commence with the parametric test, from which the residuals can then be extracted and used to examine the normality assumption of the model. But i believe commencing with the parametric test is often a better approach and then adjusting accordingly based on the results especially if sample size is large enough, as the central limit theory will favor the results. 

-Martin







