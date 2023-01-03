use AdventureWorks2008R2;
 
Select Top 5 SalesOrderID,AccountNumber,OrderDate 
from Sales.SalesOrderHeader
where AccountNumber IN
	(Select AccountNumber from Sales.SalesOrderHeader -- Show Account No Which Has Subtotal is > 70000  
	group by AccountNumber Having SUM(SubTotal)>70000)
Order By OrderDate;