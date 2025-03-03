use users;
create table product_master 
(
product_id int,
product_name varchar(100)
);

insert into product_master values(100,'iphone5'),(200,'hp laptop'),(300,'dell laptop');

create table orders_usa
(
order_id int,
product_id int,
sales int
);
create table orders_europe
(
order_id int,
product_id int,
sales int
);

create table orders_india
(
order_id int,
product_id int,
sales int
);
-- delete from orders_india
insert into orders_usa values (1,100,500);
insert into orders_usa values (7,100,500);
insert into orders_europe values (2,200,600);
insert into orders_india values (3,100,500);
insert into orders_india values (4,200,600);
insert into orders_india values (8,100,500);

select * from orders_usa;
select * from orders_europe;
select * from orders_india;

-- output
--  product_id usa_sales europe_sales india_sales
--    100        1000      null         1000
--    200        null       600          600


-- ms sql solution
-- select coalesce(u.product_id,e.product_id) as product_id , u.sales as usa_sales,e.sales as europe_sales,
-- i.sales as india_sales from (select product_id,sum(sales) as sales from orders_usa group by product_id) u 
-- full outer join ( select product_id,sum(sales) as sales from orders_europe group by product_id) e on e.product_id=u.product_id
-- full outer join ( select product_id,sum(sales) as sales from orders_india group by product_id) i on coalesce(u.product_id,e.product_id)=i.product_id;

SELECT 
    COALESCE(u.product_id, e.product_id, i.product_id) AS product_id,
    u.sales AS usa_sales,
    e.sales AS europe_sales,
    i.sales AS india_sales
FROM 
    ((SELECT product_id, SUM(sales) AS sales FROM orders_usa GROUP BY product_id) u
    LEFT JOIN (SELECT product_id, SUM(sales) AS sales FROM orders_europe GROUP BY product_id) e 
    ON u.product_id = e.product_id)
    
    LEFT JOIN (SELECT product_id, SUM(sales) AS sales FROM orders_india GROUP BY product_id) i 
    ON COALESCE(u.product_id, e.product_id) = i.product_id

UNION

SELECT 
    COALESCE(u.product_id, e.product_id, i.product_id) AS product_id,
    u.sales AS usa_sales,
    e.sales AS europe_sales,
    i.sales AS india_sales
FROM 
    ((SELECT product_id, SUM(sales) AS sales FROM orders_usa GROUP BY product_id) u
    RIGHT JOIN (SELECT product_id, SUM(sales) AS sales FROM orders_europe GROUP BY product_id) e 
    ON u.product_id = e.product_id)
    
    LEFT JOIN (SELECT product_id, SUM(sales) AS sales FROM orders_india GROUP BY product_id) i 
    ON COALESCE(u.product_id, e.product_id) = i.product_id;



select pm.product_id,u.sales as usa_sales,e.sales as europe_sales,i.sales as india_sales from product_master pm
left JOIN (SELECT product_id, SUM(sales) AS sales FROM orders_usa GROUP BY product_id) u on pm.product_id=u.product_id
left JOIN (SELECT product_id, SUM(sales) AS sales FROM orders_europe GROUP BY product_id) e on pm.product_id=e.product_id
left JOIN (SELECT product_id, SUM(sales) AS sales FROM orders_india GROUP BY product_id) i on pm.product_id=i.product_id
where not (u.sales is null and e.sales is null and i.sales is null);


select pm.product_id,u.sales as usa_sales,e.sales as europe_sales,i.sales as india_sales from (
select product_id from orders_usa
union select product_id from orders_europe
union select product_id from orders_india ) pm 
left JOIN (SELECT product_id, SUM(sales) AS sales FROM orders_usa GROUP BY product_id) u on pm.product_id=u.product_id
left JOIN (SELECT product_id, SUM(sales) AS sales FROM orders_europe GROUP BY product_id) e on pm.product_id=e.product_id
left JOIN (SELECT product_id, SUM(sales) AS sales FROM orders_india GROUP BY product_id) i on pm.product_id=i.product_id;

with cte as (
select product_id, sales as usa_sales,null as europe_sales,null as india_sales from orders_usa
union all
select product_id, null as usa_sales,sales as europe_sales,null as india_sales from orders_europe
union all
select product_id, null as usa_sales,null as europe_sales,sales as india_sales from orders_india)
select product_id,sum(usa_sales) usa_sales,sum(europe_sales) europe_sales,sum(india_sales) india_sales
from cte group by product_id order by product_id;

 