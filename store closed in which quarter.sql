use world;
CREATE TABLE STORES (
Store varchar(10),
Quarter varchar(10),
Amount int);

INSERT INTO STORES (Store, Quarter, Amount)
VALUES ('S1', 'Q1', 200),
('S1', 'Q2', 300),
('S1', 'Q4', 400),
('S2', 'Q1', 500),
('S2', 'Q3', 600),
('S2', 'Q4', 700),
('S3', 'Q1', 800),
('S3', 'Q2', 750),
('S3', 'Q3', 900);
select * from stores;

SELECT store, 
       CONCAT("Q", CAST(10 - SUM(CAST(RIGHT(quarter, 1) AS UNSIGNED)) AS CHAR)) AS q_no
FROM stores 
GROUP BY store;


with cte as(
select distinct s1.store,c1.quarter from stores s1, stores c1)
select c.* from cte c left join stores s on c.store=s.store and c.quarter=s.quarter
where s.store is null;
;

with recursive cte as (
select distinct store, 1 as q_no from stores
union all
select store, q_no+1 from cte where q_no<4) , cte1 as (
select store, concat("Q",q_no) as q_no from cte)
select c.* from cte1 c left join stores s on c.store=s.store and c.q_no=s.quarter
where s.store is null;