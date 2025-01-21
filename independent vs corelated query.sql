use test;
select * from employee;

-- independent query can run independently
-- independent quey runs only once

-- Question employees whose salary>avg salary of their department

select e.* from employee e join (select department, avg(salary) as avg_salary from employee group by department) d
on e.department=d.department where e.salary>d.avg_salary;

-- corelated query cannot run independent query
-- correlated query runs row no of times in one execution

select name, department, salary from employee e 
where salary>(select avg(salary) from employee d where e.department=d.department);