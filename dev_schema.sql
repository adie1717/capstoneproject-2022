-- Make tables for 3 datasets
CREATE TABLE incentives (
  county VARCHAR,
  incentive_type VARCHAR,
  ev_type VARCHAR,
  max_amount INT,
  requirements INT/BOOL,
  low_income INT/BOOL,
  customer INT/BOOL,
  one_time INT/BOOL,
  provider_name VARCHAR,
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

SELECT * FROM demographics
ORDER BY year, car_main;