<<<<<<< HEAD

=======
>>>>>>> 138ed7adda32d59ab22186ec22d8a70e3569941e
---
title: "Agglomerated Commuter Rail Survey Responses"
author: "Greg Macfarlane, Parsons Brinckerhoff"
output:  
  html_document:
    toc: true
    number_sections: true
    theme: cerulean
    highlight: tango
---
<<<<<<< HEAD
=======

>>>>>>> 138ed7adda32d59ab22186ec22d8a70e3569941e
```{r setup, echo=FALSE, cache=FALSE, tidy=TRUE, message=FALSE }
library(knitr)
opts_chunk$set(echo=TRUE, cache=FALSE, tidy=FALSE, fig.path = "figures/")
dep_auto()
knit_hooks$set(inline = function(x) {
    if(is.numeric(x)){prettyNum(round(x,3), big.mark=",", drop0trailing=FALSE)}
    else{paste(as.character(x))}
  })
## a common hook for decrease spacing in code lines
hook_spacing = function(x, options) {
    paste("\\begin{spacing}{0.8}\n", x, 
        "\\end{spacing}\n", sep="")
}

# define other libraries here
library(dplyr)
library(ggplot2)
library(scales)
library(tidyr)
library(questionr)
```


# Introduction
This document presents a consolidated analysis of several surveys that included
commuter rail system riders in the United States. The systems surveyed in this
analysis are:
  
  - Austin, Texas (MetroRail)
  - Dallas, Texas (TRE)
  - Miami, Florida (Tri Rail)
  - Minneapolis, Minnesota
  - Nashville, Tennesee 
  - Salt Lake City, Utah (FrontRunner)
  - San Diego, California (Coaster)
  - Washington, D.C. (MARC)
<<<<<<< HEAD
=======
  

## Data Construction

Each of these systems conducted an independent survey of its commuter rail
passengers. For the most part, these were on-board surveys of only CRT passengers,
but some surveys included other transit riders as well. Additionally, each
survey used somewhat different variables, and different bins for other variables
such as income and age. Further, the surveys categorized elements such as 
race, employment status, and fare category differently.

The attached `DataMaker` document contains detailed code on how I processed each
set of  survey responses and consolidated them into a single dataset, which I
have stored as both an `Rdata` binary object and a `.csv` delimted text file.

```{r loadData}
load("./Data/CommuterRail_Combined.Rdata")
```

### Continuous Variable Fragmentation

As mentioned above, each survey used its own method of binning incomes; the 
survey respondents selected a range in which their income lay, and this range 
differed across surveys. In `DataMaker` I coded these categories as numerical 
values defined by the midpoint of the range. Some of the figures in this document
will look more natural if I fragment these variables, randomly incorporating the
measurement error inherent with such a data collection method. So to each income
and age field I add a uniformly distributed random number of plus or minus 
`r 15` percent of the given income or age.

  > Note: some cities actually did ask for the age of the respondent explicity;
  > in these cases I did not add the random number to the age.

```{r randomFragmentation, warning=FALSE}
incerror <- 0.15

CRTsurveys <- CRTsurveys %>%
  mutate(income = runif(n = n(), min = (1 - incerror) * income, 
                         max = (1 + incerror) * income),
         rage = runif(n = n(), min = (1 - incerror) * age,
                         max = (1 + incerror) * age),
         # Austin, San Diego ask age explicitly
         age = ifelse(city %in% c("Austin", "San Diego"), age, rage)) %>%
  select(-rage)
```

## Total system ridership and weights

Each survey came with its own linked-trip expansion weights, which I have placed
in the `weight` variable. The sum of these weights gives the total system
ridership.

```{r totalRidership, results='asis'}
kable(CRTsurveys %>% group_by(city) %>% 
        summarise(ridership = sum(weight)), digits = 0)
```

For density plots where we show the relative share by system, we need a set of 
weights where the city sums to one, or Washington will dominate smaller systems
like Austin and Nashville.

```{r cityWeights}
CRTsurveys <- CRTsurveys %>% group_by(city) %>%
  mutate(cityweight = weight / sum(weight))
```




# Commuter Rail Rider Profile

## Income

On the whole, the survey respondents are middle- to upper-income, with the
national mode of the distribution being in the range of 50k$ per year.
We should not read too much into this graphic, however, because it may be that
regions with higher average incomes may have had higher response to the survey.

```{r income, warning=FALSE, fig.keep='last', warning=FALSE}
ggplot(CRTsurveys, aes(x = income/1000, weight = weight)) + 
  geom_density(fill = "black", alpha = 0.4) + xlab("Income of Rider [k$]") +
  ylab("Weighted Density")
```

A more informative graphic splits the density up by system. In Austin, the 
income of riders skews heavily downwards, perhaps because of the good access
the system has to the University of Texas. Nashville is relatively unskewed,
and Minneapolis and San Diego are very bimodal, missing middle incomes while 
serving the pooor and the wealthy.

In most cases, there is a hump on the right side of the distribution because
the survey categories censored too many high incomes. Washington D.C. has a very
high relative income for its commuter rail passengers, but this may be a function
of high average incomes in the general population, as well as the coverage of
the overall transit network.

```{r incbycity, fig.keep = 'last', fig.height=10, warning=FALSE}
ggplot(CRTsurveys, aes(x = income/1000, fill = city, weight = weight)) +
  geom_density(alpha = 0.9) + xlab("Income of Rider [k$]")+
  facet_grid(city ~ .) + theme(legend.position = "none") +
  ylab("Weighted: sum = 1")
```

The above figure uses the given weights, so the integral of the density curve 
sums to the system ridership. The figure below scales the weights so that the
integral sums to one. This may be better for comparison across systems.

```{r incbycityweight, fig.keep = 'last', fig.height=10, warning=FALSE}
ggplot(CRTsurveys, aes(x = income/1000, fill = city, weight = cityweight)) +
  geom_density(alpha = 0.9) + xlab("Income of Rider [k$]")+
  facet_grid(city ~.) + theme(legend.position = "none") +
  ylab("Weighted: sum = 1")
```

### Income by Group

The table and chart below show basically the same information, but this time by
percent in income groups rather than density.

```{r grouped_income}
income_groups <- CRTsurveys %>%
  mutate(
    income_group = cut(income, 
                       breaks = c(0, 25, 50, 84, Inf) * 1000,
                       labels = c("<25k", "25-50k", "50-84k", ">84k"))
  ) %>%
  filter(!is.na(income_group)) %>%
  group_by(income_group, city) %>%
  summarise(n = sum(weight)) %>%
  group_by(city) %>%
  mutate(n = n / sum(n) * 100)

income_groups %>%
  spread(income_group, n) %>%
  kable(caption = "Share of riders by income.")
```

```{r grouped_income_bars}
ggplot(income_groups, aes(x = income_group, y = n, fill = city)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  xlab("Income Group (US$)") + ylab("Percent of Riders")
```


## Age
On the whole, commuter rail riders tend to represent working ages well, with 
perhaps more young riders in some cities. The mode of the distribution appears
to be somewhere around 40 years old. 
The distribution also drops off quickly around retirement age.

```{r age, warning=FALSE, fig.keep='last'}
ggplot(CRTsurveys, aes(x = age, weight = weight)) + 
  geom_density(fill = "black", alpha = 0.4) +
  xlab("Age of Rider")
```

The complete distribution in the age of commuter rail riders, as shown in the
figure below, differs greatly between cities. In Austin, the ridership is 
heavily skewed towards younger
people, perhaps because the rail system serves the University of Texas campus.
The systems in Nashville and Salt Lake skew older.

```{r agebycityweights, fig.keep = 'last', fig.height=10, warning=FALSE}
ggplot(CRTsurveys, aes(x = age, fill = city, weight = cityweight)) +
  geom_density(alpha = 0.9) + xlab("Age of Rider")+
  facet_grid(city ~ .) + ylab("Weighted: sum = 1")
```

This might be due to a number of factors, including the presences of
universities. Though Nashville is home to 
Vanderbilt University, that is a much smaller school with less of a commuter 
population than the Universities of Texas, Minnesota, or Utah. On the other hand,
it is possible that the general populations of Austin and Minneapolis are 
are younger as well. With this data we can't say whether the age distributions
we are seeing here reflect the city or are in some way reflective of who
commuter rail systems are able to reach.


## Ethnicity 
The preponderance of CRT riders in all cities are White. Aside from this it is
difficult to make comparative statements across regions, as the ethnic
distribution in the population as a whole is unknown. That said, I would
have expected more Black riders in Nashville.

Further neither San Diego nor Salt Lake City asked about the respondents' race.

```{r ethnicity, fig.keep = 'last', warning = FALSE}
ggplot(CRTsurveys, aes(x = race, weight = cityweight)) + 
  geom_bar(position = "dodge", aes(y = ..count.., fill = city, group = city),
           color = "black") +
  xlab("Rider Ethnicity") + scale_y_continuous(labels = percent) + 
  ylab("Percent")
```




## Gender

The gender split of commuter rail riders is interesting, though again it may
be more indicative of cultural trends in the region than a characteristic of
commuter rail riders in general. 

I am curious why so many more women than men ride commuter rail in Nashville 
and Minneapolis.

```{r sex, fig.keep = 'last', warning = FALSE}
ggplot(CRTsurveys, aes(x = sex, weight = cityweight)) + 
  geom_bar(position = "dodge", aes(y = ..count.., fill = city, group = city),
           color = "black") +
  xlab("Rider Gender") + scale_y_continuous(labels = percent) +
  ylab("Percent")
```


## Choice and Vehicle
Most surveys ask some form of "If this train were not available, how would you
make this trip?" The figure below shows that well over half of riders in each
city are choice riders, but that Nashville really stands out as being over 90%
choice.


```{r choice}
ggplot(CRTsurveys, aes(x = choicerider, weight = cityweight)) + 
  geom_bar(position = "dodge", aes(y = ..count.., fill = city, group = city),
           color = "black") +
  xlab("Do you have another way to make this trip?") +
  scale_y_continuous(labels = percent) +
  ylab("Percent")
```

  > Personal footnote: high numbers of choice riders show that transit is
  > getting cars off the road, but also that the system may not be designed for
  > people in the community who need to use it.

The surveys also ask about the households size, and the number of vehicles 
available to the household. *Note: the surveys are not consistent. Some ask*
*about number of people over 15, or number of adults, or total number.* In
the following figure, we see the difference between vehicles and household size
by city.

```{r vehiclesufficient}
CRTsurveys <- CRTsurveys %>%
  mutate(sufficient = cut(hhsize - cars, breaks = c(-Inf, 1, Inf), 
                          labels = c("Sufficient", "Insufficient")))
ggplot(CRTsurveys, aes(x = sufficient, weight = cityweight, fill = city)) + 
  geom_bar(position = "dodge", aes(y = ..count..,  group = city),
           color = 'black') + 
  xlab("Are there as many vehicles as household *members*?") +
  scale_y_continuous(labels = percent) +
  ylab("Percent")
```

```{r vehicle_ownership}
car_groups <- CRTsurveys %>% ungroup() %>%
  mutate(
    cars = ifelse(cars > 2, 2, cars),
    cars = ifelse(cars < 0, 0, cars)
  ) %>%
  filter(!is.na(cars)) %>%
  group_by(cars, city) %>%
  summarise(n = sum(weight)) %>%
  group_by(city) %>%
  mutate(n = n / sum(n) * 100)

car_groups %>%
  spread(cars, n)  %>%
  kable(caption = "Share of riders by vehicle ownership.")
```

```{r grouped_vehicle_bars}
ggplot(car_groups, aes(x = cars, y = n, fill = city)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  xlab("Number of Vehicles") + ylab("Percent of Riders")
```

#### Vehicle Ownership by Trip Purpose

```{r vehicle_purpose}
purposes_by_vehicle <- CRTsurveys %>% ungroup() %>%
  mutate(
    cars = ifelse(cars > 2, 2, cars),
    cars = ifelse(cars < 0, 0, cars)
  ) %>%
  filter(
    !is.na(cars), 
    atype != "Home",
    city %in% c("Miami", "Salt Lake", "Nashville")
  ) %>%
  group_by(cars, city, atype) %>%
  summarise(n = sum(weight)) %>%
  group_by(city) %>%
  mutate(n = n / sum(n) * 100)

ggplot(purposes_by_vehicle, aes(x = cars, y = n, fill = city)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_grid(. ~ atype) +
  xlab("Number of Vehicles") + ylab("Percent of System Riders")
```





# Use Patterns

## Trip Purpose

The tables below give trip purpose as determined by a combination of production
and attraction type. The `Other` category includes shopping, medical visits,
recreation and personal activities, etc. The production type is given in the rows
and the attractions in the columns.

```{r trippurpose, results = 'asis'}
# Raw numbers, using given weights
purptable <- wtd.table(CRTsurveys$ptype, CRTsurveys$atype,
                       weights = CRTsurveys$weight)
kable(purptable, digits = 0)
```



```{r trippurposePct, results='asis'}
# Percent, using given weights
kable(purptable/sum(CRTsurveys$weight)* 100, digits = 2)
```


### By city


```{r}
CRTsurveys %>% group_by(ptype, city) %>%
  summarise(n = sum(weight)) %>%
  spread(city, n, fill = 0) %>%
  kable(digits = 2)
```
The vast majority of trips in all systems are work commute trips, with
a home as production and work at the attraction end. The main exception to this 
is Austin, which has more trips destined for schools than work.


  > Note that in some cases trips are "attracted" to a home. This occurs when
  > 1) a trip is coded as `Home` to `Home` or 2) the source data is explicitly
  > coded as P and A.

```{r trippurpchard}
ggplot(CRTsurveys, aes(x = atype, fill = city, weight = cityweight)) +
  geom_bar(position = "dodge", aes(y = ..count.., group = city)) +
  scale_y_continuous(labels = percent) + 
  facet_grid(ptype ~ .) + 
  ylab("Production Type") + xlab("Attraction Type")
```


## Access Mode


```{r accessmode, results='asis'}
# Raw numbers, weighted
accesstable <- wtd.table(CRTsurveys$paccessmode, CRTsurveys$aaccessmode,
                         weights = CRTsurveys$weight)
accesstable <- rbind(accesstable, colSums(accesstable))
accesstable <- cbind(accesstable, rowSums(accesstable))
rownames(accesstable)[7] <- colnames(accesstable)[7] <- "Sum"
# Raw numbers
kable(accesstable, digits = 0 )
#Percents
kable(accesstable/sum(CRTsurveys$weight) * 100, digits = 1)
```

The access and egress modes to commuter rail are somewhat more varied than the
trip purpose. About half of all CRT riders surveyed 
accessed the system by `Car` (including carpool, drive alone, and taxi).
At the same time, a substantial percentage accessed on the production end
by walking. About 15 percent accessed by either `Bus` or `Rail`.
`, which includes all non-CRT 
public transit modes.

Access on the attraction end (or egress) is predominantly by walking or another
transit mode.

  > note that the percents in the table do not sum to 1; this is because 
  > of missing data.

### By City

Again, there is variety between systems in access type, though this is likely
a function of the design of the city and the transit system. In Austin, about 50
percent of people walk or ride a bike on both ends of the trip.
highest share of people who walk on both ends of the trip, whereas the 
predominant pattern in Salt Lake City is to drive to the rail and then take
another transit mode (either `Bus` or `Rail`) on the other end.


```{r accessbyCity, fig.height=10}
ggplot(CRTsurveys, aes(x = aaccessmode, fill = city, weight = cityweight)) +
  geom_bar(position = "dodge", aes(y = ..count.., group = city))+
  scale_y_continuous(labels = percent) + 
  facet_grid(paccessmode ~ .) + 
  ylab("Production Mode") + xlab("Attraction Mode")
```



## Trip Frequency
One question frequently asked in the surveys concerns the frequency of use, and
whether this was the first time the respondent had used the commuter rail. To
compare these answers as a numerical variable, we converted them to an 
expectation of occurrence on a workday. For example, if someone said they took
CRT "1-2 times per month", we convert this to $1.5/20 = 0.075$; similarly, 
"Three times per week" becomes $3/5 = 0.6$. (Note that if someone says they 
take CRT 6 or 7 days a week the probability is greater than 1.)

Unsurprisingly, most CRT riders tend to be habitual, using it every day. At the
same time, there are significant numbers who take it only occasionally.

```{r frequency, fig.keep='last', warning=FALSE}
ggplot(CRTsurveys, aes(x = freq, weight = weight)) +
  geom_density(fill = "black", alpha = 0.7) +
  xlab("Probability of taking CRT on Workday")
```

Again, there is variation between cities. Nashville, Washington,  and Dallas 
are almost  entirely habitual, and Austin, Minneapolis, and Salt Lake City have a 
large number of people who take CRT regularly but not every day. This
could be a consequence of several potential situations:
  - choice riders for whom automobiles remain an attractive mode
  - university class schedules
  - large employers offering compressed work schedules

  > Note: San Diego did not ask about trip frequency

```{r frequencybycity, fig.keep='last', warning=FALSE, fig.height=10}
ggplot(CRTsurveys, aes(x = freq, fill = city, weight = cityweight)) + 
  geom_density(alpha = 0.7) + facet_grid(city ~.) +
  xlab("Probability of taking CRT on Workday") +
  ylab("Weighted density: sum = 1")
```

The first one is something that we can actually test, with the `choicerider`
variable in the data. It actually appears that captive transit passengers are
**less** likely to be habitual CRT users.
```{r frequencybychoice, fig.keep='last', warning=FALSE, fig.height=10}
ggplot(filter(CRTsurveys, !(is.na(choicerider))), 
       aes(x = freq, fill = city, weight = cityweight)) + 
  geom_density(alpha = 0.7) +
  ggtitle("Do you have another way to make this trip?")  +
  xlab("Probability of taking CRT on Workday") +
  ylab("Weighted Density: sum = 1") +
  facet_grid(facet = city ~ choicerider)
```


We can also look at sufficiency plotted against frequency. The least-squares
regression fit by city is also superimposed on the plot. For most cities we
cannot reject that there is no relationship between sufficiency and trip
frequency. In Washington, there appears to be a relationship where as 
insufficiency increases (there are more people than cars), trip frequency goes
*down*. Salt Lake shows the exact opposite relationship, with trip frequency
and insufficiency increasing together.
```{r frequencybysufficiency, warning=FALSE}
ggplot(CRTsurveys, aes(x = hhsize - cars, y = freq, color = city,
                       weight = cityweight)) +
  geom_jitter(alpha = 0.2, 
              position = position_jitter(width = 0.5, height = 0.2)) + 
  stat_smooth(method = "lm", lwd = 2) +
  xlab("Difference: HH Size - Cars") + ylab("Trip Frequency")
```


## Purpose and Access Mode by Auto Ownership

How much does vehicle availability determine the production mode? We're only
worried about trips produced at home.

```{r production_by_sufficiency, results='asis'}
purpose_mode_ownership <- CRTsurveys %>%
  filter(ptype == "Home") %>%
  filter(atype != "Home") %>%
  filter(!is.na(cars)) %>%
  filter(!is.na(income)) %>%
  filter(!is.na(atype)) %>%
  filter(!is.na(paccessmode)) %>%
  mutate( cars = ifelse(cars >= 2, "2 +", cars) ) %>%
  
  # weighted surveys in each group
  group_by(city, cars, paccessmode, atype) %>%
  summarise(n = sum(weight))
```

```{r purpose_mode_tables}
purpose_mode_ownership %>%
  group_by(atype, cars, paccessmode) %>%
  summarise(n = sum(n)) %>%
  group_by(atype, cars) %>%
  mutate(n = n / sum(n) * 100) %>%
  spread(paccessmode, n, fill = 0) %>%
  kable(., digits = 2, caption = "Access mode share by attraction type and vehicle ownership")

purpose_mode_ownership %>%
  filter(city %in% c("Nashville", "Miami")) %>%
  group_by(atype, cars, paccessmode) %>%
  summarise(n = sum(n)) %>%
  group_by(atype, cars) %>%
  mutate(n = n / sum(n) * 100) %>%
  spread(paccessmode, n, fill = 0) %>%
  kable(., digits = 2, caption = "Nashville and Miami: Access mode share by attraction type and vehicle ownership")
```


```{r purpose_mode_figure}
for(i in c("Nashville", "Miami", "Salt Lake")){
y <- ggplot(purpose_mode_ownership %>%
         filter(city == i) %>%
         group_by(city, cars) %>%
         mutate(n = n / sum(n)),
       aes(x = paccessmode, y = n)) +
  geom_bar(position = "dodge", stat = "identity") +
  facet_grid(cars ~ atype) +
  ylab(i)
  print(y)
}

```


Globally, about 60% of sufficient households use `Car` (drive alone, carpool,
taxi) to exit commuter rail, compared to only 30% of insufficient households.
That said, `Car` remains a primary mode of access even for insufficient 
households. This may be because the commuter rail rider uses the vehicle and
leaves others to find another mode, or because sufficiency is based on the
number of housheold members rather than simply the number of workers 
specifically.



### By city
Many cities show similar profiles, though Austin has been successful in 
getting insufficient commuters to walk to the station, and Miami has many 
drop-offs for both types. A number of people in both groups in Dallas and
Washington used rail, but we don't know necessarily how they got to their
original origin station because of how I cleaned the data. 

```{r pmodebycity, fig.width=8}
ggplot(filter(CRTsurveys, !(is.na(sufficient))), 
       aes(x = paccessmode, fill = city, weight = cityweight)) + 
  geom_bar(position = "dodge", aes(y = ..density.., group = city), 
           color = "black") + facet_grid(sufficient ~ .) +
  xlab("Production Mode") +
  ylab("Sufficiency (Percent by Row)") + scale_y_continuous(labels = percent)
```

## Peak Period Travel
The chart below shows peak and off-peak travel by city. In most cities there
is a strong bias towards peak travel with more than 50 of riders in modst cities
traveling in the peak period. Austin and Salt Lake City have the most peaked 
distribution, and Washington and Dallas have the highest off-peak shares.

When the survey data included the specific time of the trip, I called peak trips
those happening between 7-10 AM and 4-7 PM. Some surveys, however, only included
their own internal definitions of peak period, so it is possible that these 
data are not fully comparable.

```{r peak_period}
ggplot(CRTsurveys, aes(x = period, fill = city, weight = cityweight)) +
  geom_bar(position = "dodge", aes(y = ..count.., group = city)) +
  xlab("Period") + ylab("Proportion of riders")
```

```{r peak_purpose}
ggplot(CRTsurveys, aes(x = period, fill = city, weight = cityweight)) +
  geom_bar(position = "dodge", aes(y = ..count.., group = city)) +
  facet_grid(~ atype) +
  xlab("Period") + ylab("Proportion of riders")
```


>>>>>>> 138ed7adda32d59ab22186ec22d8a70e3569941e
