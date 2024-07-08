-- Completion Problems Questions
-- -----------------------------

-- Question 1
-- SELECT employee_id, start_date, end_date
-- FROM Job_History;

-- Question 2
-- SELECT country_id AS 'ID', country_name AS 'Our Operating Countries'
-- FROM Countries

-- Question 3
-- SELECT DISTINCT commission_pct
-- FROM Employees;

-- Question 4
-- SELECT *
-- FROM Departments;

-- Question 5
-- SELECT DISTINCT max_salary
-- FROM Jobs
-- ORDER BY max_salary ASC;

-- Question 6
-- SELECT CONCAT(last_name, ' ', first_name) AS 'Employee Name' , (salary * 1.1) AS '10% pay rise'
-- FROM Employees
-- ORDER BY last_name ASC;

-- Question 7
-- SELECT LOWER(CONCAT(email , '@company.com')) AS 'Employee Email'
-- FROM Employees
-- ORDER BY email ASC;

-- Question 8
-- SELECT location_id , REPLACE(City, 'S', '*') AS 'No capital S'
-- FROM Locations;

-- -----------------------------
-- Deliberate Pracice Questions
-- -----------------------------
-- Question 1: Give the phone numbers of employees but instead of full-stops to separate the groups of numbers, use dashes instead
-- SELECT REPLACE(phone_number , '.' , '-') AS 'Employee Phone Number'
-- FROM Employees
-- ORDER BY phone_number ASC;

-- Question 2: List the employee IDs of the managers
-- SELECT manager_id
-- FROM Employees
-- ORDER BY manager_id ASC;

-- Question 3: Why should you not use a query like SELECT * FROM Employees; in production code?
-- Answer: Because the table structure can change over time, which can cause hard-coded solutions to break.

-- Question 4: For each employee, give their full name and the number of letters in their name
-- SELECT CONCAT(last_name, ' ', first_name) AS 'Employee Name', LENGTH( CONCAT(last_name, first_name) ) AS 'Full Name Length'
-- FROM Employees
-- ORDER BY last_name ASC;

-- Question 5: Use the columns first_name and last_name to generate the values in the email address column
-- SELECT LOWER( CONCAT( SUBSTRING(first_name FROM 1 FOR 1) , last_name , '@company.com') ) AS 'generated email'
-- FROM Employees
-- ORDER BY last_name ASC;

-- Question 6: For every job, list the title and the min and max salaries after first increasing them by 25%
-- SELECT CONCAT(last_name, ' ', first_name) AS 'Employee Name' , min_salary * 1.25 AS 'Minimum Salary (+25%)' , max_salary * 1.25 AS 'Maximum Salary (+25%)'
-- FROM Employees, Jobs
-- WHERE Employees.Job_ID = Jobs.Job_ID -- don't forget to define the FK relationships!
-- ORDER BY last_name ASC;

-- Question 7: For every employee list their full name, hire date and the date exactly 40 years after their initial employment
-- SELECT CONCAT(last_name, ' ', first_name) AS 'Employee Name' , hire_date AS 'Date Employed' , (hire_date + INTERVAL 40 YEAR) AS '40 Years after hire'
-- FROM Employees
-- ORDER BY last_name ASC;
-- -----------------------------