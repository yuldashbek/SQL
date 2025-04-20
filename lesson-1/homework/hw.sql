Data refers to raw facts or figures that have no meaning on their own. Examples include numbers, text, dates, or observations. When organized, data becomes meaningful and useful for analysis or decision-making.
A database is an organized collection of data that is stored and accessed electronically. It allows for efficient storage, retrieval, and management of information. Databases can store everything from simple lists to complex sets of interrelated information.
A relational database is a type of database that stores data in tables, which are related to each other through keys (like primary and foreign keys). It uses Structured Query Language (SQL) for managing and querying data. Example systems: MySQL, PostgreSQL, Oracle.
A table is a structured set of data in a relational database, organized in rows and columns. Each table typically represents a specific entity (like Customers, Orders, or Products), where:

Rows = individual records

Columns = attributes or fields of the records

1. Relational Database Management
SQL Server is a relational database management system (RDBMS), meaning it stores data in tables with defined relationships, allowing for efficient data storage, retrieval, and integrity.

2. T-SQL (Transact-SQL) Support
SQL Server uses T-SQL, an extended version of SQL that includes procedural programming, variables, error handling, and more powerful queries.

3. Security Features
SQL Server offers robust security, including:

Authentication and authorization

Role-based access control

Transparent Data Encryption (TDE)

Always Encrypted to protect sensitive data

4. High Availability and Disaster Recovery (HA/DR)
Features like:

Always On Availability Groups

Database Mirroring

Failover Clustering

Help ensure data is accessible and protected against failure.

5. Integration and BI Tools
SQL Server includes tools for Business Intelligence and data integration, such as:

SQL Server Integration Services (SSIS) – for ETL processes

SQL Server Reporting Services (SSRS) – for reporting

SQL Server Analysis Services (SSAS) – for OLAP and data mining

Create database SchoolDB

Create table Students (StudentID INT PRIMARY KEY, Name VARCHAR(50), Age INT) 

 1. SQL Server
What it is: A Relational Database Management System (RDBMS) developed by Microsoft.

Purpose: Stores, manages, and retrieves data using databases and tables.

Think of it as: The engine or backend where your data lives and is processed.

 2. SSMS (SQL Server Management Studio)
What it is: A graphical user interface (GUI) tool developed by Microsoft.

Purpose: Allows developers and DBAs to connect to SQL Server, run queries, manage databases, configure security, and more.

Think of it as: The dashboard or control panel used to interact with SQL Server.

 3. SQL (Structured Query Language)
What it is: A programming language used to query, insert, update, and manage data in relational databases.

Purpose: Allows you to communicate with databases.

Think of it as: The language you use to talk to SQL Server (and other RDBMS like MySQL, PostgreSQL, etc.).

1. DQL – Data Query Language
Purpose: Retrieve data from the database.

Key Command: SELECT

 Example:
sql
Копировать
Редактировать
SELECT * FROM Customers WHERE Country = 'USA';
Gets all customers from the USA.

2.DML – Data Manipulation Language
Purpose: Manipulate data stored in tables.

Key Commands: INSERT, UPDATE, DELETE

 Examples:
sql
Копировать
Редактировать
-- Insert new data
INSERT INTO Products (ProductName, Price) VALUES ('Keyboard', 49.99);

-- Update existing data
UPDATE Products SET Price = 59.99 WHERE ProductName = 'Keyboard';

-- Delete data
DELETE FROM Products WHERE ProductName = 'Keyboard';

DDL – Data Definition Language
Purpose: Define or modify the database structure (tables, schemas, etc.)

Key Commands: CREATE, ALTER, DROP, TRUNCATE
Examples:
sql
Копировать
Редактировать
-- Create a new table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT
);

-- Add a column
ALTER TABLE Orders ADD OrderDate DATE;

-- Delete a table
DROP TABLE Orders;

4.DCL – Data Control Language
Purpose: Control access and permissions to data.

Key Commands: GRANT, REVOKE
 Examples:
sql
Копировать
Редактировать
-- Grant SELECT permission
GRANT SELECT ON Products TO user1;

-- Revoke permission
REVOKE SELECT ON Products FROM user1;

TCL – Transaction Control Language
Purpose: Manage changes made by DML statements; ensures data integrity.

Key Commands: COMMIT, ROLLBACK, SAVEPOINT

 Examples:
sql
Копировать
Редактировать
-- Start a transaction
BEGIN TRANSACTION;

-- Make changes
UPDATE Accounts SET Balance = Balance - 100 WHERE AccountID = 1;
UPDATE Accounts SET Balance = Balance + 100 WHERE AccountID = 2;

-- Commit the transaction
COMMIT;

-- Or undo if something goes wrong
ROLLBACK;

Create table Students (StudentID INT PRIMARY KEY, Name VARCHAR(50), Age INT) 
Insert into Students (StudentID, Name, Age) Values (1, 'John' ,18),(2, 'Anna', 17), (3, 'Bob',19)
select * from students

