use users;

create table sales (
product_id int,
period_start date,
period_end date,
average_daily_sales int
);

insert into sales values(1,'2019-01-25','2019-02-28',100),(2,'2018-12-01','2020-01-01',10),(3,'2019-12-01','2020-01-31',1);
select * from sales;

WITH RECURSIVE cte AS (
    -- Anchor member: Gets the initial rows from sales
    SELECT product_id, period_start AS dates, period_end AS max_date, average_daily_sales 
    FROM sales
    UNION ALL
    -- Recursive member: Generates the next date for each product_id
    SELECT product_id, DATE_ADD(dates, INTERVAL 1 DAY), max_date, average_daily_sales 
    FROM cte
    WHERE DATE_ADD(dates, INTERVAL 1 DAY) <= max_date
)
-- Aggregation query
SELECT product_id, YEAR(dates) AS year, SUM(average_daily_sales) AS total_sales
FROM cte
GROUP BY product_id, YEAR(dates)
ORDER BY product_id, year;
