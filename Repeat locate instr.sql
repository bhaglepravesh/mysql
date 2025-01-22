use test;
select * from employee;
select repeat(age,3) as triple_age from employee;


select substring(name,locate("e",name)) from employee;
select substr(name,instr(name,"e")) from employee;