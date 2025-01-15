-- events with 3 or more consicutive years

use users;
create table events(id int,year int);
insert into events(id,year) values(1,2018),(1,2019),(1,2020),(2,2022),(2,2021),(3,2019),(3,2021),(3,2022);
select * from events;

with cte as (select id, year, year-row_number() over(partition by id order by year) as grp from events)
select id,min(year),max(year) from cte group by id,grp having count(grp)>=3;


 select id from (select *,year-lag(year,1,year-1) over(partition by id order by year) as grp from events) t
 group by id,grp having count(grp)>=3;
 

