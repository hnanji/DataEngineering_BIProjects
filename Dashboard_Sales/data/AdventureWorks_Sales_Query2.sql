/****** Script for SelectTopNRows command from SSMS  ******/
SELECT soh.[SalesOrderID]
      ,soh.[OrderDate]
      ,soh.[OnlineOrderFlag]
      ,soh.[SalesOrderNumber]
      ,soh.[PurchaseOrderNumber]
      ,soh.[CustomerID]
      ,soh.[SalesPersonID]
      ,soh.[TerritoryID]
      ,soh.[TotalDue]
	  ,tr.[TerritoryID]
	  ,tr.[Name] as SubGroup2
      ,tr.[CountryRegionCode]
      ,tr.[Group]
	  ,sp.[BusinessEntityID]
     ,sp.[SalesQuota]
	 ,c.[StoreID]
	 ,CONCAT(p.[FirstName], + ' ' + p.[LastName]) as [SalesRep]
	 ,sod.[ProductID]
	 ,sod.[OrderQty]
	 ,pr.[Name] ProductName
	 ,pr.[ProductSubcategoryID]
	 ,psc.[ProductCategoryID]
	 ,psc.[Name] ProductCategory
	 ,CASE 
        WHEN tr.[CountryRegionCode] = 'US' THEN 'USA'
		WHEN tr.[CountryRegionCode] = 'CA' THEN 'CANADA'
		WHEN tr.[CountryRegionCode] = 'FR' THEN 'FRANCE'
		WHEN tr.[CountryRegionCode] = 'US' THEN 'USA'
		WHEN tr.[CountryRegionCode] = 'DE' THEN 'DEUTCHLAND'
		WHEN tr.[CountryRegionCode] = 'AU' THEN 'AUSTRALIA'
        ELSE 'GREAT BRITAIN'
    END AS CountryName
FROM [AdventureWorks2014].[Sales].[SalesOrderHeader] soh

LEFT OUTER JOIN [AdventureWorks2014].[Sales].[SalesTerritory] tr

ON soh.[TerritoryID] = tr.[TerritoryID]

LEFT OUTER JOIN [AdventureWorks2014].[Sales].[SalesPerson] sp

ON  soh.[SalesPersonID] = sp.[BusinessEntityID] 

LEFT OUTER JOIN [AdventureWorks2014].[Sales].[Customer] c

on soh.[CustomerID]= c.[CustomerID] 

LEFT OUTER JOIN [AdventureWorks2014].[Person].[Person] p

on soh.[SalesPersonID]  = p.[BusinessEntityID]

left outer join [AdventureWorks2014].[Sales].[SalesOrderDetail] sod

on soh.[SalesOrderID] = sod.[SalesOrderID]

left outer join [AdventureWorks2014].[Production].[Product] pr

on sod.ProductID = pr.ProductID

left outer join [AdventureWorks2014].[Production].[ProductSubcategory] psc

on pr.[ProductSubcategoryID] = psc.[ProductSubcategoryID]

where soh.[PurchaseOrderNumber] IS NOT NULL

--and soh.[SalesOrderID] = '43659'

