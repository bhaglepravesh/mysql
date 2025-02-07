use users;
create table purchase_history
(userid int
,productid int
,purchasedate varchar(20)
);
-- drop table purchase_history;
insert into purchase_history values
(1,1,'23-01-2012')
,(1,2,'23-01-2012')
,(1,3,'25-01-2012')
,(2,1,'23-01-2012')
,(2,2,'23-01-2012')
,(2,2,'25-01-2012')
,(2,4,'25-01-2012')
,(3,4,'23-01-2012')
,(3,1,'23-01-2012')
,(4,1,'23-01-2012')
,(4,2,'25-01-2012');
select * from purchase_history;


with cte as (select userid, count( distinct purchasedate) as ct,count(productid) as totalP,count(distinct productid) as dp 
from purchase_history group by userid)
select userid from cte where ct>1 and totalp=dp;
