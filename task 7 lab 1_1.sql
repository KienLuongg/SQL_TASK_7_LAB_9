CREATE DATABASE Lab11
GO
USE Lab11
GO 

CREATE VIEW ProductList
AS
SELECT ProductID, Name FROM AdventureWorks2019.Production.Product
GO 

SELECT * FROM ProductList