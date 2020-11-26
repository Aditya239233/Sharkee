SELECT Pname, AVG(Price) AS Average_Price
FROM Price_History
WHERE Pname = 'iPhone XS' 
AND 
((Start_date_ <= '2020-08-01' AND End_date > '2020-08-31')
OR 
End_date BETWEEN '2020-08-01' AND '2020-08-31')
GROUP BY Pname;