USE [master]
RESTORE DATABASE [AdventureWorks2008R2] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\adventure-works-2008r2-oltp.bak' WITH  FILE = 1,  
MOVE N'AdventureWorks2008R2_Data' TO N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AdventureWorks2008r2.mdf',  
MOVE N'AdventureWorks2008R2_Log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AdventureWorks2008R2_log.LDF',  
NOUNLOAD,  STATS = 5

GO

--Exe1
use AdventureWorks2008R2

--Q1
select Count(*) as 'Total Records' from Sales.SalesPerson;

--Q2

Select FirstName+' '+LastName as 'Full Name' from Person.Person where FirstName Like 'B%';

--Q3

Select FirstName,LastName,JobTitle
From Person.Person 
INNER JOIN HumanResources.Employee
ON Person.Person.BusinessEntityID=HumanResources.Employee.BusinessEntityID
AND  JobTitle LIKE '%Design Engineer%' OR JobTitle LIKE '%Tool Designer %' OR JobTitle LIKE'%Marketing Assistant%';
-- We Take % % Because Some Employee is Senior Design Engineer,Senior Tool Designer and Senior Marketing Assistant

-- Q4

Select Name,Color,Weight From Production.Product 
where Weight=(Select MAX(Weight) from Production.Product);

--Q5

Select SpecialOffer.Description,ISNULL(SpecialOffer.MaxQty,0.00) From Sales.SpecialOffer;

--Q6

Select CurrencyRateDate,FromCurrencyCode,ToCurrencyCode,AverageRate
From Sales.CurrencyRate
Where datepart(year,CurrencyRateDate)=2007 and ToCurrencyCode='GBP'; 

--Q7

SELECT ROW_NUMBER() over (order by FirstName asc) As RowNumber,FirstName,LastName
FROM Person.Person
where FirstName like '%ss%';

--Q8

SELECT BusinessEntityID,CommissionPct ,'Commission Band'=
CASE
	WHEN CommissionPct = 0 then 'Band 0'
    WHEN CommissionPct > 0 and CommissionPct <= 0.01 THEN 'Band 1'  
    WHEN CommissionPct > 0.01 and CommissionPct <= 0.015 then 'Band 2'
	WHEN CommissionPct > 0.015 then 'Band 3'
     
END FROM Sales.SalesPerson
Order by CommissionPct;

--Q9

Declare @id int;
Select @id = BusinessEntityID
From Person.Person
where FirstName='Ruth' and LastName ='Ellerbrock' and PersonType='EM'
Exec dbo.uspGetEmployeeManagers @BusinessEntityID=@ID;

--Q10

Select Max(dbo.ufnGetStock(ProductID)) from Production.Product;