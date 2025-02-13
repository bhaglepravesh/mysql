use users;
select * from superstore_orders;

with cte as (select customer_id,customer_name,product_id,sales ,
sum(sales) over(order by sales desc rows  between unbounded preceding and 0 following ) as running_sum
from superstore_orders )
select count(*) from cte where running_sum<=(select sum(sales) from superstore_orders)*0.8
;
