
------------------------------------Part A-----------------------------

---------TABLE SCHEMA-----

--Create Department Table
CREATE TABLE Department (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

-- Create Designation Table
CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
);

-- Create Person Table
CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
);

----Stored Procedure ---------

--1.Department, Designation & Person Table’s INSERT, UPDATE & DELETE Procedures. 

----------------------DEPARTMENT--------------------

--- (1) DEPARTMENT INSERT 
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_INSERT
		@DepartmentID INT,
		@DepartmentName VARCHAR(50)
AS
BEGIN
	INSERT INTO DEPARTMENT
	(
		DepartmentID,
		DepartmentName
	)
	VALUES 
	(
		@DepartmentID,
		@DepartmentName
	)
END

EXEC PR_DEPARTMENT_INSERT 1,'Admin'
EXEC PR_DEPARTMENT_INSERT 2,'IT'
EXEC PR_DEPARTMENT_INSERT 3,'HR'
EXEC PR_DEPARTMENT_INSERT 4,'Account'
EXEC PR_DEPARTMENT_INSERT 5,'ABC'


--- (2) DEPARTMENT UPDATE
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_UPDATE
		@DepartmentID INT,
		@DepartmentName VARCHAR(50)
AS
BEGIN
		update Department
		set DepartmentName = @DepartmentName
		where DepartmentID= @DepartmentID
END


---- (3) DEPARTMENT DELETE
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_DELETE
		@DepartmentID INT
AS
BEGIN
		delete from Department
		where  DepartmentID = @DepartmentID
END
EXEC PR_DEPARTMENT_DELETE 4
select * from Department


--------------------DESIGNATION ---------------------

---(1)DESIGNATION INSERT
CREATE OR ALTER PROCEDURE PR_DESIGNATION_INSERT
		@DesignationID INT,
		@DesignationName VARCHAR(50)
AS
BEGIN
	INSERT INTO Designation
	(
		DesignationID,
		DesignationName
	)
	VALUES 
	(
		@DesignationID,
		@DesignationName
	)
END

EXEC PR_DESIGNATION_INSERT 11,'Jobber'
EXEC PR_DESIGNATION_INSERT 12,'Welder'
EXEC PR_DESIGNATION_INSERT 13,'Clerk'
EXEC PR_DESIGNATION_INSERT 14,'Manager'
EXEC PR_DESIGNATION_INSERT 15,'CEO'


---(2)DESIGNATION UPDATE
CREATE OR ALTER PROCEDURE PR_DESIGNATION_UPDATE
		@DesignationID INT,
		@DesignationName VARCHAR(50)
AS
BEGIN
		update Designation
		set DesignationName = @DesignationName
		where DesignationID = @DesignationID
END


---(3)DESIGNATION DELETE
CREATE OR ALTER PROCEDURE PR_DESIGNATION_DELETE
		@DepartmentID INT,
		@DepartmentName VARCHAR(50)
AS
BEGIN
		delete from Department
		where  DepartmentID = @DepartmentID
END


--------------------------person--------------------

------(1)person insert
CREATE OR ALTER PROCEDURE PR_PERSON_INSERT
	
		@FirstName varchar(100),
		@LastName varchar(100),
		@Salary Decimal(8,2),
		@JoiningDate Datetime,
		@DepartmentID INT,
		@DesignationID INT
AS
BEGIN
	INSERT INTO Person
	(
		
		FirstName,
		LastName,
		Salary ,
		JoiningDate,
		DepartmentID,
		DesignationID 
	)
	VALUES 
	(
		
		@FirstName,
		@LastName,
		@Salary ,
		@JoiningDate,
		@DepartmentID,
		@DesignationID 
	)
END

EXEC PR_PERSON_INSERT 'Rahul','Anshu',56000,'1990-01-01',1,12
EXEC PR_PERSON_INSERT 'Hardik' ,'Hinsu' ,18000 , '1990-09-25' ,2,11
EXEC PR_PERSON_INSERT 'Bhavin' , 'Kamani',25000 ,'1991-05-14',null, 11
EXEC PR_PERSON_INSERT 'Bhoomi', 'Patel',39000 , '2014-02-20',1,13
EXEC PR_PERSON_INSERT 'Rohit' ,'Rajgor',17000,'1990-07-23',2,15
EXEC PR_PERSON_INSERT 'Priya','Mehta',25000,'1990-10-18',2,null
EXEC PR_PERSON_INSERT 'Neha' ,'Trivedi',18000 , '2014-02-20',3,15

select * from Person

---- (2)PERSON UPDATE
CREATE OR ALTER PROCEDURE PR_PERSON_UPDATE
		@personID INT,
		--@FirstName varchar(100),
		--@LastName varchar(100),
		@Salary Decimal(8,2)
		--@JoiningDate Datetime,
		--@DepartmentID int,
		--@DesignationID int
AS
BEGIN
		update Person
		set Salary = @Salary
		where personID = @personID
END

EXEC PR_DESIGNATION_UPDATE 109,56000.00


---- (3) PERSON DELETE
CREATE OR ALTER PROCEDURE PR_PERSON_DELETE
		@personID INT
AS
BEGIN
		delete from Person
		where  personID = @personID
END
EXEC PR_PERSON_DELETE 101
EXEC PR_PERSON_DELETE 102
EXEC PR_PERSON_DELETE 103
EXEC PR_PERSON_DELETE 104
EXEC PR_PERSON_DELETE 105
EXEC PR_PERSON_DELETE 106
EXEC PR_PERSON_DELETE 107
EXEC PR_PERSON_DELETE 108



--2.Department, Designation & Person Table’s SELECTBYPRIMARYKEY

----department with primarykey
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_BY_PRIMARYKEY
		@DepartmentID INT
AS
BEGIN
		select DepartmentID , DepartmentName from Department
		where DepartmentID = @DepartmentID
END

---designtion with primarykey
CREATE OR ALTER PROCEDURE PR_Designation_BY_PRIMARYKEY
		@DesignationID INT
AS
BEGIN
		select DesignationID , DesignationName from Designation
		where DesignationID = @DesignationID
END

---person with primarykey
CREATE OR ALTER PROCEDURE PR_PERSON_BY_PRIMARYKEY
		@PersonID INT
AS
BEGIN
		select PersonID , FirstName from Person
		where PersonID = @PersonID
END


--3.Department, Designation & Person Table’s (If foreign key is available then do write join and take columns on select list) 
CREATE OR ALTER PROCEDURE PR_DETAIL_FK
AS
BEGIN
		select * from
		Person P join
		Department D
		on P.DepartmentID = D.DepartmentID
		join Designation De
		on P.DesignationID= De.DesignationID
END
EXEC PR_DETAIL_FK
select * from Person

--4. Create a Procedure that shows details of the first 3 persons.
CREATE OR ALTER PROCEDURE PR_TOP3_DETAIL
AS
BEGIN
		select top 3 * from
		Person P join
		Department D
		on P.DepartmentID = D.DepartmentID
		join Designation De
		on P.DesignationID = De.DesignationID
END

EXEC PR_TOP3_DETAIL 



------------------------------------------------------------------PART B -------------------------------------------------------------------

--5.Create a Procedure that takes the department name as input and returns a table with all workers working in that department. 
CREATE OR ALTER PROCEDURE PR_DEPARTMENTNAME_DETAIL
		@DepartmentName varchar(100)
AS 
BEGIN
		select * from 
		Person P join
		Department D
		on P.DepartmentID = D.DepartmentID
		join Designation De
		on P.DesignationID = De.DesignationID
		where DepartmentName = @DepartmentName
END
EXEC PR_DEPARTMENTNAME_DETAIL 'IT'


--6.Create Procedure that takes department name & designation name as input and returns a table with worker’s first name, salary, joining date & department name. 
CREATE OR ALTER PROCEDURE PR_WORKER_DETAIL
		@DepartmentName varchar(100),
		@DesignationName varchar(100)
AS 
BEGIN
		select P.FirstName , P.Salary , P.JoiningDate , D.DepartmentName from 
		Person  P join
		Department  D
		on P.DepartmentID = D.DepartmentID
		join Designation De
		on P.DesignationID = De.DesignationID
		where @DepartmentName = DepartmentName and
			  @DesignationName = DesignationName
END
EXEC PR_WORKER_DETAIL 'Admin','Clerk'
EXEC PR_WORKER_DETAIL 'Admin','Jobber'


--7.Create a Procedure that takes the first name as an input parameter and display all the details of the worker with their department & designation name.
CREATE OR ALTER PROCEDURE PR_WORKER_DETAIL
		@FirstName varchar(100)
AS 
BEGIN
		select * from 
		Person  P join
		Department  D
		on P.DepartmentID = D.DepartmentID
		join Designation De
		on P.DesignationID = De.DesignationID
		where FirstName = @FirstName
END
EXEC PR_WORKER_DETAIL 'Rahul'


--8.Create Procedure which displays department wise maximum, minimum & total salaries. 
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_DETAIL_MMT
AS
BEGIN
		select D.departmentName ,max(P.Salary) as max_salary , min(P.Salary) min_salary , sum(P.Salary) total_salary from 
		Person P join 
		Department D
		on P.DepartmentID = D.DepartmentID
		group by D.DepartmentName
END
EXEC PR_DEPARTMENT_DETAIL_MMT


--9.Create Procedure which displays designation wise average & total salaries. 
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_DETAIL_AT
AS
BEGIN
		select De.DesignationName , avg(P.Salary) AS Avg_salary , sum(P.Salary) AS total_Salary from 
		Person P join
		Designation De
		on P.DesignationID = De.DesignationID
		group by De.DesignationName
END
EXEC PR_DEPARTMENT_DETAIL_AT


-------------------------------------------------------PART C ---------------------------------------------------------------

--10. Create Procedure that Accepts Department Name and Returns Person Count. 
CREATE OR ALTER PROCEDURE PR_PERSON_COUNT_DETAIL
		@DepartmentName varchar(100)
AS
BEGIN
		select sum(P.PersonID) as total_personID from 
		Person P join 
		Department D
		on P.DepartmentID = D.DepartmentID
		where DepartmentName = @DepartmentName
END
EXEC PR_PERSON_COUNT_DETAIL 'IT'


--11.Create a procedure that takes a salary value as input and returns all workers with a salary greater than input salary value along with their department and designation details. 
CREATE OR ALTER PROCEDURE PR_PERSON_SALARY_DETAIL
		@Salary int
AS
BEGIN
		select P.PersonID, P.FirstName , P.LastName , P.Salary , De.DesignationName , D.DepartmentName from
		Person P join  
		Department D 
		on P.DepartmentID = D.DepartmentID
		join Designation De
		on P.DesignationID = De.DesignationID
		where P.Salary >= @Salary
END
EXEC PR_PERSON_SALARY_DETAIL 25000 
select * from Person


--12.Create a procedure to find the department(s) with the highest total salary among all departments. 
CREATE OR ALTER PROCEDURE PR_PERSON_HEGHEST_SALARY
AS
BEGIN
		select top 1 D.DepartmentName , sum(P.Salary) as total_salary from
		Person P join 
		Department D 
		on P.DepartmentID = D.DepartmentID
		group by D.DepartmentName
		order by sum(P.Salary) desc
END
EXEC PR_PERSON_HEGHEST_SALARY


--13.Create a procedure that takes a designation name as input and returns a list of all workers under that designation who joined within the last 10 years, along with their department.
CREATE OR ALTER PROCEDURE PR_WORKER_DETAIL
		@DesignationName varchar(100)
AS 
BEGIN
		select * from 
		Person  P
		join Department  D
		on P.DepartmentID = D.DepartmentID
		join Designation De
		on P.DesignationID = De.DesignationID
		where DesignationName = @DesignationName
		      AND 
			  DATEDIFF(year , JoiningDate, GetDate()) > 10
			  --DATEDIFF(year , joiningdate ,GetDate
END
EXEC PR_WORKER_DETAIL 'CEO'


--14.Create a procedure to list the number of workers in each department who do not have a designation assigned. 
CREATE OR ALTER PROCEDURE PR_DO_NOT_DESIGNATIONID
AS 
BEGIN
		select D.DepartmentID ,count( P.PersonID ) as count_personID  from 
		Person  P join
		Department  D
		on P.DepartmentID = D.DepartmentID
		join Designation De
		on P.DesignationID = De.DesignationID
		where De.DesignationID = null or De.DesignationName =' '
		group by D.DepartmentID
END
EXEC PR_DO_NOT_DESIGNATIONID



--15.Create a procedure to retrieve the details of workers in departments where the average salary is above 12000. 
CREATE OR ALTER PROCEDURE PR_DO_NOT_DESIGNATIONID
AS 
BEGIN
		select  avg(P.Salary) as avg_salary ,D.DepartmentID from 
		Person  P join
		Department  D
		on P.DepartmentID = D.DepartmentID
		join Designation De
		on P.DesignationID = De.DesignationID
		group by D.DepartmentID
		having avg(P.Salary) > 12000
END
EXEC PR_DO_NOT_DESIGNATIONID
