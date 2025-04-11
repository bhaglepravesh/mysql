use world;
create table weather_data (
    date date,
    temperature int
);

insert into weather_data values ('2024-04-15', 40),('2024-04-16', 42),('2024-04-17', 38),
('2024-04-18', 36),('2024-04-19', 38), ('2024-04-20', 45),('2024-04-21', 46),('2024-04-22', 40),
('2024-04-23', 41),('2024-04-24', 43),('2024-04-25', 39),('2024-04-26', 37), ('2024-04-27', 42);
select * from weather_data;

SELECT 
    a.date, 
    a.temperature AS temp_a, 
    COALESCE(b.temperature, 0) AS temp_b, 
    COALESCE(c.temperature, 0) AS temp_c
FROM 
    weather_data a
LEFT JOIN 
    weather_data b ON b.date = DATE_SUB(a.date, INTERVAL 1 DAY)
LEFT JOIN 
    weather_data c ON c.date = DATE_SUB(a.date, INTERVAL 2 DAY)
WHERE 
    a.temperature > (COALESCE(b.temperature, 0) + COALESCE(c.temperature, 0))/2;


SELECT *
FROM (
    SELECT *,
           LAG(temperature, 1) OVER (ORDER BY date) AS temp_1_day_ago,
           LAG(temperature, 2) OVER (ORDER BY date) AS temp_2_days_ago
    FROM weather_data
) AS sub
WHERE temperature > (COALESCE(temp_1_day_ago, 0) + COALESCE(temp_2_days_ago, 0)) / 2;

select * from weather_data;
with cte as(
select *,avg(temperature) over(order by date rows between 2 preceding and 1 preceding) as avgs from weather_data)
select * from cte where temperature>avgs;