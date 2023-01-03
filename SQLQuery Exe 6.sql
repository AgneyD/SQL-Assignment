use AdventureWorks2008R2;
GO
CREATE TRIGGER CheckPriceRise
ON Production.Product
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	IF UPDATE(ListPrice)
		BEGIN
			UPDATE Production.Product
			SET ListPrice = IIF((ins.ListPrice - del.ListPrice) > del.ListPrice*0.15, del.ListPrice, ins.ListPrice)
			FROM deleted AS d, Production.Product AS p
			INNER JOIN inserted AS ins ON ins.ProductID = p.ProductID
		END
END
GO
SELECT * FROM Production.Product;
UPDATE Production.Product
SET ListPrice = 14
WHERE ProductID = 1;