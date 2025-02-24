use world;
create table airbnb_searches 
(
user_id int,
date_searched date,
filter_room_types varchar(200)
);
-- delete from airbnb_searches;
insert into airbnb_searches values
(1,'2022-01-01','entire home,private room')
,(2,'2022-01-02','entire home,shared room')
,(3,'2022-01-02','private room,shared room')
,(4,'2022-01-03','private room')
;
select * from airbnb_searches;

-- in MS sql
-- select value as room_type,count(1) as no_of_searches from airbnb_searches
-- cross apply string_split(filter_room_types,',') group by value order by no_of_searches desc;

WITH RECURSIVE room_type_cte AS (
    -- Anchor query: Extract first room type and remaining part
    SELECT 
        user_id,
        date_searched,
        SUBSTRING_INDEX(filter_room_types, ',', 1) AS room_type,
        SUBSTRING(filter_room_types, LOCATE(',', filter_room_types) + 1) AS remaining_rooms
    FROM airbnb_searches
    WHERE filter_room_types IS NOT NULL

    UNION ALL

    -- Recursive query: Extract the next room type
    SELECT 
        user_id,
        date_searched,
        SUBSTRING_INDEX(remaining_rooms, ',', 1) AS room_type,
        IF(LOCATE(',', remaining_rooms) > 0, SUBSTRING(remaining_rooms, LOCATE(',', remaining_rooms) + 1), NULL) AS remaining_rooms
    FROM room_type_cte
    WHERE remaining_rooms IS NOT NULL
)
SELECT room_type, COUNT(*) AS no_of_searches
FROM room_type_cte
GROUP BY room_type
ORDER BY no_of_searches DESC;



SELECT jt.room_type, COUNT(*) AS no_of_searches
FROM airbnb_searches,
JSON_TABLE(
    CONCAT('["', REPLACE(filter_room_types, ',', '","'), '"]'),
    "$[*]" COLUMNS (room_type VARCHAR(100) PATH "$")
) AS jt
GROUP BY jt.room_type
ORDER BY no_of_searches DESC;
