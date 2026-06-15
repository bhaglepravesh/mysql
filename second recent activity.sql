use test;
create table useractivity(username varchar(20),activity varchar(20),startdate date,enddate date);
insert into useractivity values("alice","travel","2020-02-12","2020-02-20"),("alice","dancing","2020-02-21","2020-02-23"),
("alice","travel","2020-02-24","2020-02-28"),("bob","travel","2020-02-11","2020-02-18");

select * from useractivity;

with cte as (
select distinct * from useractivity),
cte2 as (
select * , row_number() over(partition by username order by startdate desc) as rnk,
 count(activity) over(partition by username) as activity_cnt from cte)
 select username,activity from cte2 where rnk=2 or activity_cnt=1;