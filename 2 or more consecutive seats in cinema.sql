use sys;
CREATE TABLE cinema (
    seat_id INT PRIMARY KEY,
    free int
);
-- delete from cinema;-- 
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 0);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, 0);
INSERT INTO cinema (seat_id, free) VALUES (7, 1);
INSERT INTO cinema (seat_id, free) VALUES (8, 1);
INSERT INTO cinema (seat_id, free) VALUES (9, 0);
INSERT INTO cinema (seat_id, free) VALUES (10, 1);
INSERT INTO cinema (seat_id, free) VALUES (11, 0);
INSERT INTO cinema (seat_id, free) VALUES (12, 1);
INSERT INTO cinema (seat_id, free) VALUES (13, 0);
INSERT INTO cinema (seat_id, free) VALUES (14, 1);
INSERT INTO cinema (seat_id, free) VALUES (15, 1);
INSERT INTO cinema (seat_id, free) VALUES (16, 0);
INSERT INTO cinema (seat_id, free) VALUES (17, 1);
INSERT INTO cinema (seat_id, free) VALUES (18, 1);
INSERT INTO cinema (seat_id, free) VALUES (19, 1);
INSERT INTO cinema (seat_id, free) VALUES (20, 1);
select * from cinema;

with cte as(
select *,row_number() over(order by seat_id) as rn,
seat_id-row_number() over(order by seat_id) as grp from cinema where free=1), cte1 as(
select *,count(grp) over(partition by grp) as grp_cnt from cte)
select * from cte1 where grp_cnt>1;

with cte as(
select seat_id, lag(free)over() as prevs,free,lead(free) over() as nexts from cinema)
select seat_id,free from cte where (prevs=1 and free=1) or (free=1 and nexts=1);

with cte as(
select seat_id,free,sum(free) over(order by seat_id rows between 1 preceding and current row) as firsts,
sum(free) over(order by seat_id rows between current row and 1 following) as seconds from cinema)
select seat_id,free from cte where firsts=2 or seconds=2;