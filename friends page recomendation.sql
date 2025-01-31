use test;
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

select * from friends;
select * from likes;

SELECT DISTINCT f.user_id, l.page_id  
FROM friends f  
JOIN likes l ON f.friend_id = l.user_id  
LEFT JOIN likes my_likes ON f.user_id = my_likes.user_id AND l.page_id = my_likes.page_id  
WHERE my_likes.page_id IS NULL;


with users_page as(
select distinct f.user_id as user_id,l.page_id as page_id from friends f join likes l on f.user_id=l.user_id), friends_page as (
select distinct f.user_id,f.friend_id,l.page_id as page_id from friends f join likes l on f.friend_id=l.user_id)
select distinct fr.user_id,fr.page_id from users_page u right join friends_page fr on u.user_id=fr.user_id and u.page_id=fr.page_id
where u.page_id is null;




SELECT f.user_id, fp.page_id  
FROM friends f  
INNER JOIN likes fp ON f.friend_id = fp.user_id  
WHERE CONCAT(f.user_id, fp.page_id) NOT IN (  
    SELECT DISTINCT CONCAT(f.user_id, fp.page_id)  
    FROM friends f  
    INNER JOIN likes fp ON f.user_id = fp.user_id  
) group by f.user_id,fp.page_id;