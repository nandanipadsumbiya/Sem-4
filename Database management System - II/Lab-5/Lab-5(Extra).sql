CREATE TABLE EMPLOYEEDETAILS
(
	EmployeeID Int Primary Key,
	EmployeeName Varchar(100) Not Null,
	ContactNo Varchar(100) Not Null,
	Department Varchar(100) Not Null,
	Salary Decimal(10,2) Not Null,
	JoiningDate Datetime Null
);

CREATE TABLE EmployeeLogs (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
    EmployeeName VARCHAR(100) NOT NULL,
    ActionPerformed VARCHAR(100) NOT NULL,
    ActionDate DATETIME NOT NULL
);

select * from EMPLOYEEDETAILS
select * from EmployeeLogs


drop table EmployeeLogs


--1)Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on the EmployeeDetails table to display the message "Employee record inserted", "Employee record updated", "Employee record deleted"

------insert--------------
create or alter trigger tr_after_insert_print_msg
on EMPLOYEEDETAILS
after insert
as
begin
	print('Employee record inserted')
end

insert into EMPLOYEEDETAILS values (110,'nandani',1234567890,'ce',230000,'2023-01-23');


------update----------
create or alter trigger tr_after_insert_print_msg
on EMPLOYEEDETAILS
after update
as
begin
	print('Employee record updated')
end

update EMPLOYEEDETAILS
set Department='cse'
where EmployeeID=101

-----delete--------
create or alter trigger tr_after_insert_print_msg
on EMPLOYEEDETAILS
after delete
as
begin
	print('Employee record deleted')
end

delete from EMPLOYEEDETAILS
where EmployeeID=101


--2.Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on the EmployeeDetails table to log all operations into the EmployeeLog table.
-------------insert----------------
create or alter trigger tr_after_insert_emplog
on EMPLOYEEDETAILS
after insert
as
begin
	declare @EmpId int
	declare @Empname varchar(100)

	select @EmpId=EmployeeID,@Empname=EmployeeName from inserted

	insert into EmployeeLogs
	values (@EmpId,@Empname,'Record is inserted',GETDATE())
end

insert into EMPLOYEEDETAILS
values(101,'nandani',1234567890,'ce',230000,'2023-12-12')


------update----------------
create or alter trigger tr_after_insert_emplog
on EMPLOYEEDETAILS
after update
as
begin
	declare @EmpId int
	declare @Empname varchar(100)

	select @EmpId=EmployeeID,@Empname=EmployeeName from inserted

	insert into EmployeeLogs
	values (@EmpId,@Empname,'Record is updated',GETDATE())
end

update EMPLOYEEDETAILS
set Department='cse'
where EmployeeID=101


------------delete------------
create or alter trigger tr_after_insert_emplog
on EMPLOYEEDETAILS
after delete
as
begin
	declare @EmpId int
	declare @Empname varchar(100)

	select @EmpId=EmployeeID,@Empname=EmployeeName from deleted

	insert into EmployeeLogs
	values (@EmpId,@Empname,'Record is deleted',GETDATE())
end

delete from EMPLOYEEDETAILS
where EmployeeID=101

--3.Create a trigger that fires AFTER INSERT to automatically calculate the joining bonus (10% of the salary) for new employees and update a bonus column in the EmployeeDetails table.
create or alter trigger tr_update_salary
on EMPLOYEEDETAILS
after insert
as 
begin
	declare @salary decimal(10,2), @empID int
	select @empID = EmployeeID from inserted
	select @salary = Salary  from inserted

	update EMPLOYEEDETAILS
	set Salary = @salary + @salary*0.1
	where EmployeeID = @empID
end

insert into EMPLOYEEDETAILS
values(101,'nandani',1234567890,'ce',230000,'2023-12-12')

--4)Create a trigger to ensure that the JoiningDate is automatically set to the current date if it is NULL during an INSERT operation.
create or alter trigger tr_joiningDate_update
on EMPLOYEEDETAILS
after insert
as
begin
	declare @enpID int, @joiningDate DateTime
	select @enpID = EmployeeID from inserted
	select @joiningDate = JoiningDate  from inserted

	update EMPLOYEEDETAILS
	set JoiningDate = GETDATE()
	where @joiningDate is null
end

--5.Create a trigger that ensure that ContactNo is valid during insert and update (Like ContactNo length is 10)

------------inserted----------
create or alter trigger tr_ensure_contactNO
on EMPLOYEEDETAILS
after insert
as 
begin
	declare @empID int, @contactNO Varchar(100) 
	select @empID = EmployeeID  from inserted
	select @contactNO = ContactNo  from inserted

	if(len(@contactNO) != 10)
		print('Invalid contactNO.')
		delete from EMPLOYEEDETAILS where EmployeeID=@empID
	insert into EmployeeLogs
	values (@EmpId,@contactNO,'Record is INSERTED',GETDATE())
end
SELECT * FROM EMPLOYEEDETAILS
select * from EmployeeLogs

insert into EMPLOYEEDETAILS
values(120,'nandani',1234567890,'ce',230000,'2023-12-12')


------------updated----------
create or alter trigger tr_ensure_contactNO_update
on EMPLOYEEDETAILS
after update
as
begin
	declare @empID int, @contactNO Varchar(100) 
	select @empID = EmployeeID  from inserted
	select @contactNO = ContactNo  from inserted

	if(len(@contactNO) != 10)
		BEGIN
			print('Invalid contactNO.')
			delete from EMPLOYEEDETAILS where EmployeeID=@empID
		END
end

update EMPLOYEEDETAILS
set Department='cse'
where EmployeeID=101



----------------------Instead of Trigger--------------------------------

CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    MovieTitle VARCHAR(255) NOT NULL,
    ReleaseYear INT NOT NULL,
    Genre VARCHAR(100) NOT NULL,
    Rating DECIMAL(3, 1) NOT NULL,
    Duration INT NOT NULL
);

CREATE TABLE MoviesLog
(
	LogID INT PRIMARY KEY IDENTITY(1,1),
	MovieID INT NOT NULL,
	MovieTitle VARCHAR(255) NOT NULL,
	ActionPerformed VARCHAR(100) NOT NULL,
	ActionDate	DATETIME  NOT NULL
);

SELECT * FROM Movies
SELECT * FROM MoviesLog 

--1.Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the Movies table. For that, log all operations performed on the Movies table into MoviesLog.
------------inserted----------
create or alter trigger tr_insertLog
on Movies 
instead of insert
as
begin
	declare @movieID int, @movieTitlle VARCHAR(255) 
	select @movieID = MovieID  from inserted
	select @movieTitlle = MovieTitle  from inserted

	insert into MoviesLog
	values (@movieID, @movieTitlle, 'Record is inserted', GETDATE())
end
insert into Movies values()
drop trigger tr_insertLog


------------updated----------
create or alter trigger tr_updateLog
on Movies  
instead of update
as
begin
	declare @movieID int, @movieTitlle VARCHAR(255) 
	select @movieID = MovieID  from inserted
	select @movieTitlle = MovieTitle  from inserted

	insert into MoviesLog
	values (@movieID, @movieTitlle, 'someone try to update data', GETDATE())	
end

------------delete----------
create or alter trigger tr_deleteLog
on Movies 
instead of delete
as
begin
	declare @movieID int, @movieTitlle VARCHAR(255) 
	select @movieID = MovieID  from inserted
	select @movieTitlle = MovieTitle  from inserted

	insert into MoviesLog
	values (@movieID, @movieTitlle, 'someone try to delete data', GETDATE())
end


--2.	Create a trigger that only allows to insert movies for which Rating is greater than 5.5 .
create or alter trigger tr_insert_movie
on Movies 
instead of insert
as
begin
	declare @rating DECIMAL(3, 1)
	if(@rating > 5.5)
		insert into Movies(MovieID , MovieTitle , ReleaseYear , Genre , Rating , Duration )
		select *
		from inserted
end










