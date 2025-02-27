use world;
CREATE TABLE emp_salary
(
    emp_id INTEGER  NOT NULL,
    name NVARCHAR(20)  NOT NULL,
    salary NVARCHAR(30),
    dept_id INTEGER
);


INSERT INTO emp_salary
(emp_id, name, salary, dept_id)
VALUES(101, 'sohan', '3000', '11'),
(102, 'rohan', '4000', '12'),
(103, 'mohan', '5000', '13'),
(104, 'cat', '3000', '11'),
(105, 'suresh', '4000', '12'),
(109, 'mahesh', '7000', '12'),
(108, 'kamal', '8000', '11');


with cte as (
select * ,dense_rank() over(partition by dept_id order by salary) as rn from emp_salary)
 , cte1 as (select *,count(rn) over(partition by dept_id,rn) as cn from cte )
 select emp_id,name,salary,dept_id from cte1 where cn >1 ;
 
 
 select e1.* from emp_salary e1 join
(select dept_id,salary from emp_salary group by dept_id,salary having count(salary)>1) e2
on e2.dept_id=e1.dept_id and e2.salary=e1.salary order by e1.dept_id;

select e1.* from emp_salary e1 left join 
(select dept_id,salary from emp_salary group by dept_id,salary having count(salary)=1) e2
on e2.dept_id=e1.dept_id and e2.salary=e1.salary where e2.dept_id is null;