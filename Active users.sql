use test;

Create table If Not Exists Accounts (id int, name varchar(10));
Create table If Not Exists Logins (id int, login_date date);
insert into Accounts (id, name) values ('1', 'Winston');
insert into Accounts (id, name) values ('7', 'Jonathan');
insert into Logins (id, login_date) values ('7', '2020-05-30');
insert into Logins (id, login_date) values ('1', '2020-05-30');
insert into Logins (id, login_date) values ('7', '2020-05-31');
insert into Logins (id, login_date) values ('7', '2020-06-01');
insert into Logins (id, login_date) values ('7', '2020-06-02');
insert into Logins (id, login_date) values ('7', '2020-06-02');
insert into Logins (id, login_date) values ('7', '2020-06-03');
insert into Logins (id, login_date) values ('1', '2020-06-07');
insert into Logins (id, login_date) values ('7', '2020-06-10');
select * from Accounts;
select * from  logins;

with cte as (
select distinct a.id,a.name,l.login_date from Accounts a join logins l on a.id=l.id),
cte1 as (select *, row_number() over (partition by id order by login_date) as rnk from cte)
select id,name from cte1 group by id,name,date_sub(login_date, interval rnk day) having count(*)>=5;