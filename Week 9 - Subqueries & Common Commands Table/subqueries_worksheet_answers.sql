-- -- Suqbeueries Worksheet -- --

-- COMMON COMMANDS --
WITH employee_name AS (SELECT CONCAT(first_name , " " , last_name) AS ConcName FROM Employees AS e0) -- Unsure how to connect it with an SQL statement below within a Select Statement
-- ------------------


-- Completion Problems --

-- Question 1:  List the employees who earn more than the average salary in every department.
SELECT CONCAT(first_name , " " , last_name) AS "Employee Name", e1.salary AS "Employee Salary"
FROM Employees AS e1
WHERE e1.salary > (SELECT AVG(e2.salary) AS SalaryAverage FROM Employees AS e2)
ORDER BY e1.salary ASC, first_name  ASC;

-- Question 2:  List the employees who have worked at the company for longer than the average.
SELECT CONCAT(first_name , " " , last_name) AS "Employee Name", (TIMESTAMPDIFF(DAY, e1.hire_date, CURDATE() )) AS DaysWorked
FROM Employees AS e1
HAVING DaysWorked > (SELECT AVG( TIMESTAMPDIFF(DAY , end_date , start_date ) ) AS AverageTimeWorked FROM Job_History)
ORDER BY DaysWorked ASC, first_name ASC;

SELECT AVG( TIMESTAMPDIFF(DAY , start_date , end_date ) ) AS AverageTimeWorked FROM Job_History;

-- Question 3:  List the employees where the length of their department name is below average.
SELECT CONCAT(e1.first_name , " " , e1.last_name) AS "Employee Name" , d1.department_name
FROM Employees AS e1
INNER JOIN Departments AS d1
USING (department_id)
HAVING (LENGTH(d1.department_name)) < (SELECT AVG(LENGTH(department_name)) FROM Departments);

-- Question 4:  List the departments where the average salary in that department is greater than 5000.
SELECT d1.department_name AS DepartmentName, e1.salary AS DepartmentSalary
FROM Employees AS e1
INNER JOIN Departments AS d1
USING (department_id)
GROUP BY DepartmentName -- Aggregates inner join values
HAVING DepartmentSalary > 5000 -- (SELECT AVG(salary) FROM Employees)
ORDER BY DepartmentSalary ASC, DepartmentName ASC;

-- Question 5:  List the departments whose average salary is above the average of all employees.
SELECT d1.department_name AS DepartmentName, e1.salary AS DepartmentSalary
FROM Employees AS e1
INNER JOIN Departments AS d1
USING (department_id)
GROUP BY DepartmentName -- Aggregates inner join values
HAVING DepartmentSalary > (SELECT AVG(salary) FROM Employees)
ORDER BY DepartmentSalary ASC, DepartmentName ASC;

-- Question 6:  List the employees whose salary is greater than the average salary among employees whose surnames end in the letter ‘s’.
-- List Employees which:
	-- Salary greater than:
		-- Average Salary of employees which:
			-- Have a trailing S in surname
SELECT CONCAT(first_name , " " , last_name) AS "Employee Name", salary AS EmployeeSalary
FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees WHERE last_name LIKE "%s")
ORDER BY EmployeeSalary ASC, first_name ASC;

SELECT AVG(salary) FROM Employees WHERE last_name LIKE "%s";

-- Question 7:  List all the employees and their bonuses. For those without a bonus, show the average bonus instead.
SELECT CONCAT(first_name , " " , last_name) AS "Employee Name", IFNULL(bonus ,ROUND((SELECT AVG(bonus) FROM Employees), 2) ) AS SalaryBonus
FROM Employees
ORDER BY SalaryBonus ASC, first_name ASC;

SELECT AVG(bonus) FROM Employees;

-- Question 8:  Generate a list of every employees’ initials
SELECT CONCAT(SUBSTRING(first_name FROM 1 FOR 1) , "." , SUBSTRING(last_name FROM 1 FOR 1), ".") AS EmployeeInitials
FROM Employees
ORDER BY EmployeeInitials ASC;

-- Question 9:  List the countries with at least three employees working in it.

-- employees work in departments
-- departments are in locations
-- locations are in countries
-- get the number of employees in every department
-- get the number of departments in every country

SELECT country_name, COUNT(*) AS NumberOfEmployees
FROM Countries
INNER JOIN Locations USING(country_id)
INNER JOIN Departments USING(location_id)
INNER JOIN Employees USING(department_id)
GROUP BY country_name
HAVING NumberOfEmployees > 2;

-- Question 10: List the employees whose names (first name and surname combined) are longer than the average.
SELECT CONCAT(first_name , " " , last_name) AS EmployeeName , LENGTH(CONCAT(first_name, last_name)) AS "Name Length"
FROM Employees
HAVING (LENGTH(EmployeeName)-1) > (SELECT ROUND(AVG(LENGTH(CONCAT(first_name,last_name))),0) FROM Employees);

SELECT ROUND(AVG(LENGTH(CONCAT(first_name,last_name))),0) FROM Employees;

-- Question 11: List every employee, their department name, salary and the difference between their salary and the lowest in their department.
-- List Employee name
-- their salary
-- their department
-- their salary
-- difference from lowest salary in department and their salary
SELECT first_name, last_name, department_name, salary -- , salary - PLACEHOLDER AS Difference
FROM Employees AS e1
INNER JOIN Departments AS d1 on e1.department_id = Departments.department_id
-- WHERE (d1.department_id, salary) ALL(THE SUBQUERY STATEMENT) this could work if you needed to find employees with the lowest salary
ORDER BY department_name, salary;

SELECT department_id, MIN(salary)
FROM Employees
INNER JOIN Departments
USING (department_id)
GROUP BY department_name;


-- Deliberate Practise --

-- Question 1:  List the employees earning more than the mid-range for their job.
-- Question 2:  List the employees earning the most in each department.
-- Question 3:  For each telephone group (i.e. they share the same first six digits), give the average salary of the group.
-- Question 4:  List the average salary of departments whose average is above the company-wide average
-- Question 5:  List the employees earning more than half of their manager’s salary. 
-- Question 6:  List all employees, their salaries and the difference between their salary and the average salary for their department.
-- Question 7:  List the employees who earn less than half of the average salary. Order them by how much their salary is below the maximum salary for their job.
-- Question 8:  List the top three departments with the highest spread of actual wages
-- Question 9:  CHALLENGE! List, for each employee, what their annual salary would be if they received an end of year bonus equal to the average of the bonuses paid out to those who receive them.
-- Question 10: CHALLENGE! List the employees earning the most of those hired in the same year as they were.