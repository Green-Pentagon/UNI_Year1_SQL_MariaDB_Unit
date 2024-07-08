-- -- WHERE Document questions -- --

-- Completion Problems --
-- -- Question 1: List the departments ordered by their location ID in ascending order.
SELECT location_id AS "Location ID" , department_id AS "Department ID" , department_name AS "Name"
FROM Departments
ORDER BY location_id ASC;

-- -- Question 2: List all the job titles starting with the letter S.
SELECT job_title AS "Jobs starting with S"
FROM Jobs
WHERE  job_title LIKE "S%"	-- SUBSTRING(job_title FROM 1 FOR 1) = "S"
ORDER BY  job_title ASC; 	-- SUBSTRING(job_title FROM 2 FOR 1) ASC;

-- -- Question 3: List the regions the company operates in, giving the column name “Regions Company Operates In”.
SELECT region_name AS "Regions Cowopany Operates In"
FROM Regions
ORDER BY region_name ASC;

-- -- Question 4: List all the employees who earn a bonus
SELECT CONCAT(last_name , " " , first_name) AS "Employee Name" , bonus AS "Income Bonus"
FROM Employees
WHERE bonus IS NOT NULL
ORDER BY last_name ASC;

-- -- Question 5: List all employees earning between 5000 and 9000 inclusive, ordered by their salary in ascending order.
SELECT CONCAT(last_name , " " , first_name) AS "Employee Name" , salary AS "Salary"
FROM Employees
WHERE salary BETWEEN 5000 AND 9000
ORDER BY salary ASC;

-- -- Question 6: List all the employees who are managed by someone with manager ID of 100, 149 or 124.
SELECT CONCAT(last_name , " " , first_name) AS "Employee Name" , manager_id AS "Manager ID"
FROM Employees
WHERE manager_id IN (100,149,124)
ORDER BY last_name ASC;

-- -- Question 7: List all the department details ordered by the manager ID.
SELECT department_id AS "Department Name", department_name AS "Department Name" , manager_id AS "Manager ID", location_id AS "Location ID"
FROM Departments
ORDER BY manager_id ASC;

-- -- Question 8: List the employees whose last names begin with K. Put everything in lower case.
SELECT LOWER(CONCAT(last_name , " " , first_name)) AS "Employee Name"
FROM Employees
WHERE last_name LIKE "K%"
ORDER BY last_name ASC;

-- -- Question 9: List all the jobs where the range of possible salaries is greater than 4000. Order them by the range of salaries from largest to smallest.
SELECT job_title AS "Job Title" , (max_salary - min_salary) AS "Salary Range"
FROM Jobs
WHERE (max_salary - min_salary) > 4000
ORDER BY (max_salary - min_salary) DESC;
-- For some reason, I am unable to refer to the Salary range string as a variable, it would require me to not use the asteriks

-- Delibrate Practise --
-- -- Question 1: List the employees whose phone numbers start with “515”
SELECT CONCAT(last_name , " " , first_name) AS "Employee Name" , phone_number AS "Phone Number"
FROM Employees
WHERE phone_number LIKE "515%"
ORDER BY last_name ASC;

-- -- Question 2: List the regions in in alphabetical order
SELECT region_name AS "Region Name"
FROM Regions
ORDER BY region_name ASC;

-- -- Question 3: List the locations of the company outside the US, ordered alphabetically by city name
SELECT location_id AS "Location ID" , street_address AS "Street Address", postal_code AS "Postal Code" , city AS "City" , state_province AS "State Province" , country_id AS "Country ID"
FROM Locations
WHERE country_id NOT LIKE "US"
ORDER BY city ASC;

-- -- Question 4: List the employees by how long they have worked at the company
SELECT CONCAT(last_name , " " , first_name) AS "Employee Name", hire_date AS "Date Hired"
FROM Employees
ORDER BY hire_date ASC;

-- -- Question 5: List the reps in order of their surname, but keeping those in the same job together.
SELECT CONCAT(last_name , " " , first_name) AS "Employee Name", job_id AS "Job ID"
FROM Employees
WHERE job_id LIKE "%_REP"
ORDER BY job_id ASC, last_name ASC;

-- -- Question 6: List the employees whose full name (first name and surname including the space between them) contains fewer than 12 characters.
SELECT CONCAT(last_name , " " , first_name) AS "Employee Name"
FROM Employees
WHERE LENGTH(CONCAT(last_name , " " , first_name)) < 12
ORDER BY last_name ASC;

-- -- Question 7: List the employee IDs of workers who are no longer with the company and how many years they worked at the company.
SELECT employee_id AS "Employee ID" , start_date AS "Start Date" , end_date AS "End Date" , TIMESTAMPDIFF(YEAR, start_date, end_date) AS "Years Employed"
FROM Job_History
ORDER BY end_date ASC, employee_id ASC;

-- -- Question 8: List the names of the employees hired in the 2010s.
SELECT CONCAT(last_name , " " , first_name) AS "Employee Name" , hire_date AS "Date Hired"
FROM Employees
WHERE hire_date > "2009-12-31"
ORDER BY hire_date ASC, last_name ASC;

-- -- Question 9: List the names of the six lowest-paid employees.
SELECT CONCAT(last_name , " " , first_name) AS "Employee Name" , salary AS "Salary"
FROM Employees
ORDER BY salary ASC, last_name ASC
LIMIT 6;

-- -- Question 10:
-- List the names of the employees receiving a bonus as well as what percentage of their salary their bonus is.
-- Give the percentage to two decimal places and include the percentage sign.
-- Order the results by the percentage from lowest to highest.
SELECT  CONCAT(last_name , " " , first_name) AS "Employee Name" , salary AS "Salary" , bonus AS "Bonus", CONCAT(ROUND( (bonus/salary) * 100, 2) , "%") AS "Bonus as % of Salary"
FROM Employees
WHERE bonus IS NOT NULL
ORDER BY (bonus/salary) ASC , last_name ASC;