/* Customer Nodes Exploration */

use neo_bank;

----------------------------------------------------------------
# 1. How many unique nodes are there on the Data Bank system?
select
	count(distinct node_id) as unique_nodes
from
	customer_nodes;
----------------------------------------------------------------
    
# 2. What is the number of nodes per region?
select
	r.region_name as region_name,
    count(cn.node_id) as number_of_nodes
from
	region r
    join
    customer_nodes cn on r.region_id = cn.region_id
group by region_name
order by number_of_nodes desc;
----------------------------------------------------------------

# 3. How many customers are allocated to each region?
select
	r.region_name as Region_Name,
    count(distinct cn.customer_id) as Number_of_Customers
from
	region r
    join
    customer_nodes cn on r.region_id = cn.region_id
group by Region_Name
order by Number_of_Customers desc;
----------------------------------------------------------------

# 4. How many days on average are customers reallocated to a different node?
with sum_diff_day as (
select 
	customer_id, node_id, start_date, end_date,
    sum(datediff(end_date, start_date)) as sum_diff
from customer_nodes
where end_date != '9999-12-31'
group by customer_id, node_id, start_date, end_date
order by customer_id, node_id)
select 
	round(avg(sum_diff),0) as avg_reallocated_days
from sum_diff_day;
----------------------------------------------------------------


    
    