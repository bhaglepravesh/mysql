use test;
drop table if exists emps;
create table emps(empid int,exp varchar(20),salary int);
-- insert into emps values(1,"junior",10000),(9,"junior",10000),(2,"Senior",20000),(11,"Senior",20000),(13,"Senior",50000),
-- (4,"junior",40000);
-- insert into emps values(5,"Senior",20000);
insert into emps values(1,"junior",75000),(9,"junior",75000),(2,"Senior",80000),(11,"Senior",80000),(13,"Senior",80000),
(4,"junior",78000);
select * from emps;

with cte1 as (
select *,dense_rank() over(partition by exp) as rnk, sum(salary) over (partition by exp order by salary rows between unbounded preceding and current row)
 as comm_sal from emps)
 select "Junior" as exp,count(*) as cnt from cte1 where comm_sal<=  ( 80000- coalesce((select max(comm_sal) from cte1 where comm_sal<=80000 and exp="Senior"),0)) and exp="junior"
 union
 select "Senior" as exp ,count(*) from cte1 where comm_sal<=80000 and exp="Senior";
 

