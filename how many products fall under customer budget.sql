use world;
create table products
(
product_id varchar(20) ,
cost int
);
insert into products values ('P1',200),('P2',300),('P3',500),('P4',800);

create table customer_budget
(
customer_id int,
budget int
);

insert into customer_budget values (100,400),(200,800),(300,1500);

with cte as
(select *,sum(cost) over(order by cost ) as comm_sum from products)
select c1.customer_id,c1.budget,group_concat(c2.product_id) as product from customer_budget c1 join
cte c2 on c2.comm_sum<=budget group by c1.customer_id,c1.budget;

select * from products;
select * from customer_budget;