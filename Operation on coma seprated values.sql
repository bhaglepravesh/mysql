use test;
select * from employee;

create view views as select *,concat(age,",",salary) as ages from employee;

 select * from views;
select *, (substring_index(ages,",",1)+
substring_index(substring_index(ages,",",2),",",-1))/2 as avg from views;