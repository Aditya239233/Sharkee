SELECT Products.Name_, COUNT(Products.Name_) as no_of_shops_selling
FROM Products, Products_in_shops
WHERE Products.Maker = 'Samsung'
AND Products.Name_ = Products_in_shops.Pname
GROUP BY Products.Name_;