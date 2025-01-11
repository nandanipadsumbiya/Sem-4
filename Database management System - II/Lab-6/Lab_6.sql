-- Create the Products table
CREATE TABLE Products (
 Product_id INT PRIMARY KEY,
 Product_Name VARCHAR(250) NOT NULL,
 Price DECIMAL(10, 2) NOT NULL
);
-- Insert data into the Products table
INSERT INTO Products (Product_id, Product_Name, Price) VALUES
(1, 'Smartphone', 35000),
(2, 'Laptop', 65000),
(3, 'Headphones', 5500),
(4, 'Television', 85000),
(5, 'Gaming Console', 32000);


SELECT * FROM Products

------------------------------------------PART A-----------------------------------------

--1. Create a cursor Product_Cursor to fetch all the rows from a products table.
DECLARE Product_Cursor CURSOR
FOR 
	SELECT * FROM Products

OPEN Product_Cursor;

FETCH NEXT FROM Product_Cursor


WHILE @@FETCH_STATUS=0
	BEGIN
		FETCH NEXT FROM Product_Cursor;
	END

CLOSE Product_Cursor;

DEALLOCATE Product_Cursor;


--2.Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName. (Example: 1_Smartphone) 

DECLARE @PRODUCT_ID INT,
		@PRODUCT_NAME VARCHAR(50)

DECLARE Product_Cursor_Fetch CURSOR
FOR
	SELECT Product_id, Product_name 
	from Products;

OPEN Product_Cursor_Fetch

FETCH NEXT FROM Product_Cursor_Fetch
INTO @PRODUCT_ID,@PRODUCT_NAME;

WHILE @@FETCH_STATUS=0
	BEGIN 
		PRINT CAST(@PRODUCT_ID AS VARCHAR(50))+'_'+@PRODUCT_NAME

		FETCH NEXT FROM Product_Cursor_Fetch
		INTO @PRODUCT_ID,@PRODUCT_NAME;
	END

CLOSE Product_Cursor_Fetch;

DEALLOCATE Product_Cursor_Fetch;



---3.Create a Cursor to Find and Display Products Above Price 30,000. 
DECLARE @PRODUCT_NAME VARCHAR(250),
		@PRICE DECIMAL(10,2)

DECLARE CURSOR_PRICE_FETCH CURSOR
FOR 
		SELECT PRODUCT_NAME , PRICE
		FROM Products

OPEN CURSOR_PRICE_FETCH

FETCH NEXT FROM CURSOR_PRICE_FETCH
INTO @PRODUCT_NAME , @PRICE

WHILE @@FETCH_STATUS=0
	BEGIN 
		IF(@PRICE>30000)
			PRINT @PRODUCT_NAME +'='+CAST(@PRICE AS VARCHAR(100))

		FETCH NEXT FROM CURSOR_PRICE_FETCH
		INTO @PRODUCT_NAME , @PRICE
	END

CLOSE CURSOR_PRICE_FETCH

DEALLOCATE CURSOR_PRICE_FETCH



--4.Create a cursor Product_CursorDelete that deletes all the data from the Products table. 
DECLARE @PRODUCT_ID INT 

DECLARE Product_CursorDelete CURSOR
FOR 
	SELECT Product_id FROM Products

OPEN Product_CursorDelete

FETCH NEXT FROM Product_CursorDelete
INTO @PRODUCT_ID

WHILE @@FETCH_STATUS=0
	BEGIN 

		DELETE FROM Products
		WHERE Product_id = @PRODUCT_ID

		FETCH NEXT FROM Product_CursorDelete
		INTO @PRODUCT_ID

	END
	
CLOSE Product_CursorDelete

DEALLOCATE Product_CursorDelete


-------------------------------------------------------------------PART B-------------------------------------------------------------------------------------

--5. Create a cursor Product_CursorUpdate that retrieves all the data from the products table and increases the price by 10%. 

DECLARE @PRICE DECIMAL(10,2) ,
		@PRODUCT_ID INT

DECLARE  Product_CursorUpdate CURSOR
FOR 
		SELECT Price,Product_id 
		FROM Products

OPEN Product_CursorUpdate

FETCH NEXT FROM Product_CursorUpdate
INTO @PRICE,@PRODUCT_ID

WHILE @@FETCH_STATUS=0
		BEGIN
			UPDATE PRODUCTS
			SET PRICE=(@PRICE+@PRICE*0.1)
			WHERE PRODUCT_ID=@PRODUCT_ID


			FETCH NEXT FROM Product_CursorUpdate
			INTO @PRICE,@PRODUCT_ID

		END

CLOSE Product_CursorUpdate

DEALLOCATE Product_CursorUpdate

select * from Products


--6. Create a Cursor to Rounds the price of each product to the nearest whole number. 

DECLARE @PRICE DECIMAL(10,2)

DECLARE CURSOR_PRICE_ROUND CURSOR
FOR 
		SELECT PRICE FROM
		Products

OPEN CURSOR_PRICE_ROUND

FETCH NEXT FROM CURSOR_PRICE_ROUND
INTO @PRICE

WHILE @@FETCH_STATUS=0
		BEGIN
			UPDATE PRODUCTS
			SET PRICE=ROUND(PRICE,0)
			
			
			FETCH NEXT FROM CURSOR_PRICE_ROUND
			INTO @PRICE
		END

CLOSE CURSOR_PRICE_ROUND

DEALLOCATE CURSOR_PRICE_ROUND


SELECT * FROM Products


--------------------------------------------------------------------------PART C---------------------------------------------------------------------

-- 7. Create a cursor to insert details of Products into the NewProducts table if the product is “Laptop” (Note: Create NewProducts table first with same fields as Products table) 

create table NewProduct(
	Product_id INT PRIMARY KEY,
	Product_Name VARCHAR(250) NOT NULL,
	Price DECIMAL(10, 2) NOT NULL
)

declare @Product_id int,
		@product_name varchar(100),
		@Price decimal(10,2)

declare New_product_details cursor
for 
	select * from Products
	where product_name='Laptop'

open New_product_details

fetch next from New_product_details
into @Product_id ,@product_name ,@Price 

while @@FETCH_STATUS=0
	begin 
		
		insert into NewProduct (Product_id,Product_Name,Price)
		values (@Product_id,@product_name,@Price);
		
		fetch next from New_product_details
		into @Product_id ,@product_name ,@Price 

	end

close New_product_details
DEALLOCATE New_product_details;

select * from NewProduct




--8.Create a Cursor to Archive High-Price Products in a New Table (ArchivedProducts), Moves products with a price above 50000 to an archive table, removing them from the original Products table. 

create table ArchivedProducts(
	Product_id INT PRIMARY KEY,
	Product_Name VARCHAR(250) NOT NULL,
	Price DECIMAL(10, 2) NOT NULL
)


declare @Product_id int,
		@Product_name varchar(100),
		@Price decimal(8,2)

declare cursor_Archive_hige_price cursor
for 
	select * from Products
	where Price>50000;

open cursor_Archive_hige_price

Fetch Next from cursor_Archive_hige_price
into @Product_id,@Product_name,@Price

while @@FETCH_STATUS=0
	begin
		insert into ArchivedProducts(Product_id,Product_Name,Price)
		values (@PRODUCT_ID,@PRODUCT_NAME,@PRICE)

		delete from Products
		where Product_id=@PRODUCT_ID;

		fetch next from cursor_Archive_hige_price
		into @Product_id,@Product_name,@Price;
	end

close cursor_Archive_hige_price

deallocate cursor_Archive_hige_price

select * from ArchivedProducts