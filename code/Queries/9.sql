CREATE VIEW Sales AS
SELECT Product_in_Orders.Pname, SUM(Product_in_Orders.Quantity) AS SaleQuantity, DATEPART(month, Date_time) AS SaleMonth
FROM Orders, Product_in_Orders
WHERE Orders.ID = Product_in_Orders.OrderID
GROUP BY Product_in_Orders.Pname,DATEPART(month, Date_time)

GO

SELECT DISTINCT s1.Pname
FROM Sales s1, Sales s2, Sales s3
WHERE s3.SaleMonth - s2.SaleMonth = 1
AND s2.SaleMonth - s1.SaleMonth = 1
AND s3.SaleQuantity > s2.SaleQuantity
AND s2.SaleMonth > s1.SaleQuantity
