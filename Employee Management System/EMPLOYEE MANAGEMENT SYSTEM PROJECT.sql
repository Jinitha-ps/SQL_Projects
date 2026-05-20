-- =====================================
-- EMPLOYEE MANAGEMENT SYSTEM PROJECT
-- =====================================

-- Create Database
CREATE DATABASE employee_management;
USE employee_management;

-- =====================================
-- CREATE TABLES
-- =====================================

-- Departments Tables
CREATE TABLE departments(
dept_id INT PRIMARY KEY,
dept_name VARCHAR(50)
);

-- Employee Table
CREATE TABLE employees(
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
gender VARCHAR(25),
age INT,
city VARCHAR(50),
Joining_date DATE,
dept_id INT,
salary DECIMAL(10,2),
FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Attendence Table
CREATE TABLE attendence(
attendence_id INT PRIMARY KEY,
emp_id INT,
attendence_date DATE,
status VARCHAR(50),
FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- Project Table
CREATE TABLE projects(
project_id INT PRIMARY KEY,
project_name VARCHAR(50),
emp_id INT,
start_date DATE,
end_date DATE,
FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- =====================================
-- INSERT DATA
-- =====================================

-- Insert Departments Data
INSERT INTO departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

-- Insert Employees Data
INSERT INTO employees VALUES
(101, 'Rahul', 'Male', 28, 'Mumbai', '2022-01-15', 1, 60000),
(102, 'Anjali', 'Female', 25, 'Delhi', '2021-03-10', 2, 45000),
(103, 'Arun', 'Male', 30, 'Chennai', '2020-07-20', 1, 75000),
(104, 'Sneha', 'Female', 27, 'Bangalore', '2023-02-01', 3, 50000),
(105, 'Vijay', 'Male', 35, 'Hyderabad', '2019-11-11', 4, 65000),
(106, 'Meera', 'Female', 29, 'Pune', '2022-09-05', 1, 70000),
(107, 'Kiran', 'Male', 31, 'Kochi', '2021-06-18', 2, 48000),
(108, 'Divya', 'Female', 26, 'Trivandrum', '2023-01-12', 4, 52000);

-- Insert attendence Data
INSERT INTO attendance VALUES
(1, 101, '2026-05-01', 'Present'),
(2, 102, '2026-05-01', 'Absent'),
(3, 103, '2026-05-01', 'Present'),
(4, 104, '2026-05-01', 'Present'),
(5, 105, '2026-05-01', 'Absent'),
(6, 106, '2026-05-01', 'Present'),
(7, 107, '2026-05-01', 'Present'),
(8, 108, '2026-05-01', 'Absent');

-- Insert Project Data
INSERT INTO projects VALUES
(201, 'Website Development', 101, '2026-01-01', '2026-06-30'),
(202, 'HR Automation', 102, '2026-02-15', '2026-07-15'),
(203, 'Finance Dashboard', 104, '2026-03-01', '2026-08-30'),
(204, 'Marketing Campaign', 105, '2026-01-20', '2026-05-25'),
(205, 'Mobile App', 106, '2026-04-01', '2026-12-31');

-- 1. Display All Employees
SELECT * FROM employees

-- 2. Employees Working in IT Department
SELECT e.emp_name, d.dept_name
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
WHERE d.dept_name = 'IT';

-- 3. Highest Salary Employee
SELECT emp_name, salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);

-- 4. Department Wise Employee Count
SELECT d.dept_name,
COUNT(e.emp_id) AS total_employees
FROM departments d
LEFT JOIN employees e
ON d.dept_id=e.dept_id
GROUP BY dept_name;

-- 5. Average Salary by Department
SELECT d.dept_name,
AVG(e.salary) AS average_salary
FROM employees e
JOIN departments d
ON e.dept_id=d.dept_id
GROUP BY d.dept_name;

-- 6. Employees with Salary Greater Than 60000
SELECT emp_name, salary
FROM employees
WHERE salary>60000;

-- 7. Employees Joined After 2021
SELECT emp_name, joining_date
FROM employees
Where joining_date> '2021-12-31'

-- 8. Count Male and Female Employees
SELECT gender,
COUNT(*) AS total
FROM employees
GROUP BY gender;

-- 9. Employees with Their Project Names
SELECT e.emp_name,
p.project_name
FROM employees e
JOIN projects p
ON e.emp_id = p.emp_id;

-- 10. Employees Who Were Absent
SELECT e.emp_name,
a.status
FROM employees e
JOIN attendence a
ON e.emp_id = a.emp_id
WHERE a.status = 'Absent';

-- 11. Total Salary Expense
SELECT SUM(salary) AS total_salary
FROM employees

-- 12. Top 3 Highest Paid Employees
SELECT emp_name, salary
FROM employees
ORDER BY SALARY DESC
LIMIT 3;

-- 13. Employees From Chennai
SELECT emp_name, city
FROM employees
WHERE city = 'Chennai';

-- 14. Number of Employees in Each City
SELECT city,
COUNT(*) AS total_employees
FROM employees
GROUP BY city;

-- 15. Employees Not Assigned to Any Project
SELECT emp_name
FROM employees
WHERE emp_id NOT IN (
    SELECT emp_id
    FROM projects
);


-- =====================================
-- VIEW
-- =====================================
CREATE VIEW employee_details AS
SELECT e.emp_id,
e.emp_name,
d.dept_name,
e.salary
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id;
SELECT * FROM employee_details;


