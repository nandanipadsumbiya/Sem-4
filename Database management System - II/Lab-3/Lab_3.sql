
-----------------------------schema------------------------

----Department
CREATE TABLE Departments (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE,
 ManagerID INT NOT NULL,
 Location VARCHAR(100) NOT NULL
);

----Employee
CREATE TABLE Employee (
 EmployeeID INT PRIMARY KEY,
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 DoB DATETIME NOT NULL,
 Gender VARCHAR(50) NOT NULL,
 HireDate DATETIME NOT NULL,
 DepartmentID INT NOT NULL,
 Salary DECIMAL(10, 2) NOT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Projects Table
CREATE TABLE Projects (
 ProjectID INT PRIMARY KEY,
 ProjectName VARCHAR(100) NOT NULL,
 StartDate DATETIME NOT NULL,
 EndDate DATETIME NOT NULL,
 DepartmentID INT NOT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);


INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID, Location)
VALUES
 (1, 'IT', 101, 'New York'),
 (2, 'HR', 102, 'San Francisco'),
 (3, 'Finance', 103, 'Los Angeles'),
 (4, 'Admin', 104, 'Chicago'),
 (5, 'Marketing', 105, 'Miami');


 INSERT INTO Employee (EmployeeID, FirstName, LastName, DoB, Gender, HireDate, DepartmentID,
Salary)
VALUES
 (101, 'John', 'Doe', '1985-04-12', 'Male', '2010-06-15', 1, 75000.00),
 (102, 'Jane', 'Smith', '1990-08-24', 'Female', '2015-03-10', 2, 60000.00),
 (103, 'Robert', 'Brown', '1982-12-05', 'Male', '2008-09-25', 3, 82000.00),
 (104, 'Emily', 'Davis', '1988-11-11', 'Female', '2012-07-18', 4, 58000.00),
 (105, 'Michael', 'Wilson', '1992-02-02', 'Male', '2018-11-30', 5, 67000.00); INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, DepartmentID)
VALUES
 (201, 'Project Alpha', '2022-01-01', '2022-12-31', 1),
 (202, 'Project Beta', '2023-03-15', '2024-03-14', 2),
 (203, 'Project Gamma', '2021-06-01', '2022-05-31', 3),
 (204, 'Project Delta', '2020-10-10', '2021-10-09', 4),
 (205, 'Project Epsilon', '2024-04-01', '2025-03-31', 5);


 select * from Departments
 select * from Employee
 select * from Projects



 -----------------------------PART A---------------------------------------------

 --1.Create Stored Procedure for Employee table As User enters either First Name or Last Name and based on this you must give EmployeeID, DOB, Gender & Hiredate.  

 CREATE OR ALTER PROCEDURE PR_EMPLOYEEDETAILWITHNULL
		@FirstName varchar(100) =null,
		@LastName varchar(100) = null
AS
BEGIN
		select 
		EmployeeID,DOB ,Gender,Hiredate
		from Employee
		where FirstName = @FirstName or LastName = @LastName
END

EXEC PR_EMPLOYEEDETAILWITHNULL @LastName='Doe'
EXEC PR_EMPLOYEEDETAILWITHNULL @FirstName= 'John'
EXEC PR_EMPLOYEEDETAILWITHNULL 'John' ,'Doe'


--2.Create a Procedure that will accept Department Name and based on that gives employees list who belongs to that department. 

CREATE OR ALTER PROCEDURE PR_EMPLOYEE_DEPTNAME
		@DepartmentName varchar(100)
AS
BEGIN
		select * from
		Employee E
		join Departments D
		on  E.DepartmentID = D.DepartmentID 
		where DepartmentName = @DepartmentName
END

EXEC PR_EMPLOYEE_DEPTNAME IT


--3. Create a Procedure that accepts Project Name & Department Name and based on that you must give all the project related details.  

 CREATE OR ALTER PROCEDURE PR_PROJECTNAME_DEPTNAME
		@ProjectName  varchar(100),
		@DepartmentName varchar(100)
AS
BEGIN 
		Select * from 
		Projects P join Departments D
		on P.DepartmentID = D.DepartmentID
		where ProjectName = @ProjectName and DepartmentName = @DepartmentName
END

EXEC  PR_PROJECTNAME_DEPTNAME 'Project Alpha','IT '


--4.Create a procedure that will accepts any integer and if salary is between provided integer, then those employee list comes in output. 
 CREATE OR ALTER PROCEDURE PR_MIN_MAX_SALARY
		@min_salary int,
		@max_salary int
AS
BEGIN
		select * from Employee
		where salary > @min_salary
		and Salary < @max_salary
END

EXEC PR_MIN_MAX_SALARY 60000,80000


         -----------------------OR------------------
CREATE OR ALTER PROC PR_SelectEmpBySalary_1
	@Random_Salary INT
AS
BEGIN
	if @Random_Salary < 50000
		SELECT 'Please enter valid salary'
		
	else
		select *from Employee
		where
			Salary between
			@Random_Salary
			AND
			@Random_Salary + 50000
END

EXEC PR_SelectEmpBySalary_1 40000
EXEC PR_SelectEmpBySalary_1 80000


--5.Create a Procedure that will accepts a date and gives all the employees who all are hired on that date.  

CREATE OR ALTER PROCEDURE PR_MIN_MAX_SALARY
		@HireDate DateTime
AS
BEGIN
		select * from Employee
		where HireDate = @HireDate
END

EXEC PR_MIN_MAX_SALARY '2008-09-25'


-----------------------------------PART B--------------------------------------

--6.Create a Procedure that accepts Gender’s first letter only and based on that employee details will be served. 
CREATE OR ALTER PROCEDURE PR_GENDER_FIRST
		@Gender varchar(50)
AS
BEGIN
		select * from Employee
		where Gender Like @Gender +'%';
END

EXEC PR_GENDER_FIRST F
EXEC PR_GENDER_FIRST M



--7.Create a Procedure that accepts First Name or Department Name as input and based on that employee data will come.  
CREATE OR ALTER PROCEDURE PR_FIRST_DEPARTMENT
		@FirstName varchar(100),
		@DepartmentName varchar(100)
AS
BEGIN
		select * from 
		Employee E 
		join  Departments D
		on E.DepartmentID = D.DepartmentID
		where FirstName = @FirstName or  DepartmentName = @DepartmentName
END

EXEC PR_FIRST_DEPARTMENT 'John','IT'


--8.Create a procedure that will accepts location, if user enters a location any characters, then he/she will get all the departments with all data.  
CREATE OR ALTER PROCEDURE PR_LOCATION
		@Location varchar(100)
AS
BEGIN
		select * from 
		Departments 
		where Location Like  '%'+@Location+'%';
END
EXEC PR_LOCATION 'Ne'
EXEC PR_LOCATION 'ca'
EXEC PR_LOCATION 'les'
EXEC PR_LOCATION 'n'


--------------------------------------------PART C-----------------------------------------

--9.Create a procedure that will accepts From Date & To Date and based on that he/she will retrieve Project related data.  
CREATE OR ALTER PROCEDURE PR_DATE_TODATE
		@StartDate Datetime,
		@EndDate Datetime
AS
BEGIN
		select ProjectName from Projects
		where StartDate = @StartDate
		AND EndDate = @EndDate
END

EXEC PR_DATE_TODATE '2022-01-01','2022-12-31'



---10.Create a procedure in which user will enter project name & location and based on that you must provide all data with Department Name, Manager Name with Project Name & Starting Ending Dates. 
CREATE OR ALTER PROCEDURE PR_PROJECTNAME_LOCATION
			@ProjectName  varchar(100),
			@Location  varchar(100)
AS
BEGIN
			select DepartmentName,ManagerID,ProjectName,StartDate,EndDate from
			Departments D
			join Projects P
			on D.DepartmentID = P.DepartmentID
			where ProjectName = @ProjectName
				  AND
				  Location = @Location
END

EXEC PR_PROJECTNAME_LOCATION 'Project Alpha','New York'



