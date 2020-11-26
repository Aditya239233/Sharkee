SELECT Pname, AVG(DATEDIFF(day,Date_time,Delivery_date)) as avg_delivery_time_in_days
FROM Orders, Product_in_Orders
WHERE Orders.ID = Product_in_Orders.OrderID
AND Date_time BETWEEN '2020-06-01 00:00:00' AND '2020-06-30 23:59:59'
AND Status_ = 'Delivered'
GROUP BY Pname;