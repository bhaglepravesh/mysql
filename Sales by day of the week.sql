use test;

create table orders(orderid int,customerid int, orderdate date, item_id int, quantity int);
insert into orders values(1,1,"2020-06-01",1,10),(2,1,"2020-06-08",2,10),(3,2,"2020-06-02",1,5),(4,3,"2020-06-03",3,5),
(5,4,"2020-06-04",4,1),(6,4,"2020-06-05",5,5),(7,5,"2020-06-05",1,10),(8,5,"2020-06-14",4,5),(9,5,"2020-06-21",3,5);


create table items(itemid int,itemname varchar(20),itemcategory varchar(20));
insert into items values(1,"alg book","book"),(2,"db book","book"),(3,"nokia","phone"),(4,"iphone","phone"),
(5,"smartglass","glasses"),(6,"Tshirt XL","Tshirt");

select * from orders;
select * from items;

with cte as (
select i.itemcategory,dayname(o.orderdate) as dayname,sum(ifnull(o.quantity,0)) ttlqty from items i left join
 orders o on i.itemid=o.item_id group by i.itemcategory,dayname(o.orderdate) ),
 cte2 as (
 select itemcategory, max(case when dayname="Monday" then ttlqty end) as Monday,
 max(case when dayname="Tuesday" then ttlqty end) as Tuesday,max(case when dayname="Wednesday" then ttlqty end) as Wednesday,
 max(case when dayname="Thursday" then ttlqty end) as Thursday,max(case when dayname="Friday" then ttlqty end) as Friday,
 max(case when dayname="Saturday" then ttlqty end) as Saturday,max(case when dayname="Sunday" then ttlqty end) as Sunday
 from cte group by itemcategory order by itemcategory)
  select itemcategory,ifnull(Monday,0) Monday,ifnull(Tuesday,0) Tuesday,ifnull(Wednesday,0) Wednesday,
  ifnull(Thursday,0) Thursday,ifnull(Friday,0) Friday,ifnull(Saturday,0) Saturday,ifnull(Sunday,0) Sunday from cte2;
  ;