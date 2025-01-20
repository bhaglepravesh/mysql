use users;
create table user(id int, name varchar(20),gender varchar(20));
insert into user values(1,"ram","male"),(2,"sita","female"),(3,'shyam',"male"),(4,"bharat","male"),(5,"rima","female");
select * from user;

select distinct gender,count(gender) as gender_count,
100*count(gender)/(select count(*) from user) as gender_perct
 from user group by gender order by count(gender) desc;
 
 select  100*sum(case when gender="male" then 1 else 0 end)/count(*) as male_perct,
 100*sum(case when gender="female" then 1 else 0 end)/count(*) as female_perct from user ;