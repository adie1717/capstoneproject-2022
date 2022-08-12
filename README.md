# California EV Dreams
A collaborative project to determine what factors drive ownership of electric vehicles in California.

## Table of contents
* [Overview of Project](#overview-of-project)
* [Data Collection and Cleaning](#data-collection-and-cleaning)
* [Database Model](#database-model)
* [Machine Learning Model](#machine-learning-model)
* [Results](#results)
* [Summary](#summary)

### Resources
- Data Source: CA_county_incentives.csv, [demographics.csv](https://datadryad.org/stash/dataset/doi:10.25338/B8P313), [ZEV_Sales.csv](https://www.energy.ca.gov/data-reports/energy-almanac/zero-emission-vehicle-and-infrastructure-statistics/new-zev-sales)
- Tools: Python 3.7.13, Jupyter Notebook, Excel

## Overview of Project
Using 3 datasets containing California electric vehicle information, we are aiming to create a relational database and examine what 3 major factors are highly correlated with EV adoption. Using this data we hope to be able to accurately predict whether someone will buy an EV and present to manufacturers the strengths and weaknesses in their market and potential improvements that can be made.

- Hypothesis: The 3 major factors improve EV sales/ownership in counties with at least X values for those factors.
  - What is the opportunity in identifying a gap in this dataset?
  - What is the market opportunity?

## Data Collection and Cleaning
- Found CA incentives data on [driveclean.ca.gov](https://driveclean.ca.gov/search-incentives)
  - Used provided information and resource links to create CA_county_incentives.csv
  - Emailed organizations for additional info, like start and end dates, if missing
  - Categorized by EV type and added columns for Requirements, Low Income eligibilty, Membership eligibilty, and One-time Use

## Database Model
<!-- This is hidden from public view: Put database preview (ERD/excel) here and any associated bullet points -->

## Machine Learning Model
- Takes in data from provisional model
  - Dependent variable: Ownership/Sales
  - Independent variables: Income, Incentives, Length of Commute, etc.
    - 3 highly correlated factors to be determined by multiple linear regression analysis 
- Outputs label(s) for input data
  - p-values of top 3 correlated factors
  - Accuracy of nn model prediction of EV ownership

## Results
<!-- This is hidden from public view: Put wireframe preview here and any associated bullet points -->

## Summary
