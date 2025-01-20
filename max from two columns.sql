use users;

select * from employee;

select emp_name, greatest(emp_id,manager_id) as max from employee;

select emp_name,
case when emp_id>=manager_id then emp_id else manager_id end as max
from employee;