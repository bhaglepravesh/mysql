use test;
-- delete from product_stg;
-- delete from product_dim1;
CREATE TABLE product_stg(
    Product_id  INT,
    Product_Name VARCHAR(50),
    Price   DECIMAL(9,2)
);

CREATE TABLE product_dim(
    Product_id  INT primary key,
    Product_Name VARCHAR(50),
    Price   DECIMAL(9,2),
 last_update date
);

create TABLE product_dim1(
 product_key int auto_increment primary key,
    Product_id  INT,
    Product_Name VARCHAR(50),
    Price   DECIMAL(9,2),
 start_date date,
 end_date date
) auto_increment=10000;

insert into product_stg values(1,"iphone13",40000),(2,"iphone14",70000);

SELECT CURDATE() INTO @today;
select @today;
select current_date() into @previousday;
SET @tooday = CURDATE();

select @previousday;
select @tooday;

insert into product_dim select *,@today from product_stg
 where product_id not in (select product_id from product_dim);
 
 select * from product_dim;
 
 -- SCD Type 1
 -- date is 15/04/2025 suppose
 set sql_safe_updates=0;
 delete from product_stg;
 insert into product_stg values(1,"iphone13",30000),(3,"iphone15",90000);
 select * from product_stg;
 select * from product_dim;
 
 set @today ="2025-04-15";
 UPDATE product_dim
JOIN product_stg ON product_dim.Product_id = product_stg.Product_id
SET 
    product_dim.last_update = @today,
    product_dim.price = product_stg.price;

 
 insert into product_dim select *,@today from product_stg
 where product_id not in (select product_id from product_dim);
 
 select * from product_stg;
 select * from product_dim;
 
 
 -- SCD Type 2
 delete from product_stg;
 insert into product_stg values(1,"iphone13",40000),(2,"iphone14",70000);
 select current_date() into @today;
 set @end_date="9999-09-29";
 
insert into product_dim1 (Product_id, Product_Name, Price, start_date, end_date)
select product_id,product_name,price,@today,@end_date from product_stg
where product_id not in (select product_id from product_dim1);
 
 select * from product_stg;
 select * from product_dim1;
 
 delete from product_stg;
 insert into product_stg values(1,"iphone13",30000),(3,"iphone15",90000);
 select * from product_stg;
 select * from product_dim1;
 
 set @tooday ="2025-04-15";
 
 update product_dim1 join product_stg on product_dim1.product_id=product_stg.product_id
 set end_date=date_add(@tooday, interval -1 day),
     product_dim1.price=product_stg.price
 where end_date=@end_date;
 
 insert into product_dim1 (Product_id, Product_Name, Price, start_date, end_date)
select product_id,product_name,price,@tooday,@end_date from product_stg;
-- where product_id not in (select product_id from product_dim1);

 select * from product_dim1;