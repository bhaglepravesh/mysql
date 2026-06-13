use test;

create table emails(id int primary key,email varchar(30));
insert into emails values(1,"abc@gmail.com"),(2,"bcd@gmail.com"),(3,"def@gmail.com"),
(4,"bcd@gmail.com"),(5,"efg@gmail.com"),(6,"def@gmail.com");
select * from emails;
select distinct e1.email from emails e1, emails e2 where e1.id!=e2.id and e1.email=e2.email;