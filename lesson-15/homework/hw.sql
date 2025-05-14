create database homework_14
go 
use homework_14

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000);


;with minsalary as(
Select min(salary) as min_salary
from employees
)
Select * 
From employees
where salary = (Select min_salary from MinSalary)


CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products (id, product_name, price) VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 400),
(3, 'Smartphone', 800),
(4, 'Monitor', 300);



WITH AvgPrice AS (
    SELECT AVG(price) AS avg_price
    FROM products
)
SELECT *
FROM products
WHERE price > (SELECT avg_price FROM AvgPrice);



CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'Sales'),
(2, 'HR');

INSERT INTO employees (id, name, department_id) VALUES
(1, 'David', 1),
(2, 'Eve', 2),
(3, 'Frank', 1);




Select e.id,name, department_name from departments as d
left join
employees as e on d.id = e.department_id
where department_name = 'Sales'


CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, name) VALUES
(1, 'Grace'),
(2, 'Heidi'),
(3, 'Ivan');

INSERT INTO orders (order_id, customer_id) VALUES
(1, 1),
(2, 1);



select c.customer_id,name from customers as c
left join 
orders as o on c.customer_id=o.customer_id
where order_id is null

CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Tablet', 400, 1),
(2, 'Laptop', 1500, 1),
(3, 'Headphones', 200, 2),
(4, 'Speakers', 300, 2);


;with cte as (select 
	category_id,
	max(price) as max_price
from products
group by category_id
)
Select * from products as p
join cte on p.category_id = cte.category_id and p.price=cte.max_price



CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Jack', 80000, 1),
(2, 'Karen', 70000, 1),
(3, 'Leo', 60000, 2);


;WITH AvgSalaries AS (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
),
MaxAvg AS (
    SELECT MAX(avg_salary) AS max_avg_salary
    FROM AvgSalaries
),
TopDepartments AS (
    SELECT department_id
    FROM AvgSalaries
    WHERE avg_salary = (SELECT max_avg_salary FROM MaxAvg)
)
SELECT e.*
FROM employees e
JOIN TopDepartments td ON e.department_id = td.department_id;

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Mike', 50000, 1),
(2, 'Nina', 75000, 1),
(3, 'Olivia', 40000, 2),
(4, 'Paul', 55000, 2);



 with cte as (select 
 department_id,
 AVG(salary) as Avg_Salary from employees
 group by 
 department_id
 )
 Select * from employees as e
 join cte on e.department_id = cte.department_id 
 where e.salary > cte.Avg_Salary


 CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE grades (
    student_id INT,
    course_id INT,
    grade DECIMAL(4, 2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO students (student_id, name) VALUES
(1, 'Sarah'),
(2, 'Tom'),
(3, 'Uma');

INSERT INTO grades (student_id, course_id, grade) VALUES
(1, 101, 95),
(2, 101, 85),
(3, 102, 90),
(1, 102, 80);

select * from students
select * from grades

with MaxGrades as (
Select 
course_id,
Max(grade) as Max_grade
from grades
group by course_id
)
SELECT s.*
FROM grades g
JOIN MaxGrades mg ON g.course_id = mg.course_id AND g.grade = mg.max_grade
JOIN students s ON g.student_id = s.student_id;

CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Phone', 800, 1),
(2, 'Laptop', 1500, 1),
(3, 'Tablet', 600, 1),
(4, 'Smartwatch', 300, 1),
(5, 'Headphones', 200, 2),
(6, 'Speakers', 300, 2),
(7, 'Earbuds', 100, 2);

select * from products


WITH RankedProducts AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS price_rank
    FROM products
)
SELECT *
FROM RankedProducts
WHERE price_rank = 3;


CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Alex', 70000, 1),
(2, 'Blake', 90000, 1),
(3, 'Casey', 50000, 2),
(4, 'Dana', 60000, 2),
(5, 'Evan', 75000, 1);


WITH CompanyAvg AS (
    SELECT AVG(salary) AS avg_salary
    FROM employees
),
DeptMax AS (
    SELECT department_id, MAX(salary) AS max_salary
    FROM employees
    GROUP BY department_id
)
SELECT e.*
FROM employees e
JOIN CompanyAvg c ON e.salary > c.avg_salary
JOIN DeptMax d ON e.department_id = d.department_id AND e.salary < d.max_salary;
