---------UDF (user defined function)


----Note: for Table valued function use tables of Lab-2 

------------------------------------Part :A --------------------------

--1. Write a function to print "hello world". 
CREATE or ALTER FUNCTION FN_hello_world()
returns varchar(500)
AS
BEGIN
	RETURN('HELLO WORLD')
END

SELECT dbo.FN_hello_world()  AS MSG


--2. Write a function which returns addition of two numbers. 
CREATE or ALTER FUNCTION FN_ADD_TWO_NUMBER
(
		@Number1 int,
		@Number2 int
)
RETURNS INT
AS
BEGIN
		DECLARE @SUM int
		SET @SUM = @Number1 + @Number2
		RETURN @SUM
END

SELECT dbo.FN_ADD_TWO_NUMBER(2,2) AS ANSWER 


--3. Write a function to check whether the given number is ODD or EVEN. 
CREATE OR ALTER FUNCTION FN_CHECK_N_ODD_EVEN
(
	@N INT
)
RETURNS VARCHAR(500)
AS 
BEGIN
		DECLARE @MSG VARCHAR(500)
		IF(@N %2=0)
			SET @MSG='NUMBER IS  EVEN'
		ELSE
			SET @MSG ='NUMBER IS  ODD'
		RETURN @MSG
END

SELECT dbo.FN_CHECK_N_ODD_EVEN(4) as MSG
SELECT dbo.FN_CHECK_N_ODD_EVEN(5) as MSG



--4. Write a function which returns a table with details of a person whose first name starts with B. 
CREATE OR ALTER FUNCTION FN_PERSON_NAME_LIKE_B()
RETURNS TABLE
AS
		RETURN(select * from Person
				where FirstName like 'B%')

select * from dbo.FN_PERSON_NAME_LIKE_B()



--5. Write a function which returns a table with unique first names from the person table. 
CREATE OR ALTER FUNCTION FN_PERSON_UNIQUE_NAME()
RETURNS TABLE
AS
		RETURN(
			select distinct FirstName from Person
		)
select * from dbo.FN_PERSON_UNIQUE_NAME()



--6. Write a function to print number from 1 to N. (Using while loop) 
CREATE OR ALTER FUNCTION FN_PRINT_NUMBER_1_N
(
	@N INT 
)
RETURNS VARCHAR(MAX)
AS
BEGIN
		declare @ans varchar(500),@i int
		set @i = 1
		set @ans =' '
		while(@i<=@N)
		begin 
			set @ans = @ans+' '+cast(@i as varchar)
			set @i = @i+1
		end
		return @ans
END

select dbo.FN_PRINT_NUMBER_1_N(5)



--7.Write a function to find the factorial of a given integer.

CREATE OR ALTER FUNCTION FN_FIND_FACTORIAL
(
	@N	INT
)	
returns int 
as 
begin
		declare @fact int,@i int
		set  @fact = 1
		set @i = 1
		while(@i<=@N)
		begin 
			set @fact = @fact*@i
			set @i=@i+1
		end
		return @fact
END

select dbo.FN_FIND_FACTORIAL(4)
select dbo.FN_FIND_FACTORIAL(5)


-----------------------------------------------------------------------Part : B-------------------------------------------------------------

--8. Write a function to compare two integers and return the comparison result. (Using Case statement)
CREATE OR ALTER FUNCTION FN_COMPARE_TWO_NUMBER
(
	@N1 INT,
	@N2 INT
)
RETURNS VARCHAR(500)
AS 
BEGIN
		return case
			when @N1=@N2 then 'both numbers are equal!'
			when @N1>@N2 then cast(@N1 as varchar)+' N1 is graterthan N2'
			when @N1<@N2 then cast(@N1 as varchar)+' N1 is lessthan N2'
			else 'given input is invalid!'
		end
END

select dbo.FN_COMPARE_TWO_NUMBER(4,2)


--9.Write a function to print the sum of even numbers between 1 to 20.
CREATE OR ALTER FUNCTION FN_SUM_OF_EVEN_NUMBER()
RETURNS INT 
AS
BEGIN
		declare @sum int ,@n int 
		set @sum = 0
		set @n=1
		while(@n<=20)
		begin
			if(@n%2=0)
				set @sum=@sum+@n
				set @n =@n+1
		end
		return @sum
END

select dbo.FN_SUM_OF_EVEN_NUMBER() As  ANSWER


--10.Write a function that checks if a given string is a palindrome.
create or alter function FN_Str_Palindrome_Using_Rev
(
	@str varchar(max)
)
returns varchar(max)
as
begin
	declare @msg varchar(max)
	if (@str = reverse(@str))
	set @msg = 'palindome'
	else
	set @msg = 'not palindrome'
	return @msg
end

select dbo.FN_Str_Palindrome_Using_Rev('sks')
select dbo.FN_Str_Palindrome_Using_Rev('sky')


		---OR---

CREATE OR ALTER FUNCTION FN_PALINDROM
(
	@STR VARCHAR(100)
)
RETURNS VARCHAR(100)
AS
BEGIN
		DECLARE @ANS VARCHAR(100) , @REV VARCHAR(100)
		SET @REV = REVERSE(@STR)
		IF @STR = @REV
			SET @ANS = @STR + ' IS A PLAINDROM STRING.'
		ELSE
			SET @ANS = @STR + ' IS NOT A PALINDROM STRING.'
		RETURN @ANS
END

SELECT DBO.FN_PALINDROM('ABCBA');



--11. Write a function to check whether a given number is prime or not.
create or alter function FN_CHECK_NUMBER_PRIME_OR_NOT
(
	@N INT 
)
RETURNS VARCHAR(MAX)
AS
BEGIN
		declare @isprime varchar(max),@i int,@count int
		set @isprime=''
		set @i=1
		set @count=0
		while(@i<=@N)
		begin
			if(@N%@i=0)
				set @count = @count+1
		set @i =@i+1
		end
		if(@count=2)
			set @isprime='yes, prime!'
		else
			set @isprime='no, not prime!'
		return @isprime
end

select dbo.FN_CHECK_NUMBER_PRIME_OR_NOT(13)
select dbo.FN_CHECK_NUMBER_PRIME_OR_NOT(14)


---12. Write a function which accepts two parameters start date & end date, and returns a difference in days.
create or alter function FN_Diff_START_END_DATE
(
	@StartDate Date,
	@EndDate Date
)
Returns INT
as
begin
	declare @Diff INT
	set @Diff= Datediff(day,@StartDate,@EndDate)
	return @Diff
end

select dbo.FN_Diff_START_END_DATE('2024-02-12','2024-02-28');


--13. Write a function which accepts two parameters year & month in integer and returns total days each year. 
CREATE OR ALTER FUNCTION FN_TOTAL_DAY
(
		@YEAR INT,
		@MONTH INT
)

RETURNS INT
AS
BEGIN
		DECLARE @DAY INT,@DATE DATE,@ANS VARCHAR(100)
		SET @ANS = CAST(@YEAR AS VARCHAR)+'-'+CAST(@MONTH AS VARCHAR)+'-1'
		SET @DATE = CAST(@ANS AS DATE)
		SET @DAY = DAY(EOMONTH(@DATE))
		
		RETURN @DAY
END

SELECT DBO.FN_TOTAL_DAY(2024,05);


--14. Write a function which accepts departmentID as a parameter & returns a detail of the persons.

CREATE OR ALTER FUNCTION FN_GETPERSON_BYDID
(
		@DID INT
)
RETURNS TABLE 
AS
	RETURN (SELECT * 
				FROM PERSON
				WHERE DepartmentID = @DID)

SELECT * FROM DBO.FN_GETPERSON_BYDID(2)


--15.Write a function that returns a table with details of all persons who joined after 1-1-1991.

CREATE OR ALTER FUNCTION FN_GETPERSON_BYJDATE()
RETURNS TABLE 
AS
		RETURN (SELECT * 
				FROM PERSON
				WHERE JoiningDate > '1991-1-1')

SELECT * FROM DBO.FN_GETPERSON_BYJDATE();