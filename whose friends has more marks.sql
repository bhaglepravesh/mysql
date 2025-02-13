use users;
select * from person;
select * from friend;

SELECT f.ï»¿PersonID,sum(score)
FROM friend f
JOIN person p ON p.ï»¿PersonID = f.FriendID  
GROUP BY f.ï»¿PersonID
HAVING SUM(p.score) >= 100;