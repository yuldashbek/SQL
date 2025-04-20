create database SQL_class_2_home_work

use SQL_class_2_home_work
--1

create table Employees (EmpID int, name varchar(50), salary decimal (10,2))

--2

insert into Employees values (1,'John',23.99),(2, 'Tom', 25.12),(3,'Jack', 31.12)

select * from Employees

--3

update Employees
set salary=24
where EmpID=1

 --4

delete from Employees
where EmpID= '2' 

--5

--DELETE- Deletes specific rows based on condition
--DROP-Deletes the entire table or database
--TRUNCATE- Deletes all rows but retains table structure

--6

alter table Employees
alter column name varchar(10)


--7

alter table Employees 
add department varchar(100)

--8 
alter table Employees
alter column salary float 

--9 

create table Departments (DepartmentID int , DepartmentName varchar(50))
select*from Departments

--10

truncate table Employees 

--11
insert into Employees values (1,'John',23.99),(2, 'Tom', 25.12),(3,'Jack', 31.12)
-------------------------------------------------------------------------------------------------------------------------------------

Create table Employees (EmpID INT, Name VARCHAR(50), Salary DECIMAL(10,2))
Insert into Employees values (1,'John',23.99),(2, 'Tom', 25.12),(3,'Jack', 31.12)
select * from Employees;

Update Employees
set salary=24
Where EmpID=1;

Delete Employees 
Where EmpID=2;

DELETE- Deletes specific rows based on condition
DROP-Deletes the entire table or database
TRUNCATE- Deletes all rows but retains table structure;

alter table Employees
alter column name varchar(100);

alter table Employees 
add department varchar(50);

alter table Employees
alter column salary float 

create table Departments (DepartmentID int , DepartmentName varchar(50))
select*from Departments

truncate table Employees 


insert into Departments values (1,'Law'), (2, 'HR'), (3, 'Accounting'), (4, 'IT'), (5, 'Finance')


select * from Departments

UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;


DELETE FROM Employees;

ALTER TABLE Employees
DROP COLUMN Department;

EXEC sp_rename 'Employees', 'StaffMembers';

DROP TABLE Departments;

Create table Product (ProductID int Primary Key, ProductName VARCHAR(50), Category VARCHAR(50), Price DECIMAL(10, 2))

ALTER TABLE Product
ADD CONSTRAINT CHK_Price_Greater_Than_Zero
CHECK (Price > 0);

Alter TABLE Product
ADD StockQuantity INT DEFAULT 50;


insert into Product values (1, 'Laptop', 'Electronics', 800) , (2, 'Smartphone', 'Electronics', 600) , (3, 'Chair', 'Furniture', 100) , (4, 'Shirt', 'Clothing', 500) , (5, 'Coke', 'Drinks', 10)

SELECT *
INTO Products_Backup
FROM Product;

ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;

ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000, 5);
