use world;
CREATE TABLE employee_checkin_details (
    employeeid INT,
    entry_details ENUM('login', 'logout'),
    timestamp_details DATETIME(2)
);
CREATE TABLE employee_details (
    employeeid INT,
    phone_number VARCHAR(20),
    isdefault BOOLEAN
);
-- Data for employee_checkin_details
INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details) VALUES
(1000, 'login',  '2023-06-16 01:00:15.34'),
(1000, 'login',  '2023-06-16 02:00:15.34'),
(1000, 'login',  '2023-06-16 03:00:15.34'),
(1000, 'logout', '2023-06-16 12:00:15.34'),
(1001, 'login',  '2023-06-16 01:00:15.34'),
(1001, 'login',  '2023-06-16 02:00:15.34'),
(1001, 'login',  '2023-06-16 03:00:15.34'),
(1001, 'logout', '2023-06-16 12:00:15.34');

-- Data for employee_details
INSERT INTO employee_details (employeeid, phone_number, isdefault) VALUES
(1001, '9999', FALSE),
(1001, '1111', FALSE),
(1001, '2222', TRUE),
(1003, '3333', FALSE);

select * from employee_checkin_details;
select * from employee_details;

with logins as(
select employeeid, count(entry_details) as t_login,max(timestamp_details) as r_login from employee_checkin_details
where entry_details='login' group by employeeid)
, logouts as (
select employeeid, count(entry_details) as t_logout,max(timestamp_details) as r_logout from employee_checkin_details
where entry_details="logout" group by employeeid)
select *,t_login+t_logout from logins join logouts using(employeeid) join employee_details using(employeeid) where isdefault is true or null;

select * from (select  employeeid,max(case when entry_details="login" then timestamp_details else null end) as r_login,
       count(case when entry_details="login" then timestamp_details else null end) as t_login,
       max(case when entry_details="logout" then timestamp_details else null end) as r_logout,
       count(case when entry_details="logout" then timestamp_details else null end) as t_logout,
count(case when entry_details="login" then timestamp_details else null end) + count(case when entry_details="logout" then timestamp_details else null end) as t_login_logout
from employee_checkin_details group by employeeid) d join employee_details using(employeeid) where isdefault is true;