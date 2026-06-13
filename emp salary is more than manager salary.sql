use test;
create table  if not exists emp(id int, name varchar(20),salary int, manager_id int);

insert into emp values(1,"sumit",25000,3),(2,"Amit",23000,4),(3,"Amir",2700,4),(4,"Sunil",20000,5),(5,"Bachhan",38000,null);
select * from emp;

select * from emp e1
join emp e2  on e1.manager_id=e2.id  where e1.salary>e2.salary;