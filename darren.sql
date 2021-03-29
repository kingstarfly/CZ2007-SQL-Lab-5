-- • Find the locations that receive at least 5 ratings of “5” in Dec 2020, and order them by their average ratings.
SELECT Location.location_id, name, AVG(CAST(checkout_rating AS FLOAT)) AS AvgRating
FROM Location, CheckInOut
WHERE Location.location_id = CheckInOut.location_id AND
    Location.location_id IN (SELECT location_id
    FROM CheckInOut
    WHERE checkout_rating = 5 AND
        MONTH(checkout_time) = 12 AND
        YEAR(checkout_time) = 2020
    GROUP BY location_id
    HAVING COUNT(*) >= 5)
GROUP BY Location.location_id, name
ORDER BY AVG(CAST(checkout_rating AS FLOAT)) DESC
;

--• Find the companies whose posts have received the most number of comments for each week of the past month.
SELECT CONVERT(DATE, DATEADD(week, DATEDIFF(week, 0, comment_timestamp - 1), 0)) AS WeekStart, company_id, company_name, COUNT(comment_id) AS NumComments
FROM Company AS C1, Post, Comment AS X
WHERE C1.contact_person_id = Post.person_id AND
    Post.post_id = X.post_id AND
    comment_timestamp <= GETDATE() AND
    comment_timestamp >= DATEADD(month, -1, GETDATE())
GROUP BY DATEPART(week, X.comment_timestamp), DATEADD(week, DATEDIFF(week, 0, comment_timestamp - 1), 0), company_id, company_name
HAVING 
COUNT(comment_id) >= ALL 
(
    SELECT COUNT(comment_id)
FROM Comment AS Y, Company AS C2, Post
WHERE 
        C2.contact_person_id = Post.person_id AND
    Post.post_id = Y.post_id AND
    DATEPART(week, Y.comment_timestamp) = DATEPART(week, X.comment_timestamp) AND
    C1.company_id <> C2.company_id
GROUP BY company_id
)
ORDER BY DATEPART(week, X.comment_timestamp);
COMMIT;
