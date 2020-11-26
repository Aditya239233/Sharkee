WITH Rated_5(Pname,number) AS(
SELECT Pname, COUNT(Rating) as number
FROM Feedback
WHERE Rating = 5
AND Date_time BETWEEN '2020-08-01 00:00:00' AND '2020-08-31 23:59:59'
GROUP BY Pname
HAVING COUNT(Rating)>= 100)

SELECT Feedback.Pname, AVG(Rating) AS Average_Rating
FROM Feedback,Rated_5
WHERE Feedback.Pname = Rated_5.Pname
GROUP BY Feedback.Pname
ORDER BY AVG(Rating);