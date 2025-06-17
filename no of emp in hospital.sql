use test;
create table hospital ( emp_id int
, action varchar(10)
, time datetime);

INSERT INTO hospital VALUES (1, 'in', '2019-12-22 09:00:00');
INSERT INTO hospital VALUES (1, 'out', '2019-12-22 09:15:00');
INSERT INTO hospital VALUES (2, 'in', '2019-12-22 09:00:00');
INSERT INTO hospital VALUES (2, 'out', '2019-12-22 09:15:00');
INSERT INTO hospital VALUES (2, 'in', '2019-12-22 09:30:00');
INSERT INTO hospital VALUES (3, 'out', '2019-12-22 09:00:00');
INSERT INTO hospital VALUES (3, 'in', '2019-12-22 09:15:00');
INSERT INTO hospital VALUES (3, 'out', '2019-12-22 09:30:00');
INSERT INTO hospital VALUES (3, 'in', '2019-12-22 09:45:00');
INSERT INTO hospital VALUES (4, 'in', '2019-12-22 09:45:00');
INSERT INTO hospital VALUES (5, 'out', '2019-12-22 09:40:00');
select * from hospital;

with cte as(
select emp_id, max(case when action='in' then time end) as intime,
max(case when action='out' then time end) as outtime from hospital group by emp_id)
select * from cte where intime>outtime or outtime is null;
 

with intiming as(
select emp_id, max(case when action='in' then time end) as intime from hospital where action='in' group by emp_id)
,outtiming as (select emp_id, max(case when action='out' then time end) as outtime from hospital where action='out' group by emp_id)
select * from intiming i left join outtiming o on i.emp_id=o.emp_id where i.intime>o.outtime or o.outtime is null;


