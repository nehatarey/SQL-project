select * --PP.Name, PP.ListPrice
from Production.Product PP
join Production.ProductSubcategory PS 
on PP.ProductSubcategoryID = PS.ProductSubcategoryID
join Sales.SalesOrderDetail SO 
on PP.ProductSubcategoryID = 
where PS.Name = 'Cranksets';

select * from Production.ProductSubcategory where 
Name = 'Cranksets' ; --subcategory = 8
select * from Production.ProductCategory;

select --PP.ProductID,SOH.SalesOrderID, SOD.SalesOrderID, SOD.SalesOrderDetailID, 
PP.Name, --PP.ProductSubcategoryID,
PP.ListPrice, SOD.OrderQty, --SOD.LineTotal, SOH.TaxAmt , SOH.ShipToAddressID, 
PA.City, SOD.LineTotal+SOH.TaxAmt as TotalCost
,SOH.ShipDate, FORMAT(SOH.ShipDate, 'MM/dd/yyyy') as DateShipped
from Production.Product PP
join Production.ProductSubcategory PS 
on PP.ProductSubcategoryID = PS.ProductSubcategoryID
join Sales.SalesOrderDetail SOD
on PP.ProductID = SOD.ProductID
join sales.SalesOrderHeader SOH 
on SOD.SalesOrderID = SOH.SalesOrderID
join Person.Address PA
on PA.AddressID=SOH.ShipToAddressID
where PS.Name = 'Cranksets'
and PA.City = 'London'; -- with this getting 423
--How many product ids
select distinct ProductID
from Production.Product
where ProductSubcategoryID = '8'--gives producID inb ('949', '950', '951')
;
--how many Sales order details for product ids
select * 
from Sales.SalesOrderDetail SOD 
join Sales.SalesOrderHeader SOH 
on SOD.SalesOrderID = SOH.SalesOrderID
where SOD.ProductID in ('949', '950', '951');--423

select *
from Production

select SOD.
from Sales.SalesOrderDetail SOD
join Sales.SalesOrderHeader SOH 
on SOH.SalesOrderID = SOD.SalesOrderID
