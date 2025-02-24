use users;
CREATE TABLE call_start_logs (
    phone_number VARCHAR(10),
    start_time DATETIME
);

INSERT INTO call_start_logs VALUES
('PN1','2022-01-01 10:20:00'), ('PN1','2022-01-01 16:25:00'), ('PN2','2022-01-01 12:30:00'),
('PN3','2022-01-02 10:00:00'), ('PN3','2022-01-02 12:30:00'), ('PN3','2022-01-03 09:20:00');

CREATE TABLE call_end_logs (
    phone_number VARCHAR(10),
    end_time DATETIME
);

INSERT INTO call_end_logs VALUES
('PN1','2022-01-01 10:45:00'), ('PN1','2022-01-01 17:05:00'), ('PN2','2022-01-01 12:55:00'),
('PN3','2022-01-02 10:20:00'), ('PN3','2022-01-02 12:50:00'), ('PN3','2022-01-03 09:40:00');

select * from call_start_logs;
select * from call_end_logs;

with cte1 as (
select *, row_number() over(partition by phone_number order by start_time) as rns from call_start_logs),
cte2 as (select *, row_number() over(partition by phone_number order by end_time) as rn from call_end_logs)
select cte1.phone_number,cte1.start_time,cte2.end_time,
 TIMESTAMPDIFF(minute,cte1.start_time,cte2.end_time) time_taken from cte1 join cte2 on
 cte1.phone_number=cte2.phone_number and cte1.rns=cte2.rn;
 
 
 
select phone_number,min(event_time) start_time,max(event_time) end_time,
TIMESTAMPDIFF(MINUTE, MIN(event_time), MAX(event_time)) AS time_taken from
 (select phone_number,start_time as event_time, row_number() over(partition by phone_number order by start_time) as rn from call_start_logs
 union all
 select phone_number,end_time as event_time, row_number() over(partition by phone_number order by end_time) as rn from call_end_logs) A
 group by phone_number,rn;
 
 
 WITH combined AS (
    SELECT phone_number, start_time AS event_time, ROW_NUMBER() OVER (PARTITION BY phone_number ORDER BY start_time) AS rn
    FROM call_start_logs
    UNION ALL
    SELECT phone_number, end_time AS event_time, ROW_NUMBER() OVER (PARTITION BY phone_number ORDER BY end_time) AS rn
    FROM call_end_logs
)
SELECT 
    phone_number, 
    MIN(event_time) AS start_time, 
    MAX(event_time) AS end_time,
    TIMESTAMPDIFF(MINUTE, MIN(event_time), MAX(event_time)) AS time_taken
FROM combined
GROUP BY phone_number, rn;


