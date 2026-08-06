
# Gamin activity 5 : The install date is the first login da of the player, write a solution to report for each install date, the number of
# date, the number of players that installed the game on that day and the day on renetaion
use test;
Create table If Not Exists Activity (player_id int, device_id int, event_date date, games_played int);
Truncate table Activity;
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-01', '5');
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-02', '6');
insert into Activity (player_id, device_id, event_date, games_played) values ('2', '3', '2017-06-25', '1');
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '1', '2016-03-01', '0');
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '4', '2018-07-03', '5');
select * from activity;

with cte as(
select *, rank() over(partition by player_id order by event_date) as rnk, 
lead(event_date) over(partition by player_id order by event_date) as next_login from activity)
select event_date as install_dt,count(*) as installs, 
round(sum(case when datediff(next_login , event_date) =1 then 1 else 0 end)/count(*),2) as day1_retention
from cte where rnk=1 group by event_date;
