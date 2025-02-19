use test;
create table employees 
(
emp_name varchar(10),
dep_id int,
salary int
);
-- delete from employees;
insert into employees values 
('Siva',1,30000),('Ravi',2,40000),('Prasad',1,50000),('Sai',2,20000);
select * from employees;

with cte as
(select dep_id, max(salary) as max_salary, min(salary) as min_salary from employees group by dep_id)
select c.dep_id,
max(case when e.salary=c.max_salary then emp_name end )as max_sal_emp,
max(case when e.salary=c.min_salary then emp_name end) as min_sal_emp
from cte  c inner join employees e on c.dep_id=e.dep_id group by e.dep_id;

with cte as (
select *, row_number() over(partition by dep_id order by salary desc) as max_sal,
          row_number() over(partition by dep_id order by salary ) as min_sal
          from employees)
select dep_id, min(case when max_sal=1 then emp_name end) as max_sal_emp,
                min(case when min_sal=1 then emp_name end) as min_sal_emp
                from cte group by dep_id;