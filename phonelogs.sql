use test;

create table phonelog(
    Callerid int, 
    Recipientid int,
    Datecalled datetime
);

INSERT INTO phonelog (Callerid, Recipientid, Datecalled)
VALUES 
    (1, 2, '2019-01-01 09:00:00'),
    (1, 3, '2019-01-01 17:00:00'),
    (1, 4, '2019-01-01 23:00:00'),
    (2, 5, '2019-07-05 09:00:00'),
    (2, 3, '2019-07-05 17:00:00'),
    (2, 3, '2019-07-05 17:20:00'),
    (2, 5, '2019-07-05 23:00:00'),
    (2, 3, '2019-08-01 09:00:00'),
    (2, 3, '2019-08-01 17:00:00'),
    (2, 5, '2019-08-01 19:30:00'),
    (2, 4, '2019-08-02 09:00:00'),
    (2, 5, '2019-08-02 10:00:00'),
    (2, 5, '2019-08-02 10:45:00'),
    (2, 4, '2019-08-02 11:00:00');
select * from phonelog;
select date(datecalled) from phonelog;

with cte as (
select callerid,date(datecalled) date,min(date(datecalled)) mi,max(date(datecalled)) ma from phonelog
group by callerid,date(datecalled) )
select c.* from cte c
inner join phonelog p1 on p1.callerid=c.callerid and date(p1.datecalled)=c.mi
inner join phonelog p2 on p2.callerid=c.callerid and date(p2.datecalled)=c.ma
where p1.Recipientid=p2.Recipientid;
