create database cars;

use cars;


#Task-1: Get a records of all cars exist in the database:
select
	*
from
	car_dekho;

#Task-2: Manager asked the employee to retrive the following data:
-- Records of all cars in the year 2023
-- Number of cars in the year 2023?
select 
	*
from
	car_dekho
where year = 2023;

select count(*)
from
	car_dekho
where year = 2023;


#Task-3: Employee was asked to retrive the number of cars were prsent in the year 2020, 2021, 2022
select
	year, count(*)
from
	car_dekho
where year in( 2020, 2021, 2022)
group by year
order by year;

#Task-4: Client asked to print only the total number of cars per year
select
	year, count(*)
from
	car_dekho
group by year
order by year;


#Task-5: Client wants to know that how  many diesel cars were encountered last year (2022)
select
	fuel, count(*)
from
	car_dekho
where year = 2022 and (fuel = 'Diesel' or fuel = 'Petrol')
group by fuel; 


#Task-6: Manager asked to employee to print number of all fuel cars (Diesel, Petrol, CNG) encountered by all year
select
	year, 
    fuel,
    count(*) as number_of_cars
from
	car_dekho
group by year, fuel;


#Task-7: Manager asked in which year more than 100 cars were encountered
select
	year,
    count(*) as Number_of_Cars
from
	car_dekho
group by year having count(*) > 100
order by year asc;


#Task-8: retrieve the following data:
-- total number of car encountered between year 2015 and year 2023
-- Complete list of all cars between 2015 and 2023
select
	count(*)
from
	car_dekho
where year between 2015 and 2023;

select
	*
from
	car_dekho
where year between 2015 and 2023;

######################################## END OF ANALYSIS ############3###################################

