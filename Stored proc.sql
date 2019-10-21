--MArch 20, test create procedure
USE AdventureWorks2016;  
GO  
CREATE PROCEDURE HumanResources.uspGetEmployeesTest2   
    @LastName nvarchar(50),   
    @FirstName nvarchar(50)   
AS   

    SET NOCOUNT ON;  
    SELECT FirstName, LastName, Department  
    FROM HumanResources.vEmployeeDepartmentHistory  
    WHERE FirstName = @FirstName AND LastName = @LastName  
    AND EndDate IS NULL;  
GO 
--End test procedure
--Test tun of the proc
EXECUTE HumanResources.uspGetEmployeesTest2 N'Ackerman', N'Pilar';  
-- Or  
EXEC HumanResources.uspGetEmployeesTest2 @LastName = N'Ackerman', @FirstName = N'Pilar';  
GO  
-- Or  
EXECUTE HumanResources.uspGetEmployeesTest2 @FirstName = N'Pilar', @LastName = N'Ackerman';  
GO 
-----------------------
/* Start Stored proc#1 --> PriceHistory723 */
USE AdventureWorks2016;  
GO
CREATE PROCEDURE dbo.PriceHistory723
    @ProductName nvarchar(50) = NULL 
AS
    SELECT
        PP.ProductID
        , PP.Name as ProductName
        , LPH.ListPrice
        , FORMAT(isnull(LPH.EndDate, GETDATE()),'MM/dd/yyyy' ) AS ListPriceEndDate
    FROM
        Production.Product AS PP
        JOIN Production.ProductListPriceHistory AS LPH ON (PP.ProductID=LPH.ProductID)
    WHERE PP.NAME = ISNULL(@ProductName, 'LL Road Frame - Black, 60');
GO
/* End of stored proc PriceHistory723 */
/* Executing the stored procedure PriceHistory723 */
EXECUTE dbo.PriceHistory723 'LL Road Frame - Black, 60';
--OR
EXEC dbo.PriceHistory723 @ProductName = 'LL Road Frame - Black, 60';  
--OR
EXECUTE dbo.PriceHistory723 @ProductName = 'LL Road Frame - Black, 60'
/* End of #1 */
/* Drop procedure */
DROP PROCEDURE dbo.PriceHistory723;

/* Start Stored proc#2 --> SalesOrderDetailbyDate723 */
USE AdventureWorks2016;  
GO
CREATE PROCEDURE dbo.SalesOrderDetailbyDate723
    @ProductName nvarchar(50) = NULL
AS
    SELECT
        SOD.ProductID
        , PP.Name as 'Product Name'
        , YEAR(SOH.OrderDate) as 'Order Year'
        , SUM(SOD.OrderQty) as 'Sum of Quantity'
    from
        Sales.SalesOrderDetail AS SOD
        JOIN Sales.SalesOrderHeader AS SOH
        ON SOD.SalesOrderID = SOH.SalesOrderID
        JOIN Production.Product AS PP
        ON SOD.ProductID=PP.ProductID
    WHERE PP.Name = ISNULL(@ProductName, 'LL Road Frame - Black, 60')
    GROUP BY SOD.ProductID, PP.Name, YEAR(SOH.OrderDate);
GO
/* End of Stored proc SalesOrderDetailbyDate723 */
/* Executing the stored procedure SalesOrderDetailbyDate723 */
EXECUTE dbo.SalesOrderDetailbyDate723 'LL Road Frame - Black, 60';
--OR
EXEC dbo.SalesOrderDetailbyDate723 @ProductName = 'LL Road Frame - Black, 60';  
--OR
EXECUTE dbo.SalesOrderDetailbyDate723 @ProductName = 'LL Road Frame - Black, 60'
--End of #2----
--Drop procedure
DROP PROCEDURE dbo.SalesOrderDetailbyDate723;
/*******************END******************/
SELECT
    PP.ProductID
    , PP.Name as ProductName
    , LPH.ListPrice
    , FORMAT(isnull(LPH.EndDate, GETDATE()),'MM/dd/yyyy' ) AS ListPriceEndDate
FROM
    Production.Product AS PP
    JOIN Production.ProductListPriceHistory AS LPH ON (PP.ProductID=LPH.ProductID)
WHERE PP.NAME LIKE 'LL Road Frame - Black%'
ORDER by PP.ProductID DESC;
SELECT
    SOD.ProductID
    , PP.Name as 'Product Name'
    , YEAR(SOH.OrderDate) as 'Order Year'
    , SUM(SOD.OrderQty) as 'Sum of Quantity'
from
    Sales.SalesOrderDetail AS SOD
    JOIN Sales.SalesOrderHeader AS SOH
    ON SOD.SalesOrderID = SOH.SalesOrderID
    JOIN Production.Product AS PP
    ON SOD.ProductID=PP.ProductID
WHERE PP.Name LIKE 'LL Road Frame - Black%'
GROUP BY SOD.ProductID, PP.Name, YEAR(SOH.OrderDate)
ORDER BY SOD.ProductID DESC;
