 USE [AdventureWorks2014]
 GO

SELECT s.[CustomerID]
      ,s.[SalesOrderID]
      ,s.[SalesPersonID]
      ,s.[SubTotal]
	  ,s.[OrderDate]
      ,s.[TaxAmt]
      ,s.[Freight]
      ,s.[TotalDue]
	  ,s.[TerritoryID]
	  ,s.[PurchaseOrderNumber]
	  ,tr.[Name] as [Territory]
      ,tr.[CountryRegionCode]
      ,tr.[Group]
	  ,tr.[Name]
	  ,ISNULL(tr.[Name], '') + '-' + ISNULL(tr.[Group], '') AS  [Group]
	  ,CONCAT(p.[FirstName], + ' ' + p.[LastName]) as [SalesRep]
	  ,sod.[OrderQty]
	  ,sod.[ProductID]
	 
 FROM [AdventureWorks2014].[Sales].[SalesOrderHeader] s

LEFT OUTER JOIN [AdventureWorks2014].[Sales].[SalesPerson] sp

  ON s.[SalesOrderID] = sp.[BusinessEntityID]

LEFT OUTER JOIN [AdventureWorks2014].[Sales].[SalesTerritory] tr

 on s.[TerritoryID] = tr.[TerritoryID]

 --where s.[PurchaseOrderNumber] IS NOT NULL

 --------------------------------------------------------------------
LEFT OUTER JOIN [AdventureWorks2014].[Person].[Person] p

on s.[SalesPersonID]  = p.[BusinessEntityID]

LEFT OUTER JOIN [AdventureWorks2014].[Sales].[SalesOrderDetail] sod

on s.[SalesOrderID] = sod.[SalesOrderID]

where s.[PurchaseOrderNumber] IS NOT NULL





 ORDER BY s.[CustomerID]



