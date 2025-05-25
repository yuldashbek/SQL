CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES
(1, 'Samsung Galaxy S23', 'Electronics', 899.99),
(2, 'Apple iPhone 14', 'Electronics', 999.99),
(3, 'Sony WH-1000XM5 Headphones', 'Electronics', 349.99),
(4, 'Dell XPS 13 Laptop', 'Electronics', 1249.99),
(5, 'Organic Eggs (12 pack)', 'Groceries', 3.49),
(6, 'Whole Milk (1 gallon)', 'Groceries', 2.99),
(7, 'Alpen Cereal (500g)', 'Groceries', 4.75),
(8, 'Extra Virgin Olive Oil (1L)', 'Groceries', 8.99),
(9, 'Mens Cotton T-Shirt', 'Clothing', 12.99),
(10, 'Womens Jeans - Blue', 'Clothing', 39.99),
(11, 'Unisex Hoodie - Grey', 'Clothing', 29.99),
(12, 'Running Shoes - Black', 'Clothing', 59.95),
(13, 'Ceramic Dinner Plate Set (6 pcs)', 'Home & Kitchen', 24.99),
(14, 'Electric Kettle - 1.7L', 'Home & Kitchen', 34.90),
(15, 'Non-stick Frying Pan - 28cm', 'Home & Kitchen', 18.50),
(16, 'Atomic Habits - James Clear', 'Books', 15.20),
(17, 'Deep Work - Cal Newport', 'Books', 14.35),
(18, 'Rich Dad Poor Dad - Robert Kiyosaki', 'Books', 11.99),
(19, 'LEGO City Police Set', 'Toys', 49.99),
(20, 'Rubiks Cube 3x3', 'Toys', 7.99);

INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate)
VALUES
(1, 1, 2, '2025-04-01'),
(2, 1, 1, '2025-04-05'),
(3, 2, 1, '2025-04-10'),
(4, 2, 2, '2025-04-15'),
(5, 3, 3, '2025-04-18'),
(6, 3, 1, '2025-04-20'),
(7, 4, 2, '2025-04-21'),
(8, 5, 10, '2025-04-22'),
(9, 6, 5, '2025-04-01'),
(10, 6, 3, '2025-04-11'),
(11, 10, 2, '2025-04-08'),
(12, 12, 1, '2025-04-12'),
(13, 12, 3, '2025-04-14'),
(14, 19, 2, '2025-04-05'),
(15, 20, 4, '2025-04-19'),
(16, 1, 1, '2025-03-15'),
(17, 2, 1, '2025-03-10'),
(18, 5, 5, '2025-02-20'),
(19, 6, 6, '2025-01-18'),
(20, 10, 1, '2024-12-25'),
(21, 1, 1, '2024-04-20');

select * from Products
select * from Sales

Select * from Products as p
join Sales as s on p.ProductID = s.ProductID



SELECT 
    s.ProductID,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(s.Quantity * p.Price) AS TotalRevenue
FROM 
    Sales s
JOIN 
    Products p ON s.ProductID = p.ProductID
WHERE 
    YEAR(s.SaleDate) = YEAR(GETDATE())
    AND MONTH(s.SaleDate) = MONTH(GETDATE())
GROUP BY 
    s.ProductID;


CREATE VIEW vw_ProductSalesSummary AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    p.Price,
    ISNULL(SUM(s.Quantity), 0) AS TotalQuantitySold
FROM 
    Products p
LEFT JOIN 
    Sales s ON p.ProductID = s.ProductID
GROUP BY 
    p.ProductID, p.ProductName, p.Category, p.Price;

SELECT * FROM vw_ProductSalesSummary 


Create function n_GetTotalRevenueForProduct (@ProductID INT)
Returns decimal (18,2)
as
begin 
	DECLARE @TotalRevenue DECIMAL(18, 2);

    SELECT @TotalRevenue = SUM(s.Quantity * p.Price)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE s.ProductID = @ProductID;

    -- If there are no sales, return 0 instead of NULL
    RETURN ISNULL(@TotalRevenue, 0);
END;

SELECT dbo.fn_GetTotalRevenueForProduct  AS TotalRevenue;

CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    -- Handle edge cases
    IF @Number <= 1
        RETURN 'No';

    -- 2 is prime
    IF @Number = 2
        RETURN 'Yes';

    -- Even numbers greater than 2 are not prime
    IF @Number % 2 = 0
        RETURN 'No';

    DECLARE @i INT = 3;
    DECLARE @sqrt INT = FLOOR(SQRT(@Number));

    WHILE @i <= @sqrt
    BEGIN
        IF @Number % @i = 0
            RETURN 'No';

        SET @i = @i + 2; -- Check only odd divisors
    END

    RETURN 'Yes';
END;

SELECT dbo.fn_IsPrime(7) AS IsPrime;  -- Returns 'Yes'
SELECT dbo.fn_IsPrime(10) AS IsPrime; -- Returns 'No'

CREATE FUNCTION dbo.fn_GetNumbersBetween
(
    @Start INT,
    @End INT
)
RETURNS TABLE
AS
RETURN
(
    WITH NumbersCTE AS
    (
        SELECT @Start AS Number
        UNION ALL
        SELECT Number + 1
        FROM NumbersCTE
        WHERE Number < @End
    )
    SELECT Number FROM NumbersCTE
);

SELECT * FROM dbo.fn_GetNumbersBetween(1, 10);


SELECT TOP 1 id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id FROM RequestAccepted
) AS all_friends
GROUP BY id
ORDER BY num DESC;


SELECT id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id FROM RequestAccepted
) AS all_friends
GROUP BY id
ORDER BY num DESC


CREATE TABLE Gaps
(
RowNumber   INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NULL
);

INSERT INTO Gaps (RowNumber, TestCase) VALUES
(1,'Alpha'),(2,NULL),(3,NULL),(4,NULL),
(5,'Bravo'),(6,NULL),(7,'Charlie'),(8,NULL),(9,NULL);


SELECT
  RowNumber,
  -- Forward fill the last known non-null Workflow using MAX with windowing
  MAX(Workflow) OVER (
    ORDER BY RowNumber
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS Workflow
FROM Workflows;
