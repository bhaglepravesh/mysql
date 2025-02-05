use test;

CREATE TABLE dbo(
 order_number int NOT NULL,
 order_date date NOT NULL,
 cust_id int NOT NULL,
 salesperson_id int NOT NULL,
 amount decimal NOT NULL
);

INSERT INTO dbo VALUES (30, CAST('1995-07-14' AS Date), 9, 1, 460);

INSERT into dbo VALUES (10, CAST('1996-08-02' AS Date), 4, 2, 540);

INSERT INTO dbo VALUES (40, CAST('1998-01-29' AS Date), 7, 2, 2400);

INSERT into dbo VALUES (50, CAST('1998-02-03' AS Date), 6, 7, 600);

INSERT into dbo VALUES (60, CAST('1998-03-02' AS Date), 6, 7, 720);

INSERT into dbo VALUES (70, CAST('1998-05-06' AS Date), 9, 7, 150);

INSERT into  dbo VALUES (20, CAST('1999-01-30' AS Date), 4, 8, 1800);
select * from dbo;



SELECT e1.*
FROM dbo e1
LEFT JOIN dbo e2 
    ON e1.salesperson_id = e2.salesperson_id
GROUP BY e1.order_number, e1.order_date, e1.cust_id, e1.salesperson_id, e1.amount
HAVING e1.amount >= MAX(e2.amount);