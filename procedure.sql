USE OurKartDataBase


SELECT * FROM myKartUser
SELECT * FROM CategoryMaster 
SELECT * FROM VendorMaster
SELECT * FROM ProductMaster
SELECT * FROM imageList 
SELECT * FROM CategoryType


ALTER VIEW vwProdListPriceAbove10000 WITH ENCRYPTION, SCHEMABINDING AS 
SELECT P.Pid[Product_Id], P.PName[Product_Name], P.Price[Product_Price], V.VName[Vendor_Name], C.CatName[Category_Name] FROM dbo.ProductMaster P JOIN dbo.VendorMaster V ON V.VID = P.Vid JOIN dbo.CategoryMaster C ON C.CatID = P.CID
WITH CHECK OPTION

SELECT * FROM vwProdListPriceAbove10000

SP_HELPTEXT vwProdListPriceAbove10000

INSERT INTO vwProdListPriceAbove10000 (Product_Id, CID, CTID, Vid, Product_Name, Product_Price)VALUES('909','Lp01',1,'TSB','Brundha Oil',12000)



ALTER PROCEDURE sp_AddRecord 
@vid	VARCHAR(10),
@cid	VARCHAR(10),
@ctid	int,
@pid	VARCHAR(10),
@pName	VARCHAR(10),
@quty	INT,
@price	INT,
@imgPath VARCHAR(50)
AS 
BEGIN 
BEGIN	TRY	
	INSERT INTO ProductMaster VALUES(@vid, @cid, @ctid, @pid, @pName, @quty, @price, @imgPath) 
END	TRY
BEGIN CATCH
	SELECT 'Error '+STR(ERROR_NUMBER(),5)+' FROM '+ERROR_PROCEDURE()+' AT '+STR(ERROR_LINE(),5)+' : '+ERROR_MESSAGE()  	
END	CATCH
END


EXEC sp_AddRecord 'TSB', 'Lp01', 1, '900', 'Hair il', 500, 1000, null

SELECT * FROM ProductMaster 


ALTER PROC sp_RetriveProductTable
@minPrice INT,
@maxPrice INT
AS
BEGIN
DECLARE @pid VARCHAR(10)
DECLARE @pName VARCHAR(50)
DECLARE @price INT
DECLARE @returnTable TABLE(pId VARCHAR(10),pName VARCHAR(50), Price INT) 

DECLARE list CURSOR FOR 
SELECT Pid, PName, Price FROM ProductMaster WHERE Price BETWEEN @minPrice AND @maxPrice

OPEN list

FETCH NEXT FROM list into @pid, @pName, @price
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		INSERT INTO @returnTable VALUES(@pid, @pName, @price)
		FETCH NEXT FROM list into @pid, @pName, @price		
	END
CLOSE list
DEALLOCATE list
SELECT * FROM @returnTable
END

EXEC sp_RetriveProductTable 10000, 20000


DECLARE prodList CURSOR STATIC FOR
SELECT * FROM ProductMaster
OPEN prodList

FETCH NEXT FROM prodList

FETCH FIRST FROM prodList

FETCH LAST FROM prodList

FETCH PRIOR FROM prodList

FETCH RELATIVE 5 FROM prodList

FETCH RELATIVE -5 FROM prodList

FETCH ABSOLUTE 15 FROM prodList

DEALLOCATE prodList



ALTER TRIGGER trg_CountList
ON ProductMaster
AFTER INSERT, DELETE
AS
SELECT 'Number of Products Currently '+STR(COUNT(*),10) FROM ProductMaster

SELECT * FROM ProductMaster

DELETE FROM ProductMaster WHERE Pid = '999'

SELECT SYSTEM_USER


ALTER PROC one
AS 
DECLARE @str VARCHAR(50)
EXEC two @str output
SELECT 'Hi '+@str


ALTER PROC two
@str VARCHAR(20) output
AS 
SELECT @str = 'Gurra'

EXEC one

DECLARE @str VARCHAR(50)
EXEC two @str output