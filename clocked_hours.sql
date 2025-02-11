use users;
-- drop table clocked_hours;
create table clocked_hours(

empd_id int,

swipe varchar(30),

flag char

);

insert into clocked_hours values

(11114,'08:30:00​','I'),

(11114,'10:30:00​','O'),

(11114,'11:30:00​','I'),

(11114,'15:30:00​','O'),

(11115,'09:30​:00','I'),

(11115,'17:30:00​','O');
select * from clocked_hours;

