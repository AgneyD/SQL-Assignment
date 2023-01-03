use AdventureWorks2008R2;
GO
Create Proc Person.up_getNameByType @type nchar(5)='IN'
AS
Select FirstName From Person.Person Where PersonType=@type;
GO
 
Execute Person.up_getNameByType;
Execute Person.up_getNameByType @type='EM';