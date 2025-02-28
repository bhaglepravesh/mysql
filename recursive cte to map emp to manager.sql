use world;
create table job_positions (id  int, title varchar(100),groupo varchar(10),levels varchar(10),    payscale int, 
totalpost int );
 insert into job_positions values (1, 'General manager', 'A', 'l-15', 10000, 1); 
insert into job_positions values (2, 'Manager', 'B', 'l-14', 9000, 5); 
insert into job_positions values (3, 'Asst. Manager', 'C', 'l-13', 8000, 10);  

  create table job_employees ( id  int,  name   varchar(100),  position_id  int  );  
  insert into job_employees values (1, 'John Smith', 1); 
insert into job_employees values (2, 'Jane Doe', 2);
 insert into job_employees values (3, 'Michael Brown', 2);
 insert into job_employees values (4, 'Emily Johnson', 2); 
insert into job_employees values (5, 'William Lee', 3); 
insert into job_employees values (6, 'Jessica Clark', 3); 
insert into job_employees values (7, 'Christopher Harris', 3);
 insert into job_employees values (8, 'Olivia Wilson', 3);
 insert into job_employees values (9, 'Daniel Martinez', 3);
 insert into job_employees values (10, 'Sophia Miller', 3);
 
 select * from job_positions;
 select * from job_employees;
 
 with recursive cte as (
 select id ,title,groupo,levels ,payscale,totalpost , 1 as rn from job_positions
 union 
  select id ,title,groupo,levels ,payscale,totalpost , rn+1 as rn from cte where rn+1<=totalpost
  )
  select c.* ,ifnull(e.name,"vacant") name from cte c
  left join 
  (select *,row_number() over(partition by position_id order by id) as rn from job_employees) e 
  on c.id=e.position_id and c.rn=e.rn order by c.id;
  ;