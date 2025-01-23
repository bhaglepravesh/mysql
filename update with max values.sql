use test;
select * from employee;

set sql_safe_updates=0;

UPDATE employee e
JOIN (
    SELECT department, MAX(age) AS max_age
    FROM employee
    GROUP BY department
) AS subquery ON e.department = subquery.department
SET e.age = subquery.max_age;