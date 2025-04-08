-- rollup, cube and grouping set in MYSQL


-- In MySQL, ROLLUP, CUBE, and GROUPING SETS are extensions to the GROUP BY clause used to 
-- perform advanced grouping and generate subtotals and grand totals in a single query. 
-- They are especially useful in reporting and analytics.

These features are available from MySQL 8.0.1 and later.

1. ROLLUP
ROLLUP adds subtotals and a grand total to the result set.


SELECT department, job_title, SUM(salary)
FROM employees
GROUP BY department, job_title WITH ROLLUP;
Output:
This query returns:

Totals for each job_title within a department.

A subtotal for each department.

A grand total at the end.

2. CUBE
CUBE generates all combinations of groupings, including subtotals across all levels.

-- MySQL doesn't support CUBE natively, but you can simulate it using GROUPING SETS.

3. GROUPING SETS
GROUPING SETS allows you to define specific groupings, giving you more control than ROLLUP.

Example:

SELECT department, job_title, SUM(salary)
FROM employees
GROUP BY GROUPING SETS (
  (department, job_title),
  (department),
  ()
);

-- This produces:

-- Regular grouping by department and job_title.

-- Subtotals per department.

-- Grand total (with both department and job_title as NULL).

Bonus: GROUPING() function
Use GROUPING(column) to determine if a NULL in the result is a real NULL or a subtotal/grand total.

Example:

SELECT
  department,
  job_title,
  GROUPING(department) AS is_dept_total,
  GROUPING(job_title) AS is_job_total,
  SUM(salary)
FROM employees
GROUP BY department, job_title WITH ROLLUP;
-- Let me know if you want examples with sample data or to simulate a CUBE in MySQL!






-- ✅ Step 1: Create a Table and Insert Sample Data
-- Table: employees

CREATE TABLE employees (
    id INT PRIMARY KEY,
    department VARCHAR(50),
    job_title VARCHAR(50),
    salary DECIMAL(10, 2)
);
-- Sample Data:

INSERT INTO employees (id, department, job_title, salary) VALUES
(1, 'Sales', 'Manager', 70000),
(2, 'Sales', 'Executive', 50000),
(3, 'HR', 'Manager', 65000),
(4, 'HR', 'Executive', 45000),
(5, 'IT', 'Manager', 80000),
(6, 'IT', 'Executive', 60000);

-- Now the table looks like:

id	department	job_title	salary
1	Sales	Manager	70000
2	Sales	Executive	50000
3	HR	Manager	65000
4	HR	Executive	45000
5	IT	Manager	80000
6	IT	Executive	60000

-- ✅ Step 2: Use GROUP BY with ROLLUP

SELECT department, job_title, SUM(salary) AS total_salary
FROM employees
GROUP BY department, job_title WITH ROLLUP;

-- 🔍 What this does:
Groups by both department and job_title

Adds subtotals for each department

Adds a grand total at the end

🧾 Output:
department	job_title	total_salary
HR	Executive	45000
HR	Manager	65000
HR	NULL	110000 ← subtotal for HR
IT	Executive	60000
IT	Manager	80000
IT	NULL	140000 ← subtotal for IT
Sales	Executive	50000
Sales	Manager	70000
Sales	NULL	120000 ← subtotal for Sales
NULL	NULL	370000 ← grand total


-- ✅ Step 3: Use GROUPING SETS

SELECT department, job_title, SUM(salary) AS total_salary
FROM employees
GROUP BY GROUPING SETS (
    (department, job_title),
    (department),
    ()
);
--  What this does:
-- Returns:

Regular grouped rows

Subtotals for each department

One grand total

🧾 Output:
department	job_title	total_salary
HR	Executive	45000
HR	Manager	65000
IT	Executive	60000
IT	Manager	80000
Sales	Executive	50000
Sales	Manager	70000
HR	NULL	110000
IT	NULL	140000
Sales	NULL	120000
NULL	NULL	370000
🆚 Notice: This output is similar to ROLLUP, but with more control — for example, you can remove unwanted subtotal levels or add others.

