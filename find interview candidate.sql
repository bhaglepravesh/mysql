use test;
create table if not exists contests(contestid int,gold int,silver int,bronze int);
insert into contests values(190,1,5,2),(191,2,3,5),(192,5,2,3),(193,1,3,5),(194,4,5,2),(195,4,2,1),(196,1,5,2);
select * from contests;
create table if not exists users(id int, mail varchar(20),name varchar(20));
insert into users values(1,"sarah@gmail.com","Sarah"),(2,"bob@gmail.com","Bob"),(3,"alice@gmail.com","Alice"),
(4,"hery@gmail.com","Hery"),(5,"quarz@gmail.com","Quarz");
select * from users;





WITH medals AS (
    SELECT contestid, gold   AS user_id FROM contests
    UNION ALL
    SELECT contestid, silver AS user_id FROM contests
    UNION ALL
    SELECT contestid, bronze AS user_id FROM contests
),
grp_data AS (
    SELECT
        user_id,
        contestid,
        contestid - ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY contestid
        ) AS grp
    FROM medals
),
consecutive_wins AS (
    SELECT user_id
    FROM grp_data
    GROUP BY user_id, grp
    HAVING COUNT(*) >= 3
)
SELECT DISTINCT u.name, u.mail
FROM users u
JOIN consecutive_wins c
    ON u.id = c.user_id
union 
select name, mail from users where id in (select gold from contests group by gold having count(contestid)>=3)  ;













SELECT DISTINCT u.name, u.mail
FROM users u
WHERE EXISTS (
    SELECT 1
    FROM contests c1
    JOIN contests c2
        ON c2.contestid = c1.contestid + 1
    JOIN contests c3
        ON c3.contestid = c1.contestid + 2
    WHERE u.id IN (c1.gold,c1.silver,c1.bronze)
      AND u.id IN (c2.gold,c2.silver,c2.bronze)
      AND u.id IN (c3.gold,c3.silver,c3.bronze)
)
union 
select name, mail from users where id in (select gold from contests group by gold having count(contestid)>=3);
