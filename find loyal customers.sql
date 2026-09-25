use sys;
CREATE TABLE if not exists customer_transactions (
    transaction_id INT,
    customer_id INT,
    transaction_date DATE,
    amount DECIMAL(10,2),
    transaction_type VARCHAR(20)
);
# Truncate table customer_transactions
insert into customer_transactions (transaction_id, customer_id, transaction_date, amount, transaction_type) values ('1', '101', '2024-01-05', '150.0', 'purchase');
insert into customer_transactions (transaction_id, customer_id, transaction_date, amount, transaction_type) values ('2', '101', '2024-01-15', '200.0', 'purchase');
insert into customer_transactions (transaction_id, customer_id, transaction_date, amount, transaction_type) values ('3', '101', '2024-02-10', '180.0', 'purchase');
insert into customer_transactions (transaction_id, customer_id, transaction_date, amount, transaction_type) values ('4', '101', '2024-02-20', '250.0', 'purchase');
insert into customer_transactions (transaction_id, customer_id, transaction_date, amount, transaction_type) values ('5', '102', '2024-01-10', '100.0', 'purchase');
insert into customer_transactions (transaction_id, customer_id, transaction_date, amount, transaction_type) values ('6', '102', '2024-01-12', '120.0', 'purchase');
insert into customer_transactions (transaction_id, customer_id, transaction_date, amount, transaction_type) values ('7', '102', '2024-01-15', '80.0', 'refund');
insert into customer_transactions (transaction_id, customer_id, transaction_date, amount, transaction_type) values ('8', '102', '2024-01-18', '90.0', 'refund');
insert into customer_transactions (transaction_id, customer_id, transaction_date, amount, transaction_type) values ('9', '102', '2024-02-15', '130.0', 'purchase');
insert into customer_transactions (transaction_id, customer_id, transaction_date, amount, transaction_type) values ('10', '103', '2024-01-01', '500.0', 'purchase');
insert into customer_transactions (transaction_id, customer_id, transaction_date, amount, transaction_type) values ('11', '103', '2024-01-02', '450.0', 'purchase');
insert into customer_transactions (transaction_id, customer_id, transaction_date, amount, transaction_type) values ('12', '103', '2024-01-03', '400.0', 'purchase');
insert into customer_transactions (transaction_id, customer_id, transaction_date, amount, transaction_type) values ('13', '104', '2024-01-01', '200.0', 'purchase');
insert into customer_transactions (transaction_id, customer_id, transaction_date, amount, transaction_type) values ('14', '104', '2024-02-01', '250.0', 'purchase');
insert into customer_transactions (transaction_id, customer_id, transaction_date, amount, transaction_type) values ('15', '104', '2024-02-15', '300.0', 'purchase');
insert into customer_transactions (transaction_id, customer_id, transaction_date, amount, transaction_type) values ('16', '104', '2024-03-01', '350.0', 'purchase');
insert into customer_transactions (transaction_id, customer_id, transaction_date, amount, transaction_type) values ('17', '104', '2024-03-10', '280.0', 'purchase');
insert into customer_transactions (transaction_id, customer_id, transaction_date, amount, transaction_type) values ('18', '104', '2024-03-15', '100.0', 'refund');

select * from customer_transactions;


SELECT
    customer_id
FROM customer_transactions
GROUP BY customer_id
HAVING
    -- At least 3 purchase transactions
    SUM(transaction_type = 'purchase') >= 3
    -- Active for at least 30 days
    AND DATEDIFF(
        MAX(transaction_date),
        MIN(transaction_date)
    ) >= 30
    -- Refund rate < 20%
    AND (
        SUM(transaction_type = 'refund') * 100.0
        / COUNT(*)
    ) < 20
ORDER BY customer_id ASC;



WITH customer_summary AS (
    SELECT
        customer_id,
        COUNT(CASE
            WHEN transaction_type = 'purchase' THEN 1
        END) AS purchase_count,
        COUNT(CASE
            WHEN transaction_type = 'refund' THEN 1
        END) AS refund_count,
        COUNT(*) AS total_transactions,
        MIN(transaction_date) AS first_transaction_date,
        MAX(transaction_date) AS last_transaction_date
    FROM customer_transactions
    GROUP BY customer_id
)
SELECT
    customer_id
FROM customer_summary
WHERE purchase_count >= 3
  AND DATEDIFF(
        last_transaction_date,
        first_transaction_date
      ) >= 30
  AND (refund_count * 100.0 / total_transactions) < 20
ORDER BY customer_id ASC;




WITH customer_data AS (
    SELECT
        *,
        MIN(transaction_date)
            OVER (PARTITION BY customer_id) AS first_date,
        MAX(transaction_date)
            OVER (PARTITION BY customer_id) AS last_date,
        SUM(
            CASE
                WHEN transaction_type = 'purchase' THEN 1
                ELSE 0
            END
        ) OVER (PARTITION BY customer_id) AS purchase_count,
        SUM(
            CASE
                WHEN transaction_type = 'refund' THEN 1
                ELSE 0
            END
        ) OVER (PARTITION BY customer_id) AS refund_count,
        COUNT(*)
            OVER (PARTITION BY customer_id) AS total_count
    FROM customer_transactions
)
SELECT DISTINCT
    customer_id
FROM customer_data
WHERE purchase_count >= 3
  AND DATEDIFF(last_date, first_date) >= 30
  AND (refund_count * 100.0 / total_count) < 20
ORDER BY customer_id ASC;





##### If "refund rate" means (refund amount / purchase amount)*100

WITH customer_summary AS (
    SELECT
        customer_id,
        SUM(
            CASE
                WHEN transaction_type = 'purchase' THEN 1
                ELSE 0
            END
        ) AS purchase_count,
        SUM(
            CASE
                WHEN transaction_type = 'purchase' THEN amount
                ELSE 0
            END
        ) AS purchase_amount,
        SUM(
            CASE
                WHEN transaction_type = 'refund' THEN amount
                ELSE 0
            END
        ) AS refund_amount,
        MIN(transaction_date) AS first_date,
        MAX(transaction_date) AS last_date
    FROM customer_transactions
    GROUP BY customer_id
)
SELECT customer_id
FROM customer_summary
WHERE purchase_count >= 3
  AND DATEDIFF(last_date, first_date) >= 30
  AND (refund_amount * 100.0 / purchase_amount) < 20
ORDER BY customer_id ASC;

