
# Text Book: Hands-On Data Science for Marketing Yoon Hyup Hwang

library(readr)
library(dplyr)
library(ggplot2)

df <- read_csv("WA_Fn-UseC_-Marketing-Customer-Value-Analysis.csv")

# Encode engaged customers as 0s and 1s

table(df$Response, useNA = "ifany")
str(df)
#df$Engaged <- as.integer(df$Response)
df$Engaged <- ifelse(df$Response == "Yes", 1,
                     ifelse(df$Response == "No", 0, NA))

table(df$Engaged, useNA = "ifany")


## - Overall Engagement Rates ##
engagementRate <- df %>% group_by(Response) %>%
  summarise(Count=n()) %>%
  mutate(EngagementRate=Count/nrow(df)*100.0)

ggplot(engagementRate, aes(x=Response, y=EngagementRate)) +
  geom_bar(width=0.5, stat="identity") +
  ggtitle('Engagement Rate') +
  xlab("Engaged") +
  ylab("Percentage (%)") +
  theme(plot.title = element_text(hjust = 0.5)) 


# As you can see from these results, the majority of the customers did not respond to the marketing calls.
# only about 14% of the customers responded to the marketing calls. 
# We are going to now dive deeper into the customers who responded and get a better understanding of what worked best for them.

##=================================================================
# Engagement rates by offer type
#==================================================================

# - Engagement Rates by Offer Type ##
df$`Renew Offer Type` <- as.factor(df$`Renew Offer Type`)
df <- df %>%mutate(RenewOfferType = `Renew Offer Type`)

engagementRateByOfferType <- df %>% 
  group_by(`RenewOfferType`) %>%
  summarise(Count=n(), NumEngaged=sum(Engaged)) %>%
  mutate(EngagementRate=NumEngaged/Count*100.0)

#engagementRateByOfferType$RenewOfferType <- as.character(engagementRateByOfferType$RenewOfferType)

ggplot(engagementRateByOfferType, aes(x=RenewOfferType, y=EngagementRate)) +
  geom_bar(width=0.5, stat="identity") +
  ggtitle('Engagement Rates by Offer Type') +
  xlab("Offer Type") +
  ylab("Engagement Rate (%)") +
  theme(plot.title = element_text(hjust = 0.5)) 

# Offer Type 2 worked best and had the highest response rate from customers

# As you can easily notice from this plot, Offer 2 had the highest engagement rate among the customers
#When conducting customer analytics, as discussed earlier, we often want 
# to know the demographics and attributes of customers for each event, 
#so that we can understand what works best for which type of customers. 
#This can lead to further improvements in the next marketing campaign by better targeting those subgroups of customers

#============================================================================

# Engagement rates by offer type and vehicle class
# is there any noticeable difference in the response rates for each offer type 
# for customers with different vehicle classes

## - Offer Type & Vehicle Class ##
engagementRateByOfferTypeVehicleClass <- df %>% 
  group_by(RenewOfferType, `Vehicle Class`) %>%
  summarise(NumEngaged=sum(Engaged)) %>%
  left_join(engagementRateByOfferType[,c("RenewOfferType", "Count")], by="RenewOfferType") %>%
  mutate(EngagementRate=NumEngaged/Count*100.0)

engagementRateByOfferTypeVehicleClass <- engagementRateByOfferTypeVehicleClass %>%mutate(VehicleClass = `Vehicle Class`)

ggplot(engagementRateByOfferTypeVehicleClass, aes(x=RenewOfferType, y=EngagementRate, fill=VehicleClass)) +
  geom_bar(width=0.5, stat="identity", position = "dodge") +
  ggtitle('Engagement Rates by Offer Type & Vehicle Class') +
  xlab("Offer Type") +
  ylab("Engagement Rate (%)") +
  theme(plot.title = element_text(hjust = 0.5))

# the graph shows how how customers with different vehicle classes engage differently with other types of renewal offers
# customers with Four-Door Car respond the most frequently for all offer types
# customers with SUV respond with a higher chance to Offer1 than to Offer2.
# If we see any significant difference in the response rates among different customer segments, we can fine-tune who to target 
#for different sets of offers.

# if we believe customers with SUV respond to Offer1 with a significantly 
#higher chance than to Offer2, then we can target SUV customers with
#Offer1. On the other hand, if we believe customers with Two-Door Car#
#respond to Offer2 with a significantly higher chance than to other 
#offer types, then we can target Two-Door Car owners with Offer2.

# Engagement rates by sales channel

## - Engagement Rates by Sales Channel ##
engagementRateBySalesChannel <- df %>% 
  group_by(`Sales Channel`) %>%
  summarise(Count=n(), NumEngaged=sum(Engaged)) %>%
  mutate(EngagementRate=NumEngaged/Count*100.0)

engagementRateBySalesChannel  <- engagementRateBySalesChannel %>% rename(Sales.Channel=`Sales Channel`)

ggplot(engagementRateBySalesChannel, aes(x=Sales.Channel, y=EngagementRate)) +
  geom_bar(width=0.5, stat="identity") +
  ggtitle('Engagement Rates by Sales Channel') +
  xlab("Sales Channel") +
  ylab("Engagement Rate (%)") +
  theme(plot.title = element_text(hjust = 0.5)) 


# Agent works best in terms of getting responses from the customers. 
# Then, sales through Web works the second best. 
#As before, let's break down this result deeper and analyze it to see 
# whether the behavior changes among customers with different characteristics.



# - Sales Channel & Vehicle Size ##
engagementRateBySalesChannelVehicleSize <- df %>% 
  group_by(`Sales Channel`, `Vehicle Size`) %>%
  summarise(NumEngaged=sum(Engaged)) %>% rename(Sales.Channel = `Sales Channel`) %>% 
  left_join(engagementRateBySalesChannel[,c("Sales.Channel", "Count")], by="Sales.Channel") %>%
  mutate(EngagementRate=NumEngaged/Count*100.0)

engagementRateBySalesChannelVehicleSize  <- engagementRateBySalesChannelVehicleSize %>% rename(Vehicle.Size=`Vehicle Size`)


ggplot(engagementRateBySalesChannelVehicleSize, aes(x=Sales.Channel, y=EngagementRate, fill=Vehicle.Size)) +
  geom_bar(width=0.5, stat="identity", position = "dodge") +
  ggtitle('Engagement Rates by Sales Channel & Vehicle Size') +
  xlab("Sales Channel") +
  ylab("Engagement Rate (%)") +
  theme(plot.title = element_text(hjust = 0.5)) 

# customers with Medsize vehicles respond best to all sales channels.
# Small vehicle owners respond better through Agent and Call Center channels, while on the other hand, Large vehicle owners 
#respond better through the Branch and Web channels

# we can utilize this insight in the next marketing efforts.
# For example, as Small car owners respond with a higher degree of 
# engagement through Agent and Call Center, we can utilize those two#
# channels more heavily for Small car owners.



# Segmenting customer base

# n this section, we will be segmenting our customer
# base by Customer.Lifetime.Value and Months.Since.Policy.Inception

summary(df$`Customer Lifetime Value`)

clv_encode_fn <- function(x) {if(x > median(df$`Customer Lifetime Value`)) "High" else "Low"}
df$CLV.Segment <- sapply(df$`Customer Lifetime Value`, clv_encode_fn)


summary(df$`Months Since Policy Inception`)

policy_age_encode_fn <- function(x) {if(x > median(df$`Months Since Policy Inception`)) "High" else "Low"}

df$Policy.Age.Segment <- sapply(df$`Months Since Policy Inception`, policy_age_encode_fn)


ggplot(
  df[which(df$CLV.Segment=="High" & df$Policy.Age.Segment=="High"),], 
  aes(x=`Months Since Policy Inception`, y=log(`Customer Lifetime Value`))
) +
  geom_point(color='red') +
  geom_point(
    data=df[which(df$CLV.Segment=="High" & df$Policy.Age.Segment=="Low"),], 
    color='orange'
  ) +
  geom_point(
    data=df[which(df$CLV.Segment=="Low" & df$Policy.Age.Segment=="Low"),], 
    color='green'
  ) +
  geom_point(
    data=df[which(df$CLV.Segment=="Low" & df$Policy.Age.Segment=="High"),], 
    color='blue'
  ) +
  ggtitle('Segments by CLV and Policy Age') +
  xlab("Months Since Policy Inception") +
  ylab("CLV (in log scale)") +
  theme(plot.title = element_text(hjust = 0.5)) 


# Now that we have created these four segments, 
# let's see whether there is any noticeable difference
# in engagement rates among these four segments.#
# Take a look at the following code:

engagementRateBySegment <- df %>% 
  group_by(CLV.Segment, Policy.Age.Segment) %>%
  summarise(Count=n(), NumEngaged=sum(Engaged)) %>%
  mutate(EngagementRate=NumEngaged/Count*100.0)


# It will be easier to understand the differences in a chart.
#You can use the following code to create a bar plot for this data:

ggplot(engagementRateBySegment, aes(x=CLV.Segment, y=EngagementRate, fill=Policy.Age.Segment)) +
  geom_bar(width=0.5, stat="identity", position = "dodge") +
  ggtitle('Engagement Rates by Customer Segments') +
  ylab("Engagement Rate (%)") +
  theme(plot.title = element_text(hjust = 0.5))



# K Mean clustering 
library(readxl)


df1 <- read_excel("Online Retail.xlsx")


# data cleaning

# Dropping canceled orders: We are going to drop records with 
# negative Quantity, using the following code:

df1 <- df1[which(df1$Quantity > 0),]

# Dropping records with no CustomerID

df1 <- na.omit(df1)

# Excluding an incomplete month

df1 <- df1[which(df1$InvoiceDate < '2011-12-01'),]

# Computing total sales from the Quantity and UnitPrice columns


df1$Sales <- df1$Quantity * df1$UnitPrice

# Per-customer data
# In order to analyze customer segments,
#we need to transform our data, so that each #
#record represents the purchase history of individual 
#customers. Take a look at the following code

# per customer data

f <- df1 %>%  filter(CustomerID == "12348")

# As you can see from this code, we are grouping the 
#DataFrame, df, by CustomerID and computing the total 
#sales and the number of orders for each customer. 
#Then, we also calculate the average per-order value, AvgOrderValue, 
#by dividing the TotalSales column by the OrderCount column. 
#The result is shown in the following screenshot:

customerDF <- df1 %>% 
  group_by(CustomerID) %>% 
  summarize(TotalSales=sum(Sales),      
            OrderCount=length(unique(InvoiceDate))) %>%
  mutate(AvgOrderValue=TotalSales/OrderCount)


# ranking and scaling

rankDF <- customerDF %>%
  mutate(TotalSales=rank(TotalSales), 
         OrderCount=rank(OrderCount, ties.method="first"),
         AvgOrderValue=rank(AvgOrderValue))

normalizedDF <- rankDF %>%
  mutate(TotalSales=scale(TotalSales),
         OrderCount=scale(OrderCount), 
         AvgOrderValue=scale(AvgOrderValue))

cluster <- kmeans(normalizedDF[c("TotalSales", "OrderCount", "AvgOrderValue")], 4)

cluster$cluster
cluster$centers

# store cluster labels in normalised data set
normalizedDF$Cluster <- cluster$cluster

ggplot(normalizedDF, aes(x=AvgOrderValue, y=OrderCount, color=Cluster)) +
  geom_point()

# Selecting the best number of clusters

# Selecting the best number of cluster
library(cluster)

for(n_cluster in 4:8){
  cluster <- kmeans(normalizedDF[c("TotalSales", "OrderCount", "AvgOrderValue")], n_cluster)
  
  silhouetteScore <- mean(
    silhouette(
      cluster$cluster, 
      dist(normalizedDF[c("TotalSales", "OrderCount", "AvgOrderValue")], method = "euclidean")
    )[,3]
  )
  print(sprintf('Silhouette Score for %i Clusters: %0.4f', n_cluster, silhouetteScore))
}

# In our case, of the five different numbers of clusters we have experimented with, the best number of 
#clusters with the highest silhouette score was 4.

# Interpreting customer segments

# so now lets fit  k = 4

# Interpreting customer segments
cluster <- kmeans(normalizedDF[c("TotalSales", "OrderCount", "AvgOrderValue")], 4)
normalizedDF$Cluster <- cluster$cluster


# cluster centers
cluster$centers

# e can also find out what the best-selling items are for each customer segment. Take a look at the following code:

# High value cluster
# High value cluster summary

# he fourth cluster was the group of high-value customers and we are going to 
#take a look at the best-selling items for this group. 
summary(customerDF[which(normalizedDF$Cluster == 4),])

highValueCustomers <- unlist(
  customerDF[which(normalizedDF$Cluster == 4),'CustomerID'][,1], use.names = FALSE
)

df1[which(df1$CustomerID %in% highValueCustomers),] %>%
  group_by(Description) %>%
  summarise(Count=n()) %>%
  arrange(desc(Count))
