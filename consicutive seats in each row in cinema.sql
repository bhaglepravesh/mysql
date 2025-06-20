use test;
create schema cinema;
use cinema;
-- drop table cinema_tickets;
create table cinema_tickets(seat_number varchar(100) not null, occupancy int);
insert into cinema_tickets(seat_number, occupancy) values('A1',1),('A2',1),('A3',0),('A4',0),('A5',0),('A6',0),
('A7',1),('A8',1),('A9',0),('A10',0),('B1',0),('B2',0),('B3',0),('B4',1),('B5',1),('B6',1),
('B7',1),('B8',0),('B9',0),('B10',0),('C1',0),('C2',1),('C3',0),('C4',1),('C5',1),('C6',0),
('C7',1),('C8',0),('C9',0),('C10',1);

with cte as (
select seat_number,occupancy,lead(occupancy,1) over(partition by left(seat_number,1)) as l1,
lead(occupancy,2) over(partition by left(seat_number,1)) as l2,
lead(occupancy,3) over(partition by left(seat_number,1)) as l3
from cinema_tickets),
cte2 as(
select *,lead(seat_number,3) over( partition by left(seat_number,1)) as end_seat
from cte)
select * from cte2 where occupancy+l1+l2+l3=0;

with cte as(
select seat_number,right(seat_number,length(seat_number)-1) as numbers ,
left(seat_number,1) seat_row,occupancy from cinema_tickets where occupancy=0),
cte2 as (
select *, row_number() over(partition by seat_row) as rn, 
numbers-row_number() over(partition by seat_row) as grp from cte)
select * from (select *, count(grp) over(partition by seat_row,grp) as grp_v from cte2) a
where grp_v>=4;
