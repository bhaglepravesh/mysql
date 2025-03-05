use world;
create table lift(id int,capacity int);
insert into  lift values(1,300),(2,350);
create table lift_passengers(name varchar(20),weight int ,lift_id int);
insert into lift_passengers values("rahul",85,1),("adarsh",73,1),("Ritik",95,1),("Dheeraj",80,1),("vimal",83,2),
							("neha",77,2),("priti",73,2),("Himansi",85,2);

select * from lift;
select * from lift_passengers;

with cte as (
select *,sum(p.weight) over(partition by l.id order by p.weight) as comm_weight
from lift l join lift_passengers p on l.id=p.lift_id)
select id,group_concat(name separator ",") as passengers from cte where comm_weight<=capacity group by id;