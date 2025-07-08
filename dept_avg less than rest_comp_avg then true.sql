
use world;
-- drop table if exists emp;
create table emp(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);

insert into emp 
values
(1, 'Ankit', 100,10000, 4, 39);
insert into emp
values (2, 'Mohit', 100, 15000, 5, 48);
insert into emp
values (3, 'Vikas', 100, 10000,4,37);
insert into emp
values (4, 'Rohit', 100, 5000, 2, 16);
insert into emp
values (5, 'Mudit', 200, 12000, 6,55);
insert into emp
values (6, 'Agam', 200, 12000,2, 14);
insert into emp
values (7, 'Sanjay', 200, 9000, 2,13);
insert into emp
values (8, 'Ashish', 200,5000,2,12);
insert into emp
values (9, 'Mukesh',300,6000,6,51);
insert into emp
values (10, 'Rakesh',300,7000,6,50);
select * from emp;

-- department avg_salary is less than comp_avg_salary except that dept in comp_avg_salary

with cte as(
select department_id as dept_id,count(emp_id) as no_emp, avg(salary) as avg_sal,sum(salary) as total_dept_sal
 from emp group by department_id)
, cte1 as (select c1.dept_id, c1.avg_sal,sum(c2.total_dept_sal)/sum(c2.no_emp) as cmp_avg_sal from cte c1 
join cte c2 on c1.dept_id !=c2.dept_id
group by c1.dept_id,c1.avg_sal)
select * from cte1 where avg_sal<cmp_avg_sal;


select * from emp;

SELECT department_id, AVG(salary) AS dept_avg_salary
FROM emp e1
GROUP BY department_id
HAVING AVG(salary) < (
    SELECT SUM(salary) / COUNT(emp_id)
    FROM emp e2
    WHERE e2.department_id != e1.department_id
);
