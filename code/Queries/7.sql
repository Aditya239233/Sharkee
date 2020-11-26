WITH Purchases (UserID, Pname, Price) AS
(SELECT UserID, Pname, Price
FROM (SELECT DISTINCT Orders.UserID, Product_in_Orders.Pname, Product_in_Orders.Price 
        FROM Orders, Product_in_Orders, Products_in_shops
        WHERE Orders.ID = Product_in_Orders.OrderID
            AND Product_in_Orders.PName = Products_in_shops.PName
            AND Product_in_Orders.Sname = Products_in_shops.Sname
            AND UserID = (
        SELECT UserID
        FROM (SELECT UserID, COUNT(ID) AS ComplaintCount
    FROM Complaints
    GROUP BY UserID) AS TotalComplaints
        WHERE ComplaintCount = (SELECT MAX(ComplaintCount) AS MaxComplainer
                                FROM (SELECT UserID, COUNT(ID) AS ComplaintCount
    FROM Complaints
    GROUP BY UserID) AS TotalComplaints))) a
)

SELECT UserID, Pname, Price
FROM Purchases
WHERE Price = (SELECT MAX(Price) FROM Purchases)