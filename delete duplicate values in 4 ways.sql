use world;
drop table if exists cars;
create table if not exists cars
(
    id      int,
    model   varchar(50),
    brand   varchar(40),
    color   varchar(30),
    make    int
);
insert into cars values (1, 'Model S', 'Tesla', 'Blue', 2018);
insert into cars values (2, 'EQS', 'Mercedes-Benz', 'Black', 2022);
insert into cars values (3, 'iX', 'BMW', 'Red', 2022);
insert into cars values (4, 'Ioniq 5', 'Hyundai', 'White', 2021);
insert into cars values (5, 'Model S', 'Tesla', 'Silver', 2018);
insert into cars values (6, 'Ioniq 5', 'Hyundai', 'Green', 2021);
select * from cars;
set sql_safe_updates=0;

DELETE FROM cars 
WHERE id NOT IN (
    SELECT id FROM (
        SELECT MIN(id) AS id 
        FROM cars 
        GROUP BY model, brand
    ) AS subquery
);


DELETE c1
FROM cars c1
LEFT JOIN (
    SELECT MIN(id) AS id
    FROM cars
    GROUP BY model, brand
) c2 ON c1.id = c2.id
WHERE c2.id IS NULL;

DELETE FROM cars
WHERE id IN (
    SELECT id FROM (
        SELECT c2.id
        FROM cars c1
        JOIN cars c2 ON c1.model = c2.model AND c1.brand = c2.brand
        WHERE c1.id < c2.id
    ) AS sub
);

DELETE FROM cars
WHERE id IN (
    SELECT id FROM (
        SELECT id,
               ROW_NUMBER() OVER (PARTITION BY model, brand ORDER BY id) AS rn
        FROM cars
    ) AS sub
    WHERE rn > 1
);
