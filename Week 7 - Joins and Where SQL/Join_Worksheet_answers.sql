-- -- Join Worksheet Answers -- --

-- -----------------------------
-- Completion Questions
-- -----------------------------

-- -- Question 1:
-- List the job title and minimum salary for every job where the minimum salary is more than 10,000.
-- Combine the output with every country the company operates in.
SELECT job_title AS "Job Title", min_salary AS "Minimum Salary", country_name AS "Country"
FROM Jobs 
JOIN Countries
WHERE min_salary > 10000
ORDER BY country_name ASC, job_title ASC;

-- -- Question 2: List the full address of every location, including the country name.
SELECT street_address AS "Street Address", postal_code AS "Postal Code", city AS "City", country_name AS "Country"
FROM Locations
CROSS JOIN Countries
	USING(country_id)
ORDER BY street_address ASC, city ASC, country_name ASC;

-- -- Question 3: List the name, city and country of every department.
SELECT department_name, city, country_name 
FROM Departments 
INNER JOIN Locations
	USING (location_id)
INNER JOIN Countries 
	USING (country_id)
ORDER BY department_name ASC, city ASC, country_name ASC;

-- -- Question 4: List the department ID, name and manager name for every department.
SELECT d.department_id, department_name, CONCAT(first_name, " ", last_name) AS Manager
FROM Departments AS d 

INNER JOIN Employees AS e 
	ON e.department_id = d.department_id
	AND d.manager_id = e.employee_id -- job_id LIKE "%_MAN"
ORDER BY d.department_id ASC, Manager ASC;

-- -- Question 5: List every pair of employees working in the same department, but only list each pair once.
-- Order the results by department ID then by the surname of the first employee and then the surname of the second employee.
SELECT e.department_id, 
   CONCAT(e.first_name, ' ', e.last_name) AS Employee, 
   CONCAT(c.first_name, ' ', c.last_name) AS Colleague 
FROM Employees AS e
INNER JOIN Employees AS c 
	USING(department_id)
    WHERE e.employee_id < c.employee_id
ORDER BY e.department_id, e.last_name, c.last_name;

-- -- Question 6: 
-- List every employee, their department name and manager name.
-- If they have no manager or department, still include them.
SELECT CONCAT(e.first_name, " ", e.last_name) AS "Employee Name" , d.department_name, CONCAT(m.first_name, " ", m.last_name) AS "Manager Name"
FROM Employees AS e  -- , Departments AS d
LEFT OUTER JOIN Employees AS m
	ON e.manager_id = m.employee_id
    -- AND e.department_id = m.department_id
LEFT OUTER JOIN Departments AS d
	ON e.department_id = d.department_id
ORDER BY d.department_name ASC , e.first_name ASC;

-- -- Question 7: List the details for all jobs with the letters “ing” in the title.
SELECT *
FROM Jobs
WHERE job_title LIKE "%ing %"
ORDER BY job_title ASC;

-- -- Question 8: List the information about employees who have left the company (i.e. have an end date).
SELECT CONCAT(e.last_name, " ", e.first_name) AS "Employee Name" , jh.start_date AS "Date Employed" , jh.end_date AS "Leaving Date"
FROM Employees AS e
INNER JOIN Job_History AS jh
	USING (employee_id)
ORDER BY e.last_name ASC, jh.start_date ASC;


-- -----------------------------
-- Deliberate Pracice Questions
-- -----------------------------

-- -- Question 1: List the names of all employees and their job titles, ordered alphabetically by surname.
SELECT CONCAT(e.last_name, " ", e.first_name) AS "Employee Name" , j.job_title
FROM Employees AS e
INNER JOIN Jobs AS j
	USING(job_id)
ORDER BY j.job_title ASC;

-- -- Question 2: List the names of the three employees with the highest potential salary and their job title.
SELECT CONCAT(e.last_name, " ", e.first_name) AS "Employee Name" , j.job_title, j.max_salary
FROM Employees AS e
INNER JOIN Jobs AS j
	USING(job_id)
ORDER BY j.max_salary DESC, j.job_title ASC
LIMIT 3;

-- -- Question 3:
-- The HR department wants a list of all employees who were hired after their managers.
-- Produce a query that shows the names and hire dates of managers and the employees who they manage.
-- Only show employees who were hired after their managers.

SELECT CONCAT(m.last_name, " ", m.first_name) AS "Manager Name" , m.hire_date AS "Date Hired", CONCAT(e.last_name, " ", e.first_name) AS "Employee Name", e.hire_date AS "Date Hired"
FROM Employees AS e
INNER JOIN Employees AS m
	ON e.manager_id = m.employee_id
    AND e.hire_date > m.hire_date
ORDER BY m.hire_date ASC , m.last_name ASC , e.hire_Date ASC , e.last_name ASC;

-- -- Question 4:
-- List the job titles and names of employees who used to hold those positions, including their start and end dates.
-- Where nobody has ever held that position only list the job titles and where the position is still being filled list the job title, employee name and start date.
-- Give the results in order of job title.

