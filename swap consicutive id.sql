use users;
show tables;
select * from employee;
select * from events;
select * from persons;
select * from user;
select * from virtual_user;
select id, case when id=(select max(id) from user) and id%2=1 then id
                when id%2=0 then id-1
                else id+1 end as new_id, name,gender from user order by new_id ;
               
set sql_safe_updates=0;
create table virtual_user(id int,name varchar(20),gender varchar(20));
insert into virtual_user select * from user;

update virtual_user set id=(case when id=(select max(id) from user) and id%2=1 then id
                when id%2=0 then id-1
                else id+1 end);
               
               
SELECT id, 
       CASE 
           WHEN id % 2 = 0 THEN LAG(id, 1) OVER (ORDER BY id) 
           WHEN id % 2 = 1 THEN LEAD(id, 1,id) OVER (ORDER BY id) 
       END AS new_id, 
       name, 
       gender 
FROM user 
ORDER BY new_id;
