select
    SOD.SalesOrderID,
    TH.ReferenceOrderID,
    TH.TransactionID,
    SOD.SalesOrderDetailID ,
    PP.ProductID,
    PP.Name,
    PP.ListPrice,
    soh.OrderDate,
    th.TransactionDate
from Production.Product PP
    join Sales.SalesOrderDetail SOD
    on PP.ProductID=SOD.ProductID
    join sales.SalesOrderHeader SOH
    on SOH.SalesOrderID = SOD.SalesOrderID
    join Production.TransactionHistory TH
    on SOD.SalesOrderID = TH.ReferenceOrderID
where Name = 'LL Road Frame - Black, 60'
    and th.TransactionType = 'S';
--simpler version of above query, will look for the sales - gives 9 rows
select
    PP.ProductID,
    PP.Name,
    TH.TransactionType,
    TH.ReferenceOrderID as SalesOrderID ,
    TH.TransactionDate as SalesDate,
    TH.ModifiedDate
into #MySalesTranDates
from Production.Product PP
    join Production.TransactionHistory TH
    on PP.ProductID = TH.ProductID
where PP.Name = 'LL Road Frame - Black, 60'
    and TH.TransactionType = 'S';
--select the temp table
select *
from #MySalesTranDates;
---Running the same query on Trnasaction History Archive table - gives 43 rows
select
    PP.ProductID,
    PP.Name,
    THA.TransactionType,
    THA.ReferenceOrderID as SalesOrderID ,
    THA.TransactionDate as SalesDate,
    THA.ModifiedDate
--into #MySalesTranDates
from Production.Product PP
    join Production.TransactionHistoryArchive THA
    on PP.ProductID = THA.ProductID
where PP.Name = 'LL Road Frame - Black, 60'
    and THA.TransactionType = 'S';
--insert above data into the temp table
INSERT into #MySalesTranDates
select
    PP.ProductID,
    PP.Name,
    THA.TransactionType,
    THA.ReferenceOrderID as SalesOrderID ,
    THA.TransactionDate as SalesDate,
    THA.ModifiedDate
from Production.Product PP
    join Production.TransactionHistoryArchive THA
    on PP.ProductID = THA.ProductID
where PP.Name = 'LL Road Frame - Black, 60'
    and THA.TransactionType = 'S';
--do a join on sales order header and details : SOH and SOD join = 52 rows, both ways gives 52 rows
SELECT
    SOH.SalesOrderID,
    SOD.SalesOrderID,
    SOD.SalesOrderDetailID
from sales.SalesOrderDetail SOD
    join sales.SalesOrderHeader SOH
    on SOD.SalesOrderID = SOH.SalesOrderID
where SOD.ProductID = '723';


--See the created tables in temp db
select *
from tempdb..sysobjects
where name like '#MySalesTranDates%';
--Dropping the table and restarting;
BEGIN TRY
DROP TABLE #MySalesTranDates
END TRY
BEGIN CATCH SELECT 1 END CATCH
