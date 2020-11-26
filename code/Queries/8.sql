CREATE VIEW AllProducts AS 
(SELECT PName, SUM(OrderQuantity) AS TotalQuantity
FROM ProductsInOrder
GROUP BY PName);
GO

CREATE VIEW NonTop1Products AS
(SELECT * 
FROM AllProducts AP
WHERE AP.TotalQuantity <> (SELECT MAX(TotalQuantity)
                           FROM Allproducts AP2));
GO

CREATE VIEW NonTop2Products AS
(SELECT * 
FROM NonTop1Products NT
WHERE NT.TotalQuantity <> (SELECT MAX(TotalQuantity)
                           FROM NonTop1Products NT1));
GO

CREATE VIEW NonTop3Products AS
(SELECT * 
FROM NonTop2Products NT
WHERE NT.TotalQuantity <> (SELECT MAX(TotalQuantity)
                           FROM NonTop2Products NT1));
GO

CREATE VIEW NonTop4Products AS
(SELECT * 
FROM NonTop3Products NT
WHERE NT.TotalQuantity <> (SELECT MAX(TotalQuantity)
                           FROM NonTop3Products NT1));
GO

CREATE VIEW NonTop5Products AS
(SELECT * 
FROM NonTop4Products NT
WHERE NT.TotalQuantity <> (SELECT MAX(TotalQuantity)
                           FROM NonTop4Products NT1));
GO

--Assume that there can be more than 5 products if products have the same order quantity.
CREATE VIEW TopProducts AS
(SELECT *
FROM AllProducts 
EXCEPT
SELECT *
FROM NonTop5Products);
GO

CREATE VIEW UserCount AS
SELECT COUNT(*) AS NumUniqueUsers
FROM Users;
GO

CREATE VIEW UniquePurchases AS
SELECT PName, Count(UserID) AS NumUniquePurchases
FROM (SELECT DISTINCT U.UserID, PName
	  FROM Users U,Orders O,ProductsInOrder PIO
	  WHERE U.UserID=O.UserID AND O.OrderID=PIO.OrderID) AS UniquePurchase
GROUP BY PName;
GO

SELECT TP.PName
FROM TopProducts TP, UserCount UC,UniquePurchases UP
WHERE TP.PName=UP.PName AND NumUniquePurchases<NumUniqueUsers;
GO