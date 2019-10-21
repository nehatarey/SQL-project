use Adventureworks2016;
--Combine MyProduct and MyPriceHistory displaying the fields into a new temporary table called MyProductPriceHistory. 
--Display ProductID, Name, EndDate, and List Price.
---below gives 33 rows
SELECT *
FROM Production.Product
WHERE Name like '%Road Frame%';
select
    P.ProductID,
    P.Name,
    P.Color,
    P.StandardCost,
    P.ListPrice,
    P.SellStartDate,
    P.SellEndDate,
    P.Size,
    P.Weight,
    P.DaysToManufacture
into #MyProduct
from Production.Product as P
where P.Name like '%Road Frame%'
order by P.Color;
select *
from #MyProduct
order by ProductID;
------End of MyProduct----------
--gives 68 rows
SELECT
    LPH.ProductID,
    LPH.ListPrice,
    LPH.StartDate,
    LPH.EndDate
INTO #MyPriceHistory
FROM Production.ProductListPriceHistory AS LPH, #MyProduct as MP 
where LPH.ProductID=MP.ProductID
order by ProductID;
/*where productID between 717 and 738
    or ProductID between 833 and 840
    or ProductID in (680, 706, 822)
*/
---Simple select to view---
select *
from #MyPriceHistory
order by ProductID;
----End of MyPriceHistory---
----Joining above tables into a new MyProductPriceHistory--------inner = 68 rows, left outer = 70, 680 AND 706 EXTRA
-- their price never changed since 2008 so they do nothave any entry in the list price hisotry?>
SELECT
    MP.ProductID,
    MP.Name,
    MP.ListPrice as LatestListPrice,
    PH.ListPrice,
    PH.EndDate
INTO #MyProductListPriceHistory
FROM #MyProduct as MP
    LEFT OUTER JOIN #MyPriceHistory as PH
    ON MP.ProductID = PH.ProductID;
/* End of Question 1*/
/* Start of Question 2*/
SELECT
    SOD.SalesOrderID,
    SOD.SalesOrderDetailID,
    SOD.ProductID,
    SOD.OrderQty,
    SOD.UnitPrice,
    SOD.UnitPriceDiscount,
    SOD.LineTotal
INTO #MySalesOrderDetail
FROM Sales.SalesOrderDetail AS SOD
where productID between 717 and 738
    or ProductID between 833 and 840
    or ProductID in (680, 706, 822)
order by ProductID;
--GIVES 4713 rows when only searching for 680, 706, 822, 717 to 738 and 833 to 840
---Creating MySalesORderDetailbyName, below join accurately results in 4713 rows
--Display ProductID, Name, SalesOrderID, and Quantity.
SELECT
    MSOD.ProductID,
    MP.Name,
    MSOD.SalesOrderID,
    MSOD.OrderQty
INTO #MySalesOrderDetailbyName
FROM #MySalesOrderDetail AS MSOD
    JOIN #MyProduct AS MP
    ON MSOD.ProductID = MP.ProductID;
---END OF QUESTION #2---------------------
/* QUESTION 3 Combine MySalesOrderDetailbyName and ALLSalesOrderDates displaying the fields into a new temporary table 
called MySalesHistory. Display ProductID, Name, OrderDate, and SumOfQuantity. 
This will require you using the SUM and GROUP BY statements.   */
---CREATING ALLSalesOrderDates---Below query gives 4713 rows
SELECT
    SOH.SalesOrderID,
    SOH.OrderDate,
    SOH.DueDate
    INTO #ALLSalesOrderDates
FROM SALES.SalesOrderHeader SOH; ---31465 ROWS
    /*JOIN Sales.SalesOrderDetail SOD
    ON SOH.SalesOrderID = SOD.SalesOrderID
where SOD.ProductID between 717 and 738
    or SOD.ProductID between 833 and 840
    or SOD.ProductID in (680, 706, 822)
order by SOD.ProductID;*/
--Creating MySalesHistory ProductID, Name, OrderDate, and SumOfQuantity
SELECT
MSO.ProductID,
MSO.Name,
YEAR(ASO.OrderDate) AS OrderYear,
SUM(OrderQty) AS SumOfQuantity
FROM 
#MySalesOrderDetailbyName  AS MSO
JOIN #ALLSalesOrderDates as ASO
ON MSO.SalesOrderID = ASO.SalesOrderID
GROUP BY MSO.ProductID, MSO.Name, YEAR(ASO.OrderDate)
ORDER by YEAR(ASO.OrderDate) DESC, SumOfQuantity DESC;


SELECT OBJECT_ID(N'AdventureWorks2016.Production.WorkOrder') AS 'Object ID';  


