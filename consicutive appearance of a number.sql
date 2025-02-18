use users;
create table logs(id int, num int);

insert into logs values(1,1);
insert into logs values(2,1);
insert into logs values(3,2);
insert into logs values(4,2);
insert into logs values(5,2);
insert into logs values(6,1);
insert into logs values(7,3);
insert into logs values(8,4);
insert into logs values(9,4);
select * from logs;

with cte as(
select *, row_number() over(partition by num order by id) as rn,
id-row_number() over(partition by num order by id) as grp
 from logs)
select num , count(grp) from cte group by num,grp having count(grp)>=3;