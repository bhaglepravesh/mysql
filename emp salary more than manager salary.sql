use users;
select * from employee order by emp_id;

ALTER TABLE employee 
ADD COLUMN (emp_id INT, manager_id INT);

SET SQL_SAFE_UPDATES = 0;

UPDATE employee 
SET emp_id = 1, manager_id = 3 
WHERE emp_name = "siva";
update employee set emp_id=3 , manager_id=5 where emp_name="ravi";
update employee set emp_id=2, manager_id=4 where emp_name="pramod";
update employee set emp_id=4 , manager_id=5 where emp_name="sai";
update employee set emp_id=5 , manager_id=1 where emp_name="anna";


select * from employee e join employee m
on e.manager_id=m.emp_id and e.salary>m.salary ;

