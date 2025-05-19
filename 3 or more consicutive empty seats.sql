use users;
create table bms(id int,is_empty varchar(10));
insert into bms values
(1,'N')
,(2,'Y')
,(3,'N')
,(4,'Y')
,(5,'Y')
,(6,'Y')
,(7,'N')
,(8,'Y')
,(9,'Y')
,(10,'Y')
,(11,'Y')
,(12,'N')
,(13,'Y')
,(14,'Y');
select * from bms;



with cte as (
select id,lag(is_empty,2) over() as prev2,lag(is_empty,1) over() as prev1 , is_empty, lead(is_empty,1) over() as
next1,lead(is_empty,2) over() as next2 from bms)
select id from cte where  (prev2="Y" and Prev1="Y" and is_empty="Y")  or (prev1="Y" and is_empty="Y" and next1="Y") 
or (is_empty="Y" and next1="Y" and next2="Y");



select id from (select id,is_empty,
sum(case when is_empty="Y" then 1 else 0 end ) over(order by id rows between 2 preceding and current row) as prevs,
sum(case when is_empty="Y" then 1 else 0 end ) over(order by id rows between 1 preceding and 1 following) as curr,
sum(case when is_empty="Y" then 1 else 0 end ) over(order by id rows between current row and 2 following) as nexts
from bms) a where prevs=3 or curr=3 or nexts=3;




with cte as(
select id,is_empty,row_number() over(order by id) as rn,
id-row_number() over(order by id) as grp
 from bms where is_empty="Y"), cte2 as(
 select id,count(grp) over(partition by grp) as ct  from cte )
 select id,ct from cte2 where ct>2;

