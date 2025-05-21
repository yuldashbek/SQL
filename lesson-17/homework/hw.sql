
DROP TABLE IF EXISTS #RegionSales;
GO
CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);

select * from #RegionSales

WITH Regions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
Distributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
),
AllCombinations AS (
    SELECT r.Region, d.Distributor
    FROM Regions r
    CROSS JOIN Distributors d
)

SELECT
    ac.Region,
    ac.Distributor,
    ISNULL(rs.Sales, 0) AS Sales
FROM AllCombinations ac
LEFT JOIN #RegionSales rs
    ON ac.Region = rs.Region AND ac.Distributor = rs.Distributor
ORDER BY ac.Distributor, ac.Region;


CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);

select * from Employee

SELECT e1.name
FROM Employee e1
JOIN Employee e2 ON e1.id = e2.managerId
GROUP BY e1.id, e1.name
HAVING COUNT(e2.id) > 4;


CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);




with cte as (
Select
	Product_id,
Sum(unit) as total_units
from Orders
group by Product_id
)
Select 
p.Product_Name,
cte.total_units
from cte
join Products as p on p.product_id = cte.product_id


SELECT 
    p.product_name,
    SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;


CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');

select * from Orders

Select 
	CustomerID,
	Vendor,
	Sum(Count)
from orders
group by vendor




WITH VendorTotals AS (
  SELECT
    CustomerID,
    Vendor,
    SUM([Count]) AS TotalAmount
  FROM Orders
  GROUP BY CustomerID, Vendor
),
RankedVendors AS (
  SELECT
    CustomerID,
    Vendor,
    RANK() OVER (PARTITION BY CustomerID ORDER BY TotalAmount DESC) AS rk
  FROM VendorTotals
)
SELECT CustomerID, Vendor
FROM RankedVendors
WHERE rk = 1;


CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');

WITH LocationStats AS (
  SELECT
    Device_id,
    Locations,
    COUNT(*) AS signal_count
  FROM Device
  GROUP BY Device_id, Locations
),
MaxLocation AS (
  SELECT
    Device_id,
    Locations AS max_signal_location,
    RANK() OVER (PARTITION BY Device_id ORDER BY signal_count DESC) AS rk
  FROM LocationStats
),
DeviceSummary AS (
  SELECT
    Device_id,
    COUNT(DISTINCT Locations) AS no_of_location,
    SUM(signal_count) AS no_of_signals
  FROM LocationStats
  GROUP BY Device_id
)
SELECT
  ds.Device_id,
  ds.no_of_location,
  ml.max_signal_location,
  ds.no_of_signals
FROM DeviceSummary ds
JOIN MaxLocation ml
  ON ds.Device_id = ml.Device_id
WHERE ml.rk = 1;


CREATE TABLE Employee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);

select * from Employee

WITH DeptAvgSalary AS (
  SELECT
    DeptID,
    AVG(Salary) AS AvgSalary
  FROM Employee
  GROUP BY DeptID
)

SELECT
  e.EmpID,
  e.EmpName,
  e.Salary
FROM Employee e
JOIN DeptAvgSalary d
  ON e.DeptID = d.DeptID
WHERE e.Salary > d.AvgSalary;


CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);

select * from Spending

WITH PlatformSpending AS (
  SELECT
    User_id,
    Spend_date,
    MAX(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) AS Mobile,
    MAX(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) AS Desktop,
    SUM(Amount) AS Total_Amount
  FROM Spending
  GROUP BY User_id, Spend_date
),
LabeledSpending AS (
  SELECT
    Spend_date,
    CASE
      WHEN Mobile = 1 AND Desktop = 1 THEN 'Both'
      WHEN Mobile = 1 AND Desktop = 0 THEN 'Mobile'
      WHEN Mobile = 0 AND Desktop = 1 THEN 'Desktop'
    END AS Platform,
    Total_Amount,
    User_id
  FROM PlatformSpending
),
AggregatedSpending AS (
  SELECT
    Spend_date,
    Platform,
    COUNT(DISTINCT User_id) AS Total_users,
    SUM(Total_Amount) AS Total_Amount
  FROM LabeledSpending
  GROUP BY Spend_date, Platform
),
AllDates AS (
  SELECT DISTINCT Spend_date FROM Spending
),
AllPlatforms AS (
  SELECT 'Mobile' AS Platform
  UNION ALL
  SELECT 'Desktop'
  UNION ALL
  SELECT 'Both'
),
AllCombinations AS (
  SELECT d.Spend_date, p.Platform
  FROM AllDates d CROSS JOIN AllPlatforms p
)
SELECT
  ROW_NUMBER() OVER (ORDER BY a.Spend_date, 
                     CASE a.Platform
                       WHEN 'Mobile' THEN 1
                       WHEN 'Desktop' THEN 2
                       WHEN 'Both' THEN 3
                     END) AS Row,
  a.Spend_date,
  a.Platform,
  COALESCE(s.Total_Amount, 0) AS Total_Amount,
  COALESCE(s.Total_users, 0) AS Total_users
FROM AllCombinations a
LEFT JOIN AggregatedSpending s
  ON a.Spend_date = s.Spend_date AND a.Platform = s.Platform
ORDER BY a.Spend_date,
         CASE a.Platform
           WHEN 'Mobile' THEN 1
           WHEN 'Desktop' THEN 2
           WHEN 'Both' THEN 3
         END;

CREATE TABLE DeGrouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
INSERT INTO DeGrouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);

WITH RECURSIVE DeGrouped AS (
  SELECT Product, 1 AS Quantity, Quantity AS Original_Quantity
  FROM Grouped
  WHERE Quantity > 0

  UNION ALL

  SELECT Product, 1, Original_Quantity - 1
  FROM DeGrouped
  WHERE Original_Quantity > 1

)
SELECT Product, Quantity
FROM DeGrouped
ORDER BY Product;
