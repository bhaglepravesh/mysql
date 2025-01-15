create database if not exists flight_match;
use flight_match;

create table flight(user_id int,sources varchar(20),destination varchar(20));
insert into flight values(1,"delhi","Kanpur"),(1,"Kanpur","lucknow"),(1,"lucknow","bengaluru"),(2,"mumbai","kolkata"),
(2,"kolkata","chennai"),(3,"hyderabad","madurai");





create table matchs(team1 varchar(20),team2 varchar(20),winner varchar(20));
insert into matchs values("india","shri lanka","india"),("africa","austrelia","austrelia"),
("england","pakistan","pakistan"),("pakistan","india","india"),("india","newziland","newziland"),
("afganistan","pakistan","afganistan");

select * from flight;


 select t.u1,t.s1,p.d1 from(select f1.user_id as u1,f1.sources as s1 from flight f1
left join flight f2 on f1.user_id=f2.user_id
and f1.sources=f2.destination where f2.sources is null ) t
join 
(select f2.user_id as u2,f2.destination as d1 from flight f1
right join flight f2 on f1.user_id=f2.user_id
and f1.sources=f2.destination where f1.destination is null ) p on p.u2=t.u1;







select * from matchs;

SELECT team_name, 
       COUNT(*) AS matches_played, 
       SUM(CASE WHEN team_name = winner THEN 1 ELSE 0 END) AS matches_won
FROM (
    SELECT team1 AS team_name, winner FROM matchs
    UNION ALL
    SELECT team2, winner FROM matchs
) AS combined
GROUP BY team_name;

SELECT team_name,
       COUNT(*) AS matches_played,
       COUNT(CASE WHEN winner = team_name THEN 1 ELSE NULL END) AS matches_won
FROM (
    SELECT team1 AS team_name, winner FROM matchs
    UNION ALL
    SELECT team2, winner FROM matchs
) AS combined
GROUP BY team_name;


