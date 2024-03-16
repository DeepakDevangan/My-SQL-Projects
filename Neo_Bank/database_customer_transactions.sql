/* Customer Transactions */

use neo_bank;

# 1. What is the unique count and total amount for each transactions type?
select
	txn_type,
    count(*) as unique_count,
    sum(txn_amount) as total_amount
from
	customer_transactions
group by txn_type;


# 2. What is the average total historical deposit counts and amounts for all customers?
with historical_deposit as (
		select
			customer_id,
			txn_type,
			count(*) as counts,
			avg(txn_amount) as amounts
		from
			customer_transactions
		where txn_type = 'deposit'
		group by customer_id, txn_type)
select
	round(avg(counts),2) as avg_count,
    round(avg(amounts),2) as avg_amount
from
	historical_deposit;


# 3. For each month - how many Data Bank customers make more than 1 deposits and either 1 purchase or 1 withdrawal in a single month?
with monthly_txn as (
select
	customer_id,
	monthname(txn_date) as months,
    sum(case when txn_type = 'deposit' then 0 else 1 end) as deposits,
    sum(case when txn_type = 'purchase' then 0 else 1 end) as purchases,
    sum(case when txn_type = 'withdrawal' then 1 else 0 end) as withdrawal
from customer_transactions
group by customer_id, months)
select
	months,
    count(distinct customer_id) as customer_cnt
from monthly_txn
where deposits >= 2 and (purchases > 1 or withdrawal > 1)
group by months
order by months;

# 4. What is the closing balance for each customer at the end of the month?
with closing as (
	select
		customer_id,
        txn_date,
        lastday(txn_date) as month_ending,
        txn_amount,
        (case
        when txn_type = 'withdrawl' then (-txn_amount)
        when txn_type = 'purchase' then (-txn_amount)
        else txn_amount
        end) as txn_balance
	from
		customer_transactions
	order by customer_id, monthname(txn_date)) 
select
	customer_id,
    ending_month,
    coalesce(txn_balance, 0) as monthly_change,
	sum(txn_balance) over 
      (partition by customer_id order by ending_month
      rows between unbounded preceding and current row) as closing_balance
from closing
group by customer_id, txn_date;	
