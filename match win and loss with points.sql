use test;
create table icc_world_cup
(
match_no int,
team_1 Varchar(20),
team_2 Varchar(20),
winner Varchar(20)
);
INSERT INTO icc_world_cup values(1,'ENG','NZ','NZ');
INSERT INTO icc_world_cup values(2,'PAK','NED','PAK');
INSERT INTO icc_world_cup values(3,'AFG','BAN','BAN');
INSERT INTO icc_world_cup values(4,'SA','SL','SA');
INSERT INTO icc_world_cup values(5,'AUS','IND','IND');
INSERT INTO icc_world_cup values(6,'NZ','NED','NZ');
INSERT INTO icc_world_cup values(7,'ENG','BAN','ENG');
INSERT INTO icc_world_cup values(8,'SL','PAK','PAK');
INSERT INTO icc_world_cup values(9,'AFG','IND','IND');
INSERT INTO icc_world_cup values(10,'SA','AUS','SA');
INSERT INTO icc_world_cup values(11,'BAN','NZ','NZ');
INSERT INTO icc_world_cup values(12,'PAK','IND','IND');
INSERT INTO icc_world_cup values(12,'SA','IND','DRAW');
set sql_safe_updates=0;
delete from icc_world_cup where winner="DRAW";
select * from icc_world_cup;

with cte as (
select team , sum(matches_played) matches_played from (
select team_1 team,count(team_1) matches_played from icc_world_cup group by team_1
union all
select team_2 team,count(team_2) matches_played from icc_world_cup group by team_2) A group by team)
select c.team,c.matches_played,ifnull(A.no_win,0) no_win ,c.matches_played-ifnull(A.no_win,0) matches_losses from cte c
left join
(select winner, count(winner) no_win from icc_world_cup group by winner) A
on A.winner=c.team;


select team,sum(matches_played),sum(no_win),sum(matches_played)-sum(no_win) as loses,2*sum(no_win) total_points from 
(select team_1 team,count(team_1) matches_played ,
sum(case when team_1=winner then 1 else 0 end) no_win
from icc_world_cup group by team_1
union all
select team_2 team,count(team_2) matches_played,
sum(case when team_2=winner then 1 else 0 end) no_win
 from icc_world_cup group by team_2) p group by team