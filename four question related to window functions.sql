use world;
CREATE TABLE students(
 studentid int NULL,
 studentname varchar(255) NULL,
 subject varchar(255) NULL,
 marks int NULL,
 testid int NULL,
 testdate date NULL
);

insert into students values (2,'Max Ruin','Subject1',63,1,'2022-01-02');
insert into students values (3,'Arnold','Subject1',95,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject1',61,1,'2022-01-02');
insert into students values (5,'John Mike','Subject1',91,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject2',71,1,'2022-01-02');
insert into students values (3,'Arnold','Subject2',32,1,'2022-01-02');
insert into students values (5,'John Mike','Subject2',61,2,'2022-11-02');
insert into students values (1,'John Deo','Subject2',60,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject2',84,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject3',29,3,'2022-01-03');
insert into students values (5,'John Mike','Subject3',98,2,'2022-11-02');

select * from students;

-- 1. find the student who get marks more than the average marks in each subject

with cte as(
select *,avg(marks) over(partition by subject) as avg_marks from students)
select * from cte where marks>avg_marks;

-- Normal subquery
-- inner query can be run independently
select a.*,b.avg_marks from students a join (select subject , avg(marks) as avg_marks from students group by subject) b
on a.subject=b.subject where a.marks>b.avg_marks;


-- correlated subquery 
-- poor performance, inner query cannot be run independently, inner query is dependent on outer query
SELECT *
FROM students s1
WHERE marks > (
    SELECT AVG(marks)
    FROM students s2
    WHERE s2.subject = s1.subject
);


with b as(
select subject,avg(marks) as avg_marks from students group by subject)
select a.*,b.avg_marks from students a join b
on a.subject=b.subject where a.marks>b.avg_marks;


-- 2. write a sql query to get the percentage of students who score more than 90 in any subject among the total student
 
 select (select count(distinct studentid) from students where marks>90) /
 (select count(distinct studentid) from students)*100 as percentage;
 
 SELECT 
        COUNT(DISTINCT studentid) * 100.0 /
        (SELECT COUNT(DISTINCT studentid) FROM students) as percentage
    FROM students
    WHERE marks > 90;
 
 SELECT 
    s.*, 
    (
        SELECT 
            COUNT(DISTINCT studentid) * 100.0 /
            (SELECT COUNT(DISTINCT studentid) FROM students)
        FROM students
        WHERE marks > 90
    ) AS percentage
FROM students s
WHERE s.marks > 90;

select count( distinct case when marks>90 then studentid else null end)*100/count(distinct studentid) as percent
from students;


-- 3. write a query to get the second highest and second lowest marks in each subject

with cte as (
select *,row_number() over(partition by subject order by marks desc) as rn_hi,
         row_number() over(partition by subject order by marks asc) as rn_lo
from students)
select subject,max(case when rn_hi=2 then marks else null end) as second_highest,
               sum(case when rn_lo=2 then marks else null end) as second_lowest
from cte group by subject;
select * from students;


with cte as (
select *,dense_rank() over(partition by subject order by marks desc) as rn_hi,
         dense_rank() over(partition by subject order by marks asc) as rn_lo
from students)
select subject,sum(case when rn_hi=2 then marks else 0 end) as second_highest,
               min(case when rn_lo=2 then marks else null end) as second_lowest
from cte group by subject;


-- 4.  for each student and test identify if their marks increased or decreased from the previous test

with cte as(
select *, lag(marks,1) over(partition by studentid order by testdate) as nexts from students)
select *, case when nexts-marks>0 then "Increased" when nexts-marks<0 then "Decreased" else "Nothing" end as status
from cte;