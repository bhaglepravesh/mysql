use test;

create table input (
id int,
formula varchar(10),
value int
);
insert into input values (1,'1+4',10),(2,'2+1',5),(3,'3-2',40),(4,'4-1',20);
select * from input;

with cte as (
select * , left(formula,1) as firsts, substring(formula,2,1) as operator , right(formula,1) as seconds
from input)
select e.id,e.formula,e.value,
case when operator="+" then i.value+e.value else e.value-i.value end result
 from input i  join cte e on i.id=cast(e.seconds as unsigned) ;