
CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);

INSERT INTO sales_data VALUES
    (1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
    (2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),
    (3, 103, 'Charlie', 'Clothing', 'T-Shirt', 5, 20.00, 100.00, '2024-01-03', 'East'),
    (4, 104, 'David', 'Furniture', 'Table', 1, 250.00, 250.00, '2024-01-04', 'West'),
    (5, 105, 'Eve', 'Electronics', 'Tablet', 1, 300.00, 300.00, '2024-01-05', 'North'),
    (6, 106, 'Frank', 'Clothing', 'Jacket', 2, 80.00, 160.00, '2024-01-06', 'South'),
    (7, 107, 'Grace', 'Electronics', 'Headphones', 3, 50.00, 150.00, '2024-01-07', 'East'),
    (8, 108, 'Hank', 'Furniture', 'Chair', 4, 75.00, 300.00, '2024-01-08', 'West'),
    (9, 109, 'Ivy', 'Clothing', 'Jeans', 1, 40.00, 40.00, '2024-01-09', 'North'),
    (10, 110, 'Jack', 'Electronics', 'Laptop', 2, 1200.00, 2400.00, '2024-01-10', 'South'),
    (11, 101, 'Alice', 'Electronics', 'Phone', 1, 600.00, 600.00, '2024-01-11', 'North'),
    (12, 102, 'Bob', 'Furniture', 'Sofa', 1, 500.00, 500.00, '2024-01-12', 'South'),
    (13, 103, 'Charlie', 'Electronics', 'Camera', 1, 400.00, 400.00, '2024-01-13', 'East'),
    (14, 104, 'David', 'Clothing', 'Sweater', 2, 60.00, 120.00, '2024-01-14', 'West'),
    (15, 105, 'Eve', 'Furniture', 'Bed', 1, 800.00, 800.00, '2024-01-15', 'North'),
    (16, 106, 'Frank', 'Electronics', 'Monitor', 1, 200.00, 200.00, '2024-01-16', 'South'),
    (17, 107, 'Grace', 'Clothing', 'Scarf', 3, 25.00, 75.00, '2024-01-17', 'East'),
    (18, 108, 'Hank', 'Furniture', 'Desk', 1, 350.00, 350.00, '2024-01-18', 'West'),
    (19, 109, 'Ivy', 'Electronics', 'Speaker', 2, 100.00, 200.00, '2024-01-19', 'North'),
    (20, 110, 'Jack', 'Clothing', 'Shoes', 1, 90.00, 90.00, '2024-01-20', 'South'),
    (21, 111, 'Kevin', 'Electronics', 'Mouse', 3, 25.00, 75.00, '2024-01-21', 'East'),
    (22, 112, 'Laura', 'Furniture', 'Couch', 1, 700.00, 700.00, '2024-01-22', 'West'),
    (23, 113, 'Mike', 'Clothing', 'Hat', 4, 15.00, 60.00, '2024-01-23', 'North'),
    (24, 114, 'Nancy', 'Electronics', 'Smartwatch', 1, 250.00, 250.00, '2024-01-24', 'South'),
    (25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East')


select *, sum(total_amount) over ( partition by customer_id order by order_date, sale_id) as running_total  from sales_data

select 
product_category,
Count(quantity_sold) as Total_count from sales_data
group by product_category

select *, count(total_amount) over (partition by product_category) as Total_count
from sales_data


select *, max(total_amount) over (partition by product_category) as Max_totalamount
from sales_data


select *, min(unit_price) over (partition by product_category) as min_price
from sales_data

select * from sales_data

SELECT 
    sale_id,
    order_date,
    total_amount,
    ROUND((
        COALESCE(LAG(total_amount) OVER (ORDER BY order_date), 0) +
        total_amount +
        COALESCE(LEAD(total_amount) OVER (ORDER BY order_date), 0)
    ) / 3, 2) AS moving_avg_3_day
FROM 
    sales_data
ORDER BY 
    order_date;

select * from sales_data

select *, sum (total_amount) over (partition by region ) from sales_data


select *, sum (total_amount) over (partition by customer_name ) from sales_data 

select
customer_id,
customer_name,
Sum(total_amount) as Total_purchase,
DENSE_RANK() over (order by Sum(total_amount) desc) as rnk
from sales_data 
group by customer_id,customer_name
order by 
rnk

select * from sales_data


SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    total_amount - LAG(total_amount,1,0) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS amount_difference
FROM 
    sales_data
ORDER BY 
    customer_id, order_date;

WITH ranked_products AS (
    SELECT 
        product_category,
        product_name,
        unit_price,
        RANK() OVER (
            PARTITION BY product_category 
            ORDER BY unit_price DESC
        ) AS price_rank
    FROM 
        sales_data
)
SELECT 
    product_category,
    product_name,
    unit_price,
    price_rank
FROM 
    ranked_products
WHERE 
    price_rank <= 3
ORDER BY 
    product_category, price_rank;

select * from sales_data

SELECT
    region,
    order_date,
    total_amount,
    SUM(total_amount) OVER (PARTITION BY region ORDER BY order_date) AS cumulative_sales
FROM sales_data
ORDER BY region, order_date;

Select 
	product_category,
	order_date,
	total_amount,
	Sum(total_amount) over (Partition by product_category order by order_date) as revenue
	from sales_data

	SELECT
    ID,
    SUM(ID) OVER (ORDER BY ID) AS SumPreValues
FROM your_table_name;


CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);

select * from OneColumn

select *,
sum(value) over ( order by value) as a
from OneColumn

SELECT
    Value,
    SUM(Value) OVER (ORDER BY Value) AS [Sum of Previous]
FROM OneColumn;

SELECT
    Value,
    SUM(Value) OVER (ORDER BY Value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS [Sum of Previous]
FROM OneColumn;

CREATE TABLE Row_Nums (
    Id INT,
    Vals VARCHAR(10)
);
INSERT INTO Row_Nums VALUES
(101,'a'), (102,'b'), (102,'c'), (103,'f'), (103,'e'), (103,'q'), (104,'r'), (105,'p');

select * from Row_Nums

WITH Numbered AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Vals) AS rn
    FROM Row_Nums
),
OffsetCalc AS (
    SELECT Id,
           SUM(cnt) OVER (ORDER BY Id ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) * 2 - 1 AS start_odd
    FROM (
        SELECT Id, COUNT(*) AS cnt
        FROM Row_Nums
        GROUP BY Id
    ) AS counts
)
SELECT 
    n.Id,
    n.Vals,
    o.start_odd + n.rn - 1 AS RowNumber
FROM Numbered n
JOIN OffsetCalc o ON n.Id = o.Id
ORDER BY RowNumber;


select *,
COUNT(customer_id) 
from sales_data
group by product_category

SELECT customer_id, customer_name
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1;

WITH category_per_customer AS (
    SELECT DISTINCT customer_id, customer_name, product_category
    FROM sales_data
),
category_counted AS (
    SELECT *,
           COUNT(*) OVER (PARTITION BY customer_id) AS category_count
    FROM category_per_customer
)
SELECT DISTINCT customer_id, customer_name
FROM category_counted
WHERE category_count > 1;

select * from sales_data

select
region,
avg(total_amount)
from sales_data
group by region



SELECT
    customer_id,
    customer_name,
    region,
    total_amount,
    avg_region_spending
FROM (
    SELECT 
        customer_id,
        customer_name,
        region,
        total_amount,
        AVG(total_amount) OVER (PARTITION BY region) AS avg_region_spending
    FROM sales_data
) AS sub
WHERE total_amount > avg_region_spending;


Select *,
DENSE_RANK() over (partition by region order by total_amount desc ) as rnk
from sales_data 


select * from sales_data


WITH monthly_sales AS (
    SELECT 
        FORMAT(order_date, 'yyyy-MM') AS sales_month,
        SUM(total_amount) AS total_sales
    FROM sales_data
    GROUP BY FORMAT(order_date, 'yyyy-MM')
),
growth AS (
    SELECT 
        sales_month,
        total_sales,
        LAG(total_sales) OVER (ORDER BY sales_month) AS prev_sales
    FROM monthly_sales
)
SELECT 
    sales_month,
    total_sales,
    prev_sales,
    ROUND(
        CASE 
            WHEN prev_sales IS NULL OR prev_sales = 0 THEN NULL
            ELSE (total_sales - prev_sales) * 100.0 / prev_sales
        END, 2
    ) AS growth_rate
FROM growth;




SELECT
    customer_id,
    customer_name,
    order_date,
    total_amount,
    prev_total_amount,
    total_amount - prev_total_amount AS amount_difference
FROM (
    SELECT 
        customer_id,
        customer_name,
        order_date,
        total_amount,
        LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_total_amount
    FROM sales_data
) AS t
WHERE prev_total_amount IS NOT NULL
  AND total_amount > prev_total_amount
ORDER BY customer_id, order_date;
