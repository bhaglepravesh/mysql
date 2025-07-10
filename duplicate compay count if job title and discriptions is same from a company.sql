use world;
CREATE TABLE job_listings (
    job_id INT PRIMARY KEY,
    company_id INT,
    title TEXT,
    description TEXT
);
INSERT INTO job_listings (job_id, company_id, title, description) VALUES
(248, 827, 'Business Analyst', 'Business analyst evaluates past and current business data'),
(149, 845, 'Business Analyst', 'Business analyst evaluates past and current business data'),
(945, 345, 'Data Analyst', 'Data analyst reviews data to identify key insights into a business'),
(164, 345, 'Data Analyst', 'Data analyst reviews data to identify key insights into a business'),
(172, 244, 'Data Engineer', 'Data engineer works in a variety of settings to build systems');

select * from job_listings;

-- Step 1: Create the table
CREATE TABLE job_listings_02 (
    job_id INT PRIMARY KEY,
    company_id INT,
    title VARCHAR(255),
    description TEXT
);

-- Step 2: Insert values into the table
INSERT INTO job_listings_02 (job_id, company_id, title, description) VALUES
(248, 827, 'Business Analyst', 'Business analyst evaluates past and current business data'),
(149, 827, 'Business Analyst', 'Business analyst evaluates past and current business data'),
(945, 345, 'Data Analyst', 'Data analyst reviews data to identify key insights into a business'),
(164, 345, 'Data Analyst', 'Data analyst reviews data to identify key insights into a business'),
(172, 244, 'Data Engineer', 'Data engineer works in a variety of settings to build systems'),
(999, 827, 'Data Engineer', 'Data engineer works in a variety of settings to build systems'),
(1000, 827, 'Data Engineer', 'Data engineer works in a variety of settings to build systems');


select count(company_id) from (
select company_id from job_listings group by company_id,title,description having count(*)>1 ) A;
select count(company_id) from (
select distinct company_id from job_listings_02 group by company_id,title,description having count(*)>1) B;

with cte as (
select * , row_number() over(partition by company_id,title,description) as rn from job_listings_02)
select count( distinct company_id) from cte where rn>1;