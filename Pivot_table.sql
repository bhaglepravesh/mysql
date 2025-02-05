use test;
create table players_location
(
name varchar(20),
city varchar(20)
);
-- delete from players_location;
insert into players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');

select * from players_location;

select player_group, max(case when city="Bangalore" then name end) as Banglore,
	max(case when city="mumbai" then name end) as Mumbai,
    max(case when city="Delhi" then name end) as Delhi
    from  ( select *,  row_number() over(partition by city  order by name) as player_group
           from players_location) A group by player_group order by player_group;
 