-- Drop all tables if they exist

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Job_History ;
DROP TABLE IF EXISTS Employees ;
DROP TABLE IF EXISTS Jobs ;
DROP TABLE IF EXISTS Departments ;
DROP TABLE IF EXISTS Locations ;
DROP TABLE IF EXISTS Countries ;
DROP TABLE IF EXISTS Regions ;

SET FOREIGN_KEY_CHECKS = 1;


CREATE TABLE  Regions
   (region_id INT PRIMARY KEY,
    region_name VARCHAR(25)
   );
   
CREATE TABLE  Countries
   (country_id CHAR(2) PRIMARY KEY,
    country_name VARCHAR(40),
    region_id INT
   );

ALTER TABLE  Countries ADD CONSTRAINT COUNTR_REG_FK FOREIGN KEY (region_id)
	REFERENCES  Regions (region_id);
   
CREATE TABLE  Locations
   (location_id DECIMAL(4,0) PRIMARY KEY,
    street_address VARCHAR(40),
    postal_code VARCHAR(12),
    city VARCHAR(30) NOT NULL,
    state_province VARCHAR(25),
    country_id CHAR(2)
   );
   
ALTER TABLE  Locations ADD CONSTRAINT LOC_C_ID_FK FOREIGN KEY (country_id)
	REFERENCES  Countries (country_id);

CREATE TABLE  Departments
   (department_id DECIMAL(4,0) PRIMARY KEY,
    department_name VARCHAR(30) NOT NULL,
    manager_id DECIMAL(6,0),
    location_id DECIMAL(4,0)
   );
 
ALTER TABLE  Departments ADD CONSTRAINT DEPT_LOC_FK FOREIGN KEY (location_id)
	REFERENCES  Locations (location_id);
	
CREATE TABLE  Jobs
   (job_id VARCHAR(10) PRIMARY KEY,
    job_title VARCHAR(35) NOT NULL,
    min_salary DECIMAL(6,0),
    max_salary DECIMAL(6,0)
   );
	
CREATE TABLE  Employees
   (employee_id DECIMAL(6,0) PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(25) NOT NULL,
    email VARCHAR(25) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    hire_date DATE NOT NULL,
    job_id VARCHAR(10) NOT NULL,
    salary DECIMAL(8,2),
    commission_pct DECIMAL(2,2),
    manager_id DECIMAL(6,0),
    department_id DECIMAL(4,0),
	bonus VARCHAR(5),
     CONSTRAINT EMP_SALARY_MIN CHECK (salary > 0)
  );
  
ALTER TABLE  Employees ADD CONSTRAINT EMP_DEPT_FK FOREIGN KEY (department_id)
	REFERENCES  Departments (department_id);
ALTER TABLE  Employees ADD CONSTRAINT EMP_JOB_FK FOREIGN KEY (job_id)
	REFERENCES  Jobs (job_id);

CREATE TABLE  Job_History
   (employee_id DECIMAL(6,0),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    job_id VARCHAR(10),
    department_id DECIMAL(4,0),
     CONSTRAINT JHIST_DATE_INTERVAL CHECK (end_date > start_date),
     CONSTRAINT JHIST_EMP_ID_ST_DATE_PK PRIMARY KEY (employee_id, start_date)
   );

ALTER TABLE  Job_History ADD CONSTRAINT JHIST_DEPT_FK FOREIGN KEY (department_id)
	REFERENCES  Departments (department_id);
ALTER TABLE  Job_History ADD CONSTRAINT JHIST_JOB_FK FOREIGN KEY (job_id)
	  REFERENCES  Jobs (job_id);

-- populate regions table
INSERT INTO Regions (region_id, region_name)
Values(1,'Europe'),
(2,'Americas'),
(3,'Asia'),
(4,'Middle East and Africa');

-- populate countries table
INSERT INTO Countries (country_id, country_name, region_id)
Values('CA','Canada',2),
('DE','Germany',1),
('UK','United Kingdom',1),
('US','United States of America',2);

-- populate locations table
INSERT INTO Locations (location_id, street_address, postal_code, city, state_province, country_id)
Values(1800,'460 Bloor St. W.','ON M5S 1X8','Toronto','Ontario','CA'),
(2500,'Magdalen Centre, The Oxford Science Park','OX9 9ZB','Oxford','Oxford','UK'),
(1400,'2014 Jabberwocky Rd','26192','Southlake','Texas','US'),
(1500,'2011 Interiors Blvd','99236','South San Francisco','California','US'),
(1700,'2004 Charade Rd','98199','Seattle','Washington','US');

-- populate departments table
INSERT INTO Departments (department_id, department_name, manager_id, location_id)
Values(10,'Administration',200,1700),
(20,'Marketing',201,1800),
(50,'Shipping',124,1500),
(60,'IT',103,1400),
(80,'Sales',149,2500),
(90,'Executive',100,1700),
(110,'Accounting',205,1700),
(190,'Contracting',null,1700);

-- populate jobs table
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary)
Values('AD_PRES','President',20000,40000),
('AD_VP','Administration Vice President',15000,30000),
('AD_ASST','Administration Assistant',3000,6000),
('AC_MGR','Accounting Manager',8200,16000),
('AC_ACCOUNT','Public Accountant',4200,9000),
('SA_MAN','Sales Manager',10000,20000),
('SA_REP','Sales Representative',6000,12000),
('ST_MAN','Stock Manager',5500,8500),
('ST_CLERK','Stock Clerk',2000,5000),
('IT_PROG','Programmer',4000,10000),
('MK_MAN','Marketing Manager',9000,15000),
('MK_REP','Marketing Representative',4000,9000);

-- populate employees table
INSERT INTO Employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id)
VALUES(100,'Steven','King','SKING','515.123.4567','2007-06-17','AD_PRES',24000,null,null,90),
(101,'Neena','Kochhar','NKOCHHAR','515.123.4568','2009-09-21','AD_VP',17000,null,100,90 ),
(102,'Lex','De Haan','LDEHAAN','515.123.4569','2013-01-13','AD_VP',17000,null,100,90 ),
(200,'Jennifer','Whalen','JWHALEN','515.123.4444','2007-09-17','AD_ASST',4400,null,101,10 ),
(205,'Shelley','Higgins','SHIGGINS','515.123.8080','2014-06-07','AC_MGR',12000,null,101,110 ),
(206,'William','Gietz','WGIETZ','515.123.8181','2014-06-07','AC_ACCOUNT',8300,null,205,110 ),
(178,'Kimberely','Grant','KGRANT','011.44.1644.429263','2019-05-24','SA_REP',7000,.15,149,null ),
(124,'Kevin','Mourgos','KMOURGOS','650.123.5234','2019-11-16','ST_MAN',5800,null,100,50),
(141,'Trenna','Rajs','TRAJS','650.121.8009','2015-10-17','ST_CLERK',3500,null,124,50 ),
(142,'Curtis','Davies','CDAVIES','650.121.2994','2017-01-29','ST_CLERK',3100,null,124,50 ),
(143,'Randall','Matos','RMATOS','650.121.2874','2018-03-15','ST_CLERK',2600,null,124,50 ),
(144,'Peter','Vargas','PVARGAS','650.121.2004','2018-07-09','ST_CLERK',2500,null,124,50 ),
(103,'Alexander','Hunold','AHUNOLD','590.423.4567','2010-01-03','IT_PROG',9000,null,102,60 ),
(104,'Bruce','Ernst','BERNST','590.423.4568','2011-05-21','IT_PROG',6000,null,103,60 ),
(107,'Diana','Lorentz','DLORENTZ','590.423.5567','2019-02-07','IT_PROG',4200,null,103,60 ),
(201,'Michael','Hartstein','MHARTSTE','515.123.5555','2016-02-17','MK_MAN',13000,null,100,20 ),
(202,'Pat','Fay','PFAY','603.123.6666','2017-08-17','MK_REP',6000,null,201,20 );

INSERT INTO Employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id, bonus)
VALUES(174,'Ellen','Abel','EABEL','011.44.1644.429267','2016-05-11','SA_REP',11000,.3,149,80,'1700' ),
(176,'Jonathon','Taylor','JTAYLOR','011.44.1644.429265','2018-03-24','SA_REP',8600,.2,149,80,'1250' ),
(149,'Eleni','Zlotkey','EZLOTKEY','011.44.1344.429018','2020-01-29','SA_MAN',10500,.2,100,80, '1500' );


-- populate Job_History table
INSERT INTO Job_History(employee_id,start_date,end_date,job_id,department_id)
VALUES(200,'2007-09-17','2013-06-17','AD_ASST',90 );
INSERT INTO Job_History(employee_id,start_date,end_date,job_id,department_id)
VALUES(101,'2013-10-28','2017-03-15','AC_MGR',110 );
INSERT INTO Job_History(employee_id,start_date,end_date,job_id,department_id)
VALUES(200,'2014-07-01','2018-12-31','AC_ACCOUNT',90 );
INSERT INTO Job_History(employee_id,start_date,end_date,job_id,department_id)
VALUES(101,'2009-09-21','2013-10-27','AC_ACCOUNT',110 );
INSERT INTO Job_History(employee_id,start_date,end_date,job_id,department_id)
VALUES(176,'2019-01-01','2019-12-31','SA_MAN',80 );
INSERT INTO Job_History(employee_id,start_date,end_date,job_id,department_id)
VALUES(176,'2018-03-24','2018-12-31','SA_REP',80 );
INSERT INTO Job_History(employee_id,start_date,end_date,job_id,department_id)
VALUES(122,'2019-01-01','2019-12-31','ST_CLERK',50 );
INSERT INTO Job_History(employee_id,start_date,end_date,job_id,department_id)
VALUES(114,'2018-03-24','2019-12-31','ST_CLERK',50 );
INSERT INTO Job_History(employee_id,start_date,end_date,job_id,department_id)
VALUES(102,'2013-01-13','2018-07-24','IT_PROG',60 );
INSERT INTO Job_History(employee_id,start_date,end_date,job_id,department_id)
VALUES(201,'2016-02-17','2019-12-19','MK_REP',20 );



ALTER TABLE  Employees ADD CONSTRAINT EMP_MANAGER_FK FOREIGN KEY (manager_id)
	REFERENCES  Employees (employee_id);
ALTER TABLE  Departments ADD CONSTRAINT DEPT_MGR_FK FOREIGN KEY (manager_id)
	REFERENCES  Employees (employee_id);
