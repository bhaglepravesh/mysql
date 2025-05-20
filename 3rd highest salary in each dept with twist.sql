use world;
CREATE TABLE emps (
  emp_id INT NULL,
  emp_name VARCHAR(50) NULL,
  salary INT NULL,
  manager_id INT NULL,
  emp_age INT NULL,
  dep_id INT NULL,
  dep_name VARCHAR(20) NULL,
  gender VARCHAR(10) NULL
);

INSERT INTO emps VALUES (1, 'Ankit', 14300, 4, 39, 100, 'Analytics', 'Female');
INSERT INTO emps VALUES (2, 'Mohit', 14000, 5, 48, 200, 'IT', 'Male');
INSERT INTO emps VALUES (3, 'Vikas', 12100, 4, 37, 100, 'Analytics', 'Female');
INSERT INTO emps VALUES (4, 'Rohit', 7260, 2, 16, 100, 'Analytics', 'Female');
INSERT INTO emps VALUES (5, 'Mudit', 15000, 6, 55, 200, 'IT', 'Male');
INSERT INTO emps VALUES (6, 'Agam', 15600, 2, 14, 200, 'IT', 'Male');
INSERT INTO emps VALUES (7, 'Sanjay', 12000, 2, 13, 200, 'IT', 'Male');
INSERT INTO emps VALUES (8, 'Ashish', 7200, 2, 12, 200, 'IT', 'Male');
INSERT INTO emps VALUES (9, 'Mukesh', 7000, 6, 51, 300, 'HR', 'Male');
INSERT INTO emps VALUES (10, 'Rakesh', 8000, 6, 50, 300, 'HR', 'Male');
INSERT INTO emps VALUES (11, 'Akhil', 4000, 1, 31, 500, 'Ops', 'Male');
select * from emps;

with cte as(
select *, row_number() over(partition by dep_id order by salary desc) as rn,
count(dep_id) over(partition by dep_id) as cn
from emps)
select * from cte where rn=3 or (rn<3 and rn=cn);