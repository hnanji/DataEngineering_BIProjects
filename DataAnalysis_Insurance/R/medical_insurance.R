
#install.packages("gt")

library(tidyverse)
library(moderndive)
library(skimr)
library(officer)
library(flextable)
library(gtsummary)
library(broom)
library(janitor)


insurance <- read.csv("insurance.csv", stringsAsFactors = TRUE)

str(insurance)

glimpse(insurance)

# view a random sample of the data

insurance %>%
  sample_n(size = 5)

# compute summary statistics
insurance %>%
  summarize(mean_charge = mean(charges1),
            median_charges = median(charges1))

insurance %>% select(charges1) %>% skim()

summary(insurance$charges1)


# summarize the data with our package

insurance1 <- insurance %>% 
            rename(Age = age,
                   Gender = sex,
                   'Body Mass Index' = bmi,
                   'Smoking Status' = smoker,
                    Region = region,
                   'Insurance Charge' = charges1,
                   'Number of children' = children)


  
names(insurance)
# Create the summary table
table1 <- insurance1 %>% 
  tbl_summary(include = c(Age, Gender, 'Body Mass Index', Region, 'Insurance Charge', 'Number of children'))

# Convert the gtsummary table to a flextable object
table1_flextable <- as_flex_table(table1)

# Create a Word document and add the table
doc <- read_docx() %>%
  body_add_flextable(table1_flextable)

# Save the Word document
print(doc, target = "Figures/table1.docx")


# Visualise distribution of insurance claim

fig1 <- ggplot(insurance, aes(x = charges1)) + 
  geom_histogram() +
  labs(title = paste0("Distribution of medical expenses"),
       x = "Medical Expenses (GBP)", 
       y = "Frequency",
       caption = "") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank()) +
  theme_bw()+
  theme(axis.text.y =  element_text(size = 16),
        axis.title.y = element_text(size = 16),
        axis.text.x =  element_text(size = 16),
        axis.title.x = element_text(size = 16),
        title=element_text(size=20)) + 
   theme(legend.position="bottom")
ggsave("Figures/his.insurance.png",fig1,width = 11, height = 8)
fig1


# How does the insurance charge varie amongst gender

fig2 <- ggplot(insurance, aes(x = sex, y= charges1)) + 
  geom_boxplot()  +
  labs(title = paste0("Distribution of medical expenses by gender"),
       x = "Gender", 
       y = "Medical Expenses (GBP)",
       caption = "") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank()) +
  theme_bw()+
  theme(axis.text.y =  element_text(size = 16),
        axis.title.y = element_text(size = 16),
        axis.text.x =  element_text(size = 16),
        axis.title.x = element_text(size = 16),
        title=element_text(size=20)) + 
  theme(legend.position="bottom")
ggsave("Figures/gender.insurance.png",fig2,width = 11, height = 8)
fig2

# How does the insurance charge varie amongst region

fig3 <- ggplot(insurance, aes(x = region, y= charges1)) + 
  geom_boxplot()  +
  labs(title = paste0("Distribution of medical expenses by region"),
       x = "Region", 
       y = "IMedical Expenses (GBP)",
       caption = "") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank()) +
  theme_bw()+
  theme(axis.text.y =  element_text(size = 16),
        axis.title.y = element_text(size = 16),
        axis.text.x =  element_text(size = 16),
        axis.title.x = element_text(size = 16),
        title=element_text(size=20)) + 
  theme(legend.position="bottom")
ggsave("Figures/region.insurance.png",fig3,width = 11, height = 8)
fig3


# How does the insurance charge varie by smoking status

fig4 <- ggplot(insurance, aes(x = smoker, y= charges1)) + 
  geom_boxplot()  +
  labs(title = paste0("Distribution of medical expenses by smoking status"),
       x = "Smoking Status", 
       y = "Medical Expenses (GBP)",
       caption = "") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank()) +
  theme_bw()+
  theme(axis.text.y =  element_text(size = 16),
        axis.title.y = element_text(size = 16),
        axis.text.x =  element_text(size = 16),
        axis.title.x = element_text(size = 16),
        title=element_text(size=20)) + 
  theme(legend.position="bottom")
ggsave("Figures/smoker.insurance.png",fig4,width = 11, height = 8)
fig4

# How does the insurance charge varie by number of children
insurance$children <- as.factor(insurance$children)
fig5 <- ggplot(insurance, aes(x = children, y= charges1)) + 
  geom_boxplot()  +
  labs(title = paste0("Distribution of medical expenses by number of children"),
       x = "Number of Children", 
       y = "Medical Expenses (GBP)",
       caption = "") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank()) +
  theme_bw()+
  theme(axis.text.y =  element_text(size = 16),
        axis.title.y = element_text(size = 16),
        axis.text.x =  element_text(size = 16),
        axis.title.x = element_text(size = 16),
        title=element_text(size=20)) + 
  theme(legend.position="bottom")
ggsave("Figures/children.insurance.png",fig5,width = 11, height = 8)
fig5



# How does the insurance charge varie with BMI

fig6 <- ggplot(insurance, aes(x = bmi, y= charges1)) + 
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", color = "blue", se = FALSE) +
  labs(title = paste0("Variation of medical expenses and body mass index"),
       x = "Body mass index", 
       y = "Medical Expenses (GBP)",
       caption = "") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank()) +
  theme_bw()+
  theme(axis.text.y =  element_text(size = 16),
        axis.title.y = element_text(size = 16),
        axis.text.x =  element_text(size = 16),
        axis.title.x = element_text(size = 16),
        title=element_text(size=20)) + 
  theme(legend.position="bottom")
ggsave("Figures/bmi.insurance.png",fig6,width = 11, height = 8)
fig6




# How does the insurance charge varie with age

fig7 <- ggplot(insurance, aes(x = age, y= charges1)) + 
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", color = "blue", se = FALSE) +
  labs(title = paste0("Variation of medical expenses with age"),
       x = "Age", 
       y = "Medical Expenses (GBP)",
       caption = "") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank()) +
  theme_bw()+
  theme(axis.text.y =  element_text(size = 16),
        axis.title.y = element_text(size = 16),
        axis.text.x =  element_text(size = 16),
        axis.title.x = element_text(size = 16),
        title=element_text(size=20)) + 
  theme(legend.position="bottom")
ggsave("Figures/age.insurance.png",fig7,width = 11, height = 8)
fig7


# correlation between predictors

pairs(insurance[c("age", "bmi", "children", "charges")])

install.packages("psych")

library(psych)
pairs.panels(insurance[c("age", "bmi", "children", "charges")])

ggplot(insurance, aes(x = age, y= children)) + 
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", color = "blue", se = FALSE)

# The relationship between age and charges displays several 
# relatively straight lines, while bmi and charges has two
# distinct groups of points.




# Data analysis

# correlation

insurance %>% 
  get_correlation(formula = charges1 ~ age)

# Fit regression model:

# One numerical explanatory variable
score_model <- lm(charges1 ~ age, data = insurance)
# Get regression table:
get_regression_table(score_model)

score_model1 <- lm(charges1 ~ bmi, data = insurance)
# Get regression table:
get_regression_table(score_model1)


# get residuals

regression_points <- get_regression_points(score_model)
regression_points


# One categorical explanatory variable
insurance$children  <- as.factor(insurance$children)
insurance %>%
  select(sex,smoker,region, children) %>%
  skim()

# sex

ggplot(insurance, aes(x = sex, y = charges1)) +
  geom_boxplot() 

chargesbysex <- insurance %>%
  group_by(sex) %>%
  summarize(median = median(charges1), 
            mean = mean(charges1))

sexExp_model <- lm(charges ~ sex, data = insurance)
get_regression_table(sexExp_model)


chargesbysmoker <- insurance %>%
  group_by(smoker) %>%
  summarize(median = median(charges1), 
            mean = mean(charges1))

smokerExp_model <- lm(charges ~ smoker, data = insurance)
get_regression_table(smokerExp_model)


chargesbyregion <- insurance %>%
  group_by(region) %>%
  summarize(median = median(charges1), 
            mean = mean(charges1))

regionExp_model <- lm(charges ~ region, data = insurance)
get_regression_table(regionExp_model)

chargesbychildren <- insurance %>%
  group_by(children) %>%
  summarize(median = median(charges1), 
            mean = mean(charges1))

childExp_model <- lm(charges ~ children, data = insurance)
get_regression_table(childExp_model)

# first model with all variables

# ensuring childreen is continuous_scale(
insurance$children1 <- as.integer(insurance$children)

ins_model <- lm(charges1 ~ age + children1 + bmi + sex +
                  smoker + region, data = insurance)

ins_model

# Capture the summary output
model_summary <- capture.output(summary(ins_model))

summary(ins_model)

# Since a residual is equal to the true value minus the predicted value, the maximum error of 23994.2 


# Write the summary to a text file
writeLines(model_summary, "Figures/model_summary_first.txt")


# improving model performance

# the effect of age on medical expenditures may not be constant throughout all age values; the treatment may become disproportionately expensive
# for the oldest populations.

insurance$age2 <- insurance$age^2

insurance <- insurance%>%
  mutate(bmi30 = case_when( 
    bmi  <= 30  ~ 0,
    bmi >30~ 1))

# – adding interaction effects
# When two features have a combined effect, this is known as an interaction.

# We can then include the bmi30 variable in our improved model, either replacing the original bmi variable or in addition

#Interactions should never be included in a model without also adding each of the interacting variables

# an improved regression model
# this time, treating children as a factor

ins_model2 <- lm(charges ~ age + age2 + children1 + bmi + sex +
                   bmi30*smoker + region, data = insurance)

summary(ins_model2)

# Capture the summary output
model_summary2 <- capture.output(summary(ins_model2))

writeLines(model_summary2, "Figures/model_summary_improved.txt")


