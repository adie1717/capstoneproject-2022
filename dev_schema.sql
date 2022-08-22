-- Make tables for 4 datasets
CREATE TABLE incentives (
  county VARCHAR,
  incentive_type VARCHAR,
  ev_type VARCHAR,
  max_amount INT,
  requirements INT/BOOL,
  low_income INT/BOOL,
  customer INT/BOOL,
  one_time INT/BOOL,
  start_date DATE,
  end_date DATE
 );

CREATE TABLE demographics (
  year INT,
  car_main VARCHAR,
  previous_evs INT/BOOL,
  household_income INT,
  importance_of_gge FLOAT,
  homeowner INT/BOOL,
  education INT,
  commute_distance FLOAT,
  age INT,
  gender INT/BOOL,
  number_of_vehicles INT,
  annual_miles FLOAT
 );
 
 CREATE TABLE sales (
  year INT,
  county VARCHAR,
  fuel_type VARCHAR,
  make VARCHAR,
  model VARCHAR,
  number_of_vehicles INT
 );

 CREATE TABLE population (
  county VARCHAR,
  year INT,
  population INT,
  percent_change FLOAT,
  number_change INT
 );


-- Create county_year_sales
CREATE TABLE county_year_sales AS SELECT county, year,
	SUM(number_of_vehicles) as number_sales
	FROM sales
	GROUP BY county, year
	ORDER BY county asc;


-- Join county_year_sales and population
CREATE TABLE sales_pop AS
(SELECT cys.county, cys.year, cys.number_sales, cys.sales_percentage, pop.population, pop.pop_percentage
FROM county_year_sales AS cys
RIGHT JOIN population AS pop
ON cys.county=pop.county AND cys.year=pop.year);


-- Sort demographics table by year and car_main
SELECT * FROM demographics
ORDER BY year, car_main;