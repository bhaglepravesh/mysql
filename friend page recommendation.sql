use sys;
CREATE TABLE friends (
    user_id INT,
    friend_id INT
);

-- Insert data into friends table
INSERT INTO friends VALUES
(1, 2),
(1, 3),
(1, 4),
(2, 1),
(3, 1),
(3, 4),
(4, 1),
(4, 3);

-- Create likes table
CREATE TABLE likes (
    user_id INT,
    page_id CHAR(1)
);

-- Insert data into likes table
INSERT INTO likes VALUES
(1, 'A'),
(1, 'B'),
(1, 'C'),
(2, 'A'),
(3, 'B'),
(3, 'C'),
(4, 'B');

select * from likes;
select * from friends;

with friends_page as (
select distinct f.user_id as user_id,f.friend_id,l.page_id as page_id from friends f join likes l 
on f.friend_id=l.user_id)
select distinct fr.user_id,fr.page_id from friends_page fr left join likes li on fr.user_id=li.user_id and fr.page_id=li.page_id 
where li.user_id is null;


select distinct f.user_id as user_id,l.page_id as page_id from friends f join likes l 
on f.friend_id=l.user_id
left join likes li on f.user_id=li.user_id and l.page_id=li.page_id where li.page_id is null;