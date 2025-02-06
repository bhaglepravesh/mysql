use world;
create table emp_info(id int, name varchar(10),dept varchar(10),salary int);

insert into emp_info values(1,'Akash','Sales',100);
insert into emp_info values(2,'John','Sales',110);
insert into emp_info values(3,'Rohit','Sales',100);
insert into emp_info values(4,'Tom','IT',200);
insert into emp_info values(5,'Subham','IT',205);
insert into emp_info values(6,'Vabna','IT',200);
insert into emp_info values(7,'Prativa','Marketing',150);
insert into emp_info values(8,'Rahul','Marketing',155);
insert into emp_info values(9,'yash','Marketing',160);
select * from emp_info;

select e1.* from emp_info e1
join emp_info e2 on e1.dept=e2.dept and e1.salary=e2.salary and e1.id!=e2.id;

 select e1.* from emp_info e1 join (SELECT dept, salary, COUNT(*) 
FROM emp_info 
GROUP BY dept, salary 
HAVING COUNT(*) >= 2) A on A.dept=e1.dept and A.salary=e1.salary;


select id,name,dept,salary from (
select *, count(*) over(partition by dept,salary order by salary) as orders from emp_info) A where orders>=2;