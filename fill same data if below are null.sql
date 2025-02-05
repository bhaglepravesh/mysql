use users;
create table brands 
(
category varchar(20),
brand_name varchar(20)
);
insert into brands values
('chocolates','5-star')
,(null,'dairy milk')
,(null,'perk')
,(null,'eclair')
,('Biscuits','britannia')
,(null,'good day')
,(null,'boost');

select * from brands;

with cte as (select *, row_number() over() as row_no from brands)
, cte1 as ( select *,lead(row_no,1) over(order by row_no) as next_rn
from cte  where category is not null)
select cte1.category,cte.brand_name from cte inner join cte1 on cte.row_no>=cte1.row_no 
and (cte.row_no<=cte1.next_rn or cte1.next_rn is null);

with cte as (select *, row_number() over() as row_no from brands)
, cte1 as ( select *,lead(row_no,1,9999) over(order by row_no) as next_rn
from cte  where category is not null)
select cte1.category,cte.brand_name from cte inner join cte1 on cte.row_no>=cte1.row_no 
and cte.row_no<=cte1.next_rn ;