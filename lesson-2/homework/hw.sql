create database SQL_class_2_home_work

use SQL_class_2_home_work

create table Employees (EmpID int, name varchar(50), salary decimal (10,2))


insert into Employees values (1,'John',23.99),(2, 'Tom', 25.12),(3,'Jack', 31.12)

select * from Employees


update Employees
set salary=24
where EmpID=1


delete from Employees
where EmpID= '2' 


--DELETE- Deletes specific rows based on condition
--DROP-Deletes the entire table or database
--TRUNCATE- Deletes all rows but retains table structure



alter table Employees
alter column name varchar(10)



alter table Employees 
add department varchar(100)


alter table Employees
alter column salary float 



create table Departments (DepartmentID int , DepartmentName varchar(50))
select*from Departments



truncate table Employees 


insert into Employees values (1,'John',23.99),(2, 'Tom', 25.12),(3,'Jack', 31.12)
