
<!-- Declutter as we move forward!
      - Comment out what you still want to reference but don't want to present
        - This works well for README conflicts as well, we can discuss which version we'd like to keep when we can meet live
      - Simplify our writing, most people aren't going to want to look at too much
        - Play with formatting to draw attention where we really want it
        - What tense are we using, change to reflect where we're at
        - Image sizing and formatting
        - Links -->
# California EV Dreams
A collaborative project to determine what factors drive adoption of electric vehicles in California.

## Table of contents
* [Overview of Project](#overview-of-project)
* [Data Collection and Cleaning](#data-collection-and-cleaning)
* [Database](#database)
* [Machine Learning Models](#machine-learning-models)
* [Results](#results)
* [Summary](#summary)
* [Future Opportunities](#future-opportunities)

### Resources
- Data Source: CA_county_incentives.csv, demographics.csv, ZEV_Sales.csv, CA_pop_2015-2022.csv
- Tools: Python 3.7.13, Jupyter Notebook, Excel, SQL, Tableau, Google Slides, HTML, CSS, Javascript

## Overview of Project
We looked within California counties to determine any relevant factors that contribute most to EV purchases. The primary data we used for our analysis was the amount of incentives offered and max amount of incentives by county. As supplementary factors, we also used population and demographic data. Using this analysis we hope to be able to accurately predict whether someone will buy an EV, and present to manufacturers the strengths and weaknesses in their market and potential improvements that can be made.

Hypothesis: Incentives improve EV adoption in counties.
- What is the opportunity in identifying a gap in this dataset?
- What is the market opportunity?
- Which counties in CA should EV manufacturers focus their marketing?
- Should EV manufacturers be encouraging implementation of incentives to drive sales?

## Data Collection and Cleaning
<!-- This comment is hidden from public: Add bullet points and explain changes made to original datasets -->
All datasets are for the state of California, we focused our efforts on the years 2015 to present.
- Found incentives data on [driveclean.ca.gov](https://driveclean.ca.gov/search-incentives)
  - Used provided information and resource links to create CA_county_incentives.csv
  - Emailed organizations for additional info, like start and end dates, if missing
      - Some organizations didn't get back to us, we made the assumption that the start date was 1/1/2019 for these
      - More funding for EV incentives came in this year and many other incentives started on this date
  - Categorized by EV type and added columns for requirements, low income eligibilty, customer eligibilty, and one-time use
  - Removed program name of the incentive given that this datapoint was of little to no significance
- The [demographics](https://datadryad.org/stash/dataset/doi:10.25338/B8P313) dataset contains socioeconomic data of EV owners
  - The dataset covers the years 2015 to 2017
    - [Research papers](https://www.sciencedirect.com/org/science/article/pii/S0144164722003397#:~:text=The%20literature%20identifies%20the%20following%20external%20factors%20as%20having%20the,and%20public%20visibility%2Fsocial%20norms.) indicate that the factors (in this dataset) for EV ownership haven't changed significantly
  - Removed null values and unnecessary columns such as column containing survey year which was duplicative of the 'year' column.  
  - Changed column names for SQL table and sampled 50% of cleaned data
  - Data is not separated by county
- [ZEV sales](https://www.energy.ca.gov/data-reports/energy-almanac/zero-emission-vehicle-and-infrastructure-statistics/new-zev-sales) data contains number of EVs purchased
  - Grouped by county and year
  - Changed fuel types to match incentives dataset values
  - Added percentage of state sales per year
  - Removed the zip code because we were focused on counties
  - Removed duplicate fuel type column
- Population estimates by county from [2010](https://dof.ca.gov/forecasting/demographics/estimates/estimates-e6-2010-2021/) to [2022](https://dof.ca.gov/forecasting/demographics/estimates/e-5-population-and-housing-estimates-for-cities-counties-and-the-state-2020-2022/) was found on dof.ca.gov
  - Added percentage of state population

## Database
<!-- This comment is hidden from public: Add ERD/excel database model and any bullet points  -->
We used an AWS Relational Database and SQL, this allowed any team member to link to and update the collective database.
- 4 tables from cleaned datasets (sales, incentives, population, demographics)
- 3 tables created from merges or joins (county_year_merged, merged_demo, sales_pop)
  - county_year_merged includes sales, population, and incentives data for county and year from 2015-2022
      - Incentive counts for county and state calculated using a for loop
      - Incentive max amounts calculated using a for loop, .max(), and .sum() functions
      - County and state totals summed and added to new columns
  - merged_demo is similar to above, but only covers 2015-2017, and includes average (statewide) demographics for each year
  - sales_pop is joined on county and year for sales and population
- 2 tables created with pandas to calculate and add in percentages (county_year_sales, avg_demo)

## Machine Learning Models
After initial evaluation, we identified that the incentives, population, and sales data would provide the best model for our hypothesis. Demographics data served as a support. Our dependent variable was sales, and independent variables were incentive counts, incentive max amounts, demographics, population, and county.
- We split our train and test data on number of sales and removed sales percentage
- Originally planned to use a multiple linear regression, but chose a Random Forest Regressor for better fit and prediction
- The model was run 4 times: merged_demo with and without counties, county_year_merged with and without counties

merged_demo with counties                    |  merged_demo without counties
:-----------------------------------:|:-----------------------------------:
![merged_demo_c](/Images/Merged_demo_counties_ML.PNG) |  ![merged_demo_nc](/Images/Merged_demo_ML.PNG)
![1](/Images/rfreg_mdemo_c1.png) |  ![1](/Images/rfreg_mdemo_nc1.png)
![2](/Images/rfreg_mdemo_c2.png) |  ![2](/Images/rfreg_mdemo_nc2.png)
![3](/Images/rfreg_mdemo_c3.png) |  ![3](/Images/rfreg_mdemo_nc3.png)

merged_demo with counties received an R² training score of 0.986 and testing score of 0.907
- The model's top 3 features were population, Los Angeles County, and Santa Clara County
merged_demo without counties received an R² training score of 0.971 and testing score of 0.792
- The model's top 3 features were population percentage, total incentives, and county max amount

county_year_merged with counties                    |  county_year_merged without counties
:-----------------------------------:|:-----------------------------------:
![county_year_merged_c](/Images/County_year_merged_ML.PNG) |  ![county_year_merged_nc](/Images/County_year_merged_ML_dropcounty.PNG)
![1](/Images/rfreg_cym_1.png) |  ![1](/Images/rfreg_cym_nc_1.png)
![2](/Images/rfreg_cym_2.png) |  ![2](/Images/rfreg_cym_nc_2.png)
![3](/Images/rfreg_cym_3.png) |  ![3](/Images/rfreg_cym_nc_3.png)

county_year_merged with counties received an R² training score of 0.988 and testing score of 0.839
- The model's top 3 features were Orange County, total incentives, and county incentives
county_year_merged without counties received an R² training score of 0.970 and testing score of 0.772
- The model's top 3 features were county max amount, population, and total incentives

We found a stacking regressor [here](https://scikit-learn.org/stable/auto_examples/ensemble/plot_stack_predictors.html#sphx-glr-auto-examples-ensemble-plot-stack-predictors-py), which lead us to try Gradient Boosting Regressor.
- merged_demo with counties received best accuracy score on training set of 100% and testing set of 92.4%
- merged_demo without counties received best accuracy score on training set of 100% and testing set of 92.3%
- county_year_merged with counties received best accuracy score on training set of 100% and testing set of 82.1%
- county_year_merged without counties received best accuracy score on training set of 100% and testing set of 78.8%

## Results
<!-- Visualizations from Tableau included, bullet points for presentation -->
Both the Random Forest Regressor and Gradient Boosting Regressor did well at predicting EV sales, with R² values above 0.75 and accuracy scores above 75% (respectively) for all models run. Incentives were in the top 3 feature importance for all models, except for the merged_demo data with counties. However, incentives still made the top 10 feature importances for this dataset.

The merged_demo data with counties included had the best results for both models.
- Random Forest: R² training score of 0.986 and testing score of 0.907
- Gradient Boosting: Accuracy score on training set of 100% and testing set of 92.4%

The county_year_merged data without counties performed the worst for both models.
- Random Forest: R² training score of 0.970 and testing score of 0.772
- Gradient Boosting: Accuracy score on training set of 100% and testing set of 78.8%

<div class='tableauPlaceholder' id='viz1662055482633' style='position: relative'><noscript><a href='https://public.tableau.com/views/CaliforniaEVDreams/CAEVDreams?:language=en-US&:display_count=n&:origin=viz_share_link'><img alt='CA EV Dreams ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Ca&#47;CaliforniaEVDreams&#47;CAEVDreams&#47;1_rss.png' style='border: none' width="650" /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='CaliforniaEVDreams&#47;CAEVDreams' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Ca&#47;CaliforniaEVDreams&#47;CAEVDreams&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /></object></div>



## Summary
<!-- Answer our questions, did this turn out as expected? If not, what surprised us? Quick notes for manufacturers:
- What is the opportunity in identifying a gap in this dataset?
- What is the market opportunity?
- Which counties in CA should EV manufacturers focus their marketing?
- Should EV manufacturers be encouraging implementation of incentives to drive sales? -->
Given the results, feature importances, and visualizations, we concluded that **incentives are highly correlated to EV sales in California**. Incentive count or amount is correlated with sales *and* ability to predict sales for most of our models. Unsurprisingly, population also plays a large factor in EV sales, but the 3 counties that showed up in the top 3 feature importances in the different Random Tree Regression models vary widely in population. According to California's Department of Finance county population estimates as of 2022:
- Orange has a population of 3,186,989 (county_year_merged top 3)
- Los Angeles has a population of 10,014,009 (merged_demo top 3)
- Santa Clara has a population of 1,936,259 (merged_demo top 3)

### Limitations
<!-- Where did we struggle? What could have been better? What was lacking? Leads into Future Opps -->
The demographics data wasn't as meaningful since it wasn't separated by county and only covered the years 2015-2017. Ideally we would have found demographics data that included other socio-economic data, was more recent, and was separated by county. Time constraints also prevented us from implementing some things as planned.
- Due to COVID-19 creating large variance in sales, we wanted to exclude 2020-2021 from our analysis
- For loops and conditionals for county_year_merged ate up a lot of time
- Dependencies on database setup created backlog for fine-tuning our machine learning models

## Future Opportunities
<!-- Where can we go from here? Specify data, models, tools -->
- One of the factors we would consider is ethnic and racial diversity in each county
    - Does this matter and or play a part in the breakdown of sales by county?
- Deeper look into Orange, Los Angeles, and Santa Clara counties
    - With populations varying so much, what are the factors within these counties that are similar?
    - Look at these feature importances in other counties
- Comparison of ICE (Internal Combustion Engine) and EV sales
    - Do different vehicle types sell at similar rates within counties?
      - If not, what factors contribute to these differences?
    - What do the demographics of these vehicle types look like?
    - How can EV manufacturers widen their customer base, based on these results?
- Another factor we would consider is age. The demographics data we used showed the average age of an EV owner across California is 50
    - This highlighted a major opportunity for manufacturers to tap into a younger demographic
    - Perhaps manufacturers could stand to build a customer centric approach to attract younger generations to bridge the gap



