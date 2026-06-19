use test;
create table point2d(x int, y int);
insert into point2d values(-1,-1),(0,0),(-1,-2);
select * from point2d;
with cte as (
select *, row_number() over() as rnk from point2d)
select round(min(sqrt(pow((p1.x-p2.x),2)+pow((p1.y-p2.y),2))),2) as shortest 
from cte p1 join cte p2 on p1.rnk < p2.rnk;