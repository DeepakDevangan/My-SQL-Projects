/* Database - Analysis */

use foodie_fi;

# 1. How many customers has Foodie-Fi ever had?
select
	count(distinct customer_id) as number_of_customers
from
	subscriptions;
    

# 2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value
select
	month(start_date) as month,
    count(distinct customer_id) as number_of_counters
from
	subscriptions
group by month;


# 3. What plan 'start_date' values occur after the year 2020 for our dataset? Show the breakdown by count of events for each 'plan_name'
select
	p.plan_name as plan_name,
    p.plan_id as plan_id,
    count(*) as count_events
from
	subscriptions s
    join
    plans p on p.plan_id = s.plan_id
where s.start_date > 2020-12-31
group by p.plan_id, plan_name
order by count_events;


# 4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
select
	count(*) as customer_churn,
    round(count(*)*100/(select count(distinct customer_id) from subscriptions),1) as per_churn
from
	subscriptions
where plan_id = 4;


# 5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?
WITH cte_churn AS (
	SELECT
		*,
		LAG(plan_id, 1) OVER(PARTITION BY customer_id ORDER BY plan_id) AS prev_plan
	FROM subscriptions)
SELECT
	COUNT(prev_plan) AS cnt_churn,
    	ROUND(COUNT(*) * 100/(SELECT COUNT(DISTINCT customer_id) FROM subscriptions),0) AS perc_churn
FROM cte_churn
WHERE plan_id = 4 and prev_plan = 0;

    