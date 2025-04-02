use test;
show tables;

create table salary (id int,name varchar(20), gender varchar(20),salary int);
insert into salary values(1,"A","m",20000),(2,"B","f",23000),(3,"C","m",22000),(4,"D","f",21000);

set sql_safe_updates=0;
update salary set gender= case when gender="m" then "f" else "m" end;

select * from salary;
update salary set gender= if(gender="m","f","m");

select * from salary;