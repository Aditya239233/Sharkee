SELECT
	TOP 1
    EmployeeID, 
    AVG(DATEDIFF(DAY,Filed_date_time, Handled_date_time)) AS Latancy_In_Days
FROM COMPLAINTS
WHERE Handled_date_time IS NOT NULL
GROUP BY EmployeeID
ORDER BY Latancy_In_Days