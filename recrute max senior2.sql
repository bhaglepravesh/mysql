use test;
Create table candidates(
id int primary key,
positions varchar(10) not null,
salary int not null);

-- test case 1:
insert into candidates values(1,'junior',5000);
insert into candidates values(2,'junior',7000);
insert into candidates values(3,'junior',7000);
insert into candidates values(4,'senior',10000);
insert into candidates values(5,'senior',30000);
insert into candidates values(6,'senior',20000);
select * from candidates;

with cte as
(select *,sum(salary) over(partition by positions order by salary,id) running_sum from candidates)
, cte1 as (select *,count(*) over() as seniors from cte where positions="senior" and running_sum<=50000)
, cte2 as (select *,count(*) over() as juniors from cte where positions="junior" and running_sum<=50000-( select max(running_sum) from cte1 ) )
select  seniors,juniors 
from cte1, cte2 group by cte1.positions,cte2.positions;


WITH cte AS (
    SELECT *, SUM(salary) OVER(PARTITION BY positions ORDER BY salary, id) running_sum 
    FROM candidates
), 
cte1 AS (
    SELECT * FROM cte 
    WHERE positions = 'senior' AND running_sum <= 50000
), 
cte2 AS (
    SELECT * FROM cte 
    WHERE positions = 'junior' AND running_sum <= 50000 - (SELECT MAX(running_sum) FROM cte1)
) 
SELECT 
    (SELECT COUNT(*) FROM cte1) AS seniors, 
    (SELECT COUNT(*) FROM cte2) AS juniors;



-- test case 2:
set sql_safe_updates=0;
delete from candidates;
insert into candidates values(20,'junior',10000);
insert into candidates values(30,'senior',15000);
insert into candidates values(40,'senior',30000);

-- test case 3:
set sql_safe_updates=0;
delete from candidates;
insert into candidates values(1,'junior',15000);
insert into candidates values(2,'junior',15000);
insert into candidates values(3,'junior',20000);
insert into candidates values(4,'senior',60000);

with cte as
(select *,sum(salary) over(partition by positions order by salary,id) running_sum from candidates)
, cte1 as (select count(*) as seniors, coalesce(sum(salary),0) as s_salary from cte where positions="senior" and running_sum<=50000)
, cte2 as (select count(*) as juniors from cte where positions="junior" and running_sum<=50000-( select s_salary from cte1 ) )
select  seniors,juniors 
from cte1, cte2;

-- test case 4:

insert into candidates values(10,'junior',10000);
insert into candidates values(40,'junior',10000);
insert into candidates values(20,'senior',15000);
insert into candidates values(30,'senior',30000);
insert into candidates values(50,'senior',15000);