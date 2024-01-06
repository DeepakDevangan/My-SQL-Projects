create database if not exists walmart_sales;

use walmart_sales;


-- create a table
CREATE TABLE IF NOT EXISTS sales 
(
	invoice_id varchar(30) not null primary key,
    branch varchar(30) not null,
    city varchar(30) not null,
    customer_type varchar(30) not null,
    gender enum('M','F') not null,
    product_line varchar (100) not null,
    unit_price decimal(10,2) not null,
    quantity int not null,
    tax_pct float not null,
    total decimal(12, 4) not null,
    date datetime not null,
    time time not null,
    payment varchar(30) not null,
    cogs decimal(10,2) not null,
    gross_margin_pct float,
    gross_income decimal(12, 4),
    rating float
);

-- check the record now
select
	*
from
	sales;
    
-- add the time_of_day column
select
	time,
    (case
		when time between '00:00:00' and '12:00:00' then 'morning'
        when time between '12:01:00' and '16:00:00' then 'Afternoon'
        else 'Evening'
        end) as time_of_day
from
	sales;
  
alter table sales 
add column time_of_day varchar(20);

update sales
set time_of_day = (case
		when time between '00:00:00' and '12:00:00' then 'morning'
        when time between '12:01:00' and '16:00:00' then 'Afternoon'
        else 'Evening'
        end);

-- add day_name column & month_name column
alter table sales
add column day_name varchar(10);

update sales
set day_name = dayname(date);

alter table sales
add column month_name varchar(10);

update sales
set month_name = monthname(date);

######################### GENRIC ##############################
-- How many unique cities are here in database
select
	distinct city
from
	sales;

-- which city has a specific branch
select
	distinct city,
    branch
from
	sales;

########################## PRODUCT ############################# 
-- How many unique product lines does the data have?
select
	distinct product_line
from
	sales;

-- what is the most selling product line
select
	product_line,
    sum(quantity) as quantity
from
	sales
group by product_line
order by quantity desc;

-- what is the total revenue by month
select
	month_name as month,
    sum(total) as total_revenue
from
	sales
group by month_name
order by total_revenue;


-- which month has largest COGS?
select
	month_name as month,
    sum(cogs) as cogs
from
	sales
group by month_name
order by cogs;

-- which product line had the largest revenue
select
	product_line,
    round(sum(total),2) as total_revenue
from
	sales
group by product_line
order by total_revenue desc;

-- city with largest revenue
select
	city,
    branch,
    round(sum(total),2) as total_revenue
from
	sales
group by city, branch
order by total_revenue desc;


-- fetch each product line and add a column to those product line showing "Good" & "Bad". 
-- Good if it is greater than average sales
select
	avg(quantity)
from
	sales;

select
	product_line,
    (case
		when avg(quantity) > 5.51 then 'Good'
        else 'Bad'
    end) as remark
from
	sales
group by product_line;


-- which branch sold more products than average product sold
select
	branch,
    sum(quantity) as qty
from
	sales
group by branch
having sum(quantity) > (select avg(quantity) from sales);

-- what is the most common product line by gender
select
	gender,
    product_line,
    count(gender) as gender_count
from
	sales
group by gender, product_line
order by gender_count;

-- what is the average rating of each product_line
select
	product_line,
    round(avg(rating),3) as avg_rating
from
	sales
group by product_line
order by avg_rating;

########################### CUSTOMERS ############################
-- How many unique customer types does the data have
select
	count(distinct customer_type)
from
sales;

select
	distinct customer_type
from
sales;

-- what is the most common customer type
select
	customer_type,
    count(*) as count
from
	sales
group by customer_type
order by count desc;

-- which customer type buys the most?
select
	customer_type,
    count(*) as count
from
	sales
group by customer_type
order by count desc;

-- what is the gender of most customers?
select
	gender,
    count(*) as gender_count
from
	sales
group by gender
order by gender_count desc;

-- which time of the day do customers give most ratings?
select
	time_of_day,
    count(rating) as rating_count
from
	sales
group by time_of_day
order by rating_count desc;

-- which day of the week has the best average ratings per branch?
select
	day_name,
    avg(rating) as avg_rating
from
	sales
group by day_name
order by avg_rating desc;


######################### CUSTOMERS #########################
-- Number of sales made in each time of the day per weekday
select
	day_name,
    time_of_day,
    count(*) as sales_count
from
	sales
group by day_name, time_of_day
order by sales_count;

-- which type of customer brings the most revenue?
select
	customer_type,
    round(sum(total),2) as total_revenue
from
	sales
group by customer_type
order by total_revenue desc;


