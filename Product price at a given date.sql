use test;

# default price is 10 before changeing the new price
create table if not exists prod(product_id int, new_price int, change_date date);
insert into prod values(1,20,"2019-08-14"),(2,50,"2019-08-14"),(1,30,"2019-08-15"),(1,35,"2019-08-16"),
(2,65,"2019-08-17"),(3,20,"2019-08-18");
select * from prod;

select p1.product_id,max(case when p2.product_id is not null and p1.change_date=p2.dates then p1.new_price
when p2.product_id is null then 10 end) new_price from prod p1 left join (select product_id,max(change_date) dates from prod
 where change_date<="2019-08-16" group by product_id) p2 on p1.product_id=p2.product_id group by p1.product_id;
 
 with cte as (
 select *, rank() over(partition by product_id order by change_date desc) as rnk from prod where change_date<="2019-08-16")
 select product_id,new_price from cte where rnk=1 union select product_id,10 from prod where product_id not in (
 select product_id from cte);
