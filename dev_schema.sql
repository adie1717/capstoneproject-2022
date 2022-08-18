-- Make tables for 3 datasets
CREATE TABLE incentives (
  county VARCHAR,
  incentive_type VARCHAR,
  ev_type VARCHAR,
  max_amount INT,
  requirements BOOLEAN,
  low_income BOOLEAN,
  customer BOOLEAN,
  one_time BOOLEAN,
  provider_name VARCHAR,
  start_date DATE,
  end_date DATE
 );

CREATE TABLE demographics (
  year INT,
  car_main VARCHAR,
  previous_evs BOOLEAN,
  household_income INT,
  importance_of_gge FLOAT,
  home_owner BOOLEAN,
  education INT,
  commute_distance FLOAT,
  age INT,
  gender BOOL,
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