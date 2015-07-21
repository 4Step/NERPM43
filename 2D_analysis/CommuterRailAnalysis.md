
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
