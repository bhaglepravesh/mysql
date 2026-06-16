use test;
create table trees(id int,pid int);
insert into trees (id)values(1);
insert into trees values(2,1),(3,1),(4,2),(5,2);
insert into trees values(6,3);

select * from trees;

select id, case when pid is null then "root" when id not in (select pid from trees where pid is not null) then "leaf"
else "inner" end as type from trees;


select t2.id, max(case when t2.pid is null then "root" when t1.pid is null then "leaf" else "inner" end) as type
from trees t1 right join trees t2 on t1.pid=t2.id group by t2.id ;

select * from trees t1 right join trees t2 on t1.pid=t2.id