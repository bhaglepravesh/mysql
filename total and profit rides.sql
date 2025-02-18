
use occupations;
create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));

INSERT INTO drivers VALUES
('dri_1', '09:00:00', '09:30:00', 'a', 'b'),
('dri_1', '09:30:00', '10:30:00', 'b', 'c'),
('dri_1', '11:00:00', '11:30:00', 'd', 'e');

INSERT INTO drivers VALUES
('dri_1', '12:00:00', '12:30:00', 'f', 'g'),
('dri_1', '13:30:00', '14:30:00', 'c', 'h');

INSERT INTO drivers VALUES
('dri_2', '12:15:00', '12:30:00', 'f', 'g'),
('dri_2', '13:30:00', '14:30:00', 'c', 'h');


select * from drivers; 

with cte as(
select *, lead(start_loc,1) over(partition by id order by start_time) next_ride from drivers)
select id, count(*),sum(case when end_loc=next_ride then 1 else 0  end ) from cte group by id;

with cte as(
select *,row_number() over(partition by id order by start_time) as rn from drivers)
select c1.id,count(*) as total_ride, count(c2.id) as profit_ride from cte c1
left join cte c2 on c1.id=c2.id and c1.start_loc=c2.end_loc  and c1.rn=c2.rn+1 group by c1.id;