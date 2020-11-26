SELECT TOP 3 Sname, MAX(TotalSales) AS TotalSale
FROM (SELECT Product_in_Orders.Sname, SUM(Products_in_shops.Price) AS TotalSales
	FROM Orders, Product_in_Orders, Shops, Products_in_shops
	WHERE Orders.ID = Product_in_Orders.OrderID 
	AND Product_in_Orders.Sname = Shops.Name_
	AND Shops.Name_ = Products_in_shops.Sname
	GROUP BY Product_in_Orders.Sname) AS ShopSales
GROUP BY Sname
ORDER BY TotalSale DESC