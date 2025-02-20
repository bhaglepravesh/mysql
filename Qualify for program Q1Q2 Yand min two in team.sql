use test;
create table Ameriprise_LLC
(
teamID varchar(2),
memberID varchar(10),
Criteria1 varchar(1),
Criteria2 varchar(1)
);
insert into Ameriprise_LLC values 
('T1','T1_mbr1','Y','Y'),
('T1','T1_mbr2','Y','Y'),
('T1','T1_mbr3','Y','Y'),
('T1','T1_mbr4','Y','Y'),
('T1','T1_mbr5','Y','N'),
('T2','T2_mbr1','Y','Y'),
('T2','T2_mbr2','Y','N'),
('T2','T2_mbr3','N','Y'),
('T2','T2_mbr4','N','N'),
('T2','T2_mbr5','N','N'),
('T3','T3_mbr1','Y','Y'),
('T3','T3_mbr2','Y','Y'),
('T3','T3_mbr3','N','Y'),
('T3','T3_mbr4','N','Y'),
('T3','T3_mbr5','Y','N');

select * from Ameriprise_LLC;


select *, case when criteria1="Y" and criteria2="Y" and sum(
case when criteria1="Y" and criteria2="Y" then 1 else 0 end) over(partition by teamid)>=2
 then "Y" else "N" end  pre_qualify
from Ameriprise_LLC ;

with cte as (
select teamid,count(teamid) as qualify_mem
from Ameriprise_LLC where criteria1="Y" and criteria2="Y" 
group by teamid having count(teamid)>=2)
select a.*,
case when a.criteria1="Y" and a.criteria2="Y"  and c.qualify_mem is not null then "Y" else "N" end qualify
from Ameriprise_LLC a left join cte c on c.teamid=a.teamid;
