use world;
create table company_revenue 
(
company varchar(100),
year int,
revenue int
);

insert into company_revenue values 
('ABC1',2000,100),('ABC1',2001,110),('ABC1',2002,120),('ABC2',2000,100),('ABC2',2001,90),('ABC2',2002,120)
,('ABC3',2000,500),('ABC3',2001,400),('ABC3',2002,600),('ABC3',2003,800);

select * from company_revenue;

with cte as (
SELECT *, 
    revenue - LAG(revenue, 1, 0) OVER(PARTITION BY company ORDER BY year) AS inc_rev
FROM company_revenue)
select company from cte group by company having sum(inc_rev)=sum(abs(inc_rev));

with cte as (
SELECT 
    *, 
    revenue - LAG(revenue, 1, 0) OVER(PARTITION BY company ORDER BY year) AS inc_rev
FROM company_revenue)
select distinct company from cte where company not in (select company from cte where inc_rev<0);


with cte as (
SELECT *, revenue - LAG(revenue, 1, 0) OVER(PARTITION BY company ORDER BY year) AS inc_rev,
    COUNT(1) OVER(PARTITION BY company) AS total_c
FROM company_revenue)
select company from cte where inc_rev>0
group by company having max(total_c)=count(1);


with cte as (
SELECT *, revenue - LAG(revenue, 1, 0) OVER(PARTITION BY company ORDER BY year) AS inc_rev
FROM company_revenue),
cte1 as(
select * from cte where inc_rev<0)
select distinct cr.company from company_revenue cr
left join cte1 c1 on cr.company=c1.company where c1.company is null;
