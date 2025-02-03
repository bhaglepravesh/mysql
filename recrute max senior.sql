use test;
CREATE TABLE office(
 emp_id int,
 experience varchar(20) ,
 salary int 
) ;

INSERT INTO  office  VALUES (1, 'Junior', 10000);
INSERT INTO  office  VALUES (2, 'Junior', 15000);
INSERT INTO  office  VALUES (3, 'Junior', 40000);
INSERT INTO  office  VALUES (4, 'Senior', 16000);
INSERT INTO  office  VALUES (5, 'Senior', 20000);
INSERT INTO  office  VALUES (6, 'Senior', 50000);
select * from office;

with senior as(
select *,sum(salary) over(order by salary) as comm_senior from office where experience="senior")
, junior as (select *,sum(salary) over(order by salary) as comm_junior from office where experience="junior")
select * from senior where comm_senior<=60000
union
select * from junior where comm_junior<=60000-(select max(comm_senior) from senior where comm_senior<=60000);


