use sys;
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50)
);
INSERT INTO products (product_id, product_name, category) VALUES
(4, 'Headphones', 'Accessories'),
(5, 'Smartwatch', 'Accessories'),
(6, 'Keyboard', 'Accessories'),
(7, 'Mouse', 'Accessories'),
(8, 'Monitor', 'Accessories'),
(1, 'Laptop', 'Electronics'),
(2, 'Smartphone', 'Electronics'),
(3, 'Tablet', 'Electronics'),
(9, 'Printer', 'Electronics');

select b.product_id,a.product_name,a.category from 
(select *, row_number() over (partition by category order by product_id) as rn from products) a join 
(select *, row_number() over (partition by category order by product_id desc) as rn from products) b on a.rn=b.rn and a.category=b.category;