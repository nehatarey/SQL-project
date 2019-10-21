--Temp table creation using select-into
SELECT
    SOD.SalesOrderID ,
    PP.ProductID,
    PP.Name,
    SOD.OrderQty AS Quantity
INTO #MyTempTable
FROM Sales.SalesOrderDetail SOD
    JOIN Production.Product PP
    ON SOD.ProductID = PP.ProductID
WHERE PP.Name = 'LL Road Frame - Black, 60';
---1. Create temp table
SELECT
    SOD.SalesOrderID ,
    PP.ProductID,
    PP.Name,
    SOD.OrderQty AS Quantity
INTO #MyTempTable
FROM Sales.SalesOrderDetail SOD
    JOIN Production.Product PP
    ON SOD.ProductID = PP.ProductID
WHERE PP.Name = 'LL Road Frame - Black, 60';
--2. Alter table to add new column
ALTER TABLE #MyTempTable
ADD DateRan DATETIME NOT NULL DEFAULT (GETDATE());
--3. Fetch the data after adding date and ordering on SalesOrderID;
SELECT
    SalesOrderID,
    ProductID,
    Name,
    Quantity,
    FORMAT(DateRan, 'MM/dd/yyyy') as DateRanQuery
FROM #MyTempTable
ORDER BY SalesOrderID DESC;
--4. Drop the table once all activites are complete
DROP TABLE IF EXISTS #MyTempTable;
--Question 1 SIMPLE SELECT ONTEMP TABLE
SELECT
    SalesOrderID,
    ProductID,
    Name,
    Quantity
FROM #MyTempTable;
--Question 2, ORDER BY SALESORDERID
SELECT
    SalesOrderID,
    ProductID,
    Name,
    Quantity
FROM #MyTempTable
ORDER BY SalesOrderID DESC;
--QUESTION 3 Add Column with Default Current Date Time
ALTER TABLE #MyTempTable
ADD DateRan DATETIME NOT NULL DEFAULT (GETDATE());
--select the data after adding date;
SELECT
    SalesOrderID,
    ProductID,
    Name,
    Quantity,
    FORMAT(DateRan, 'MM/dd/yyyy') as DateRanQuery
FROM #MyTempTable
ORDER BY SalesOrderID DESC;

--Dropping the table and restarting;
IF OBJECT_ID('tempdb..#MyTempTable') IS NOT NULL
    DROP TABLE #MyTempTable;

DROP TABLE IF EXISTS #MyTempTable;

BEGIN TRY
DROP TABLE #MyTempTable
END TRY
BEGIN CATCH SELECT 1 END CATCH
--If we do not recreate, it throws error- Invalid Object name  '#MyTempTable'.
--Alternative way of creating table
CREATE TABLE #MyTempTable
(
    SalesOrderID INT,
    ProductID varchar(50),
    Name VARCHAR(50),
    Quantity SMALLINT

)

INSERT INTO #MyTempTable
SELECT SOD.SalesOrderID , PP.Name, SOD.OrderQty AS Quantity
FROM Sales.SalesOrderDetail SOD
    JOIN Production.Product PP
    ON SOD.ProductID = PP.ProductID
WHERE PP.Name = 'LL Road Frame - Black, 60';