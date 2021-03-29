USE ssr4g2_xx;

BEGIN TRANSACTION;
-- Darren
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

BEGIN TRANSACTION;
-- Bob
-- • Find the users who have checked in more than 10 locations every day in the last week.

SELECT DISTINCT person_id
--, datepart(DAY, checkin_time) AS Day, COUNT(location_id) AS count
FROM CheckInOut
WHERE checkin_time <= GETDATE() AND checkin_time >= dateadd(DAY, -7, GETDATE())
GROUP BY person_id, datepart(DAY, checkin_time)
HAVING COUNT(location_id) > 10
;


-- • Find all the couples such that each couple has checked in at least 2 common locations on 1 Jan 2021.

SELECT person1_id, person2_id
FROM Family, CheckInOut AS C1, CheckInOut AS C2
WHERE relation_type = 'Married' AND CONVERT(DATE, C1.checkin_time) = '2021-01-01' AND CONVERT(DATE, C2.checkin_time) = '2021-01-01' AND Family.person1_id = C1.person_id AND Family.person2_id = C2.person_id AND C1.location_id = C2.location_id
GROUP BY person1_id, person2_id
HAVING COUNT(*) > 1
;

COMMIT;

BEGIN TRANSACTION;
-- Wanyi
-- • Find 5 locations ids and their names OF THE LOCATION that are checked in by the most number of users in the last 10 days. (assume they mean - find the top 5 locations where the most number of users checked into the last 10 days.)

SELECT TOP 5
      Location.location_id, Location.name, NewCheckInOut.NumUsers
FROM Location JOIN (
            SELECT location_id, COUNT(DISTINCT person_id) AS NumUsers
      FROM CheckInOut
      WHERE checkin_time <= GETDATE() AND checkin_time >= dateadd(DAY, -10, GETDATE())
      GROUP BY location_id
      ) AS NewCheckInOut
      ON NewCheckInOut.location_id = Location.location_id
-- GROUP BY Location.location_id, Location.name
ORDER BY NewCheckInOut.NumUsers DESC
;

-- • Given a user, find the list of users that checked in the same locations with the user within 1 hour in the last week.
SELECT DISTINCT X.person_id AS given_user, X.location_id, Y.person_id AS other_user
FROM CheckInOut AS X
      JOIN CheckInOut AS Y
      ON X.location_id = Y.location_id
WHERE DATEDIFF(hour, X.checkin_time, Y.checkin_time) <= 1
      AND X.checkin_time >= dateadd(DAY, -7, GETDATE())
      AND X.checkin_time <= GETDATE()
      AND Y.checkin_time >= dateadd(DAY, -7, GETDATE())
      AND Y.checkin_time <= GETDATE()
      AND X.location_id = Y.location_id
      AND X.person_id <> Y.person_id
-- GROUP BY X.person_id, X.location_id, Y.person_id
ORDER BY X.person_id
;
COMMIT;


BEGIN TRANSACTION;
-- XX
-- Design two queries that are not in the above list. They are evaluated based on the usefulness, complexity, and the interestingness. You are encouraged (not compulsory) to design trigger queries, from which you can learn something different and new.

/* 
For Persons who tested positive in their swab test, find the person_id, 
time_of_contact for those who were in Nearby areas as these Persons in 
the timeframe of 14 days before the test result. 
Nearby areas are defined as having euclidean distance of <= 2.
 */
SELECT
      InfectedDetails.infected_person_id AS infected_person_id,
      CoordinateRec.person_id AS suspect_person_id,
      COUNT(CoordinateRec.timestamp) as number_of_contact_times,
      MAX(CoordinateRec.timestamp) AS last_time_of_contact

FROM (
    SELECT
            SwabTest.person_id AS infected_person_id,
            CoordinateRec.timestamp AS contact_time,
            CoordinateRec.x_coordinates AS x1,
            CoordinateRec.y_coordinates AS y1

      FROM CoordinateRec, SwabTest

      WHERE 
            SwabTest.person_id = CoordinateRec.person_id AND
            test_result = 'positive' AND

            -- meet less than 14 days before swab test date
            DATEADD(DAY, -14, SwabTest.timestamp) <= CoordinateRec.timestamp AND

            -- meet before swab test date
            SwabTest.timestamp >= CoordinateRec.timestamp
 
) AS InfectedDetails , CoordinateRec

WHERE
      InfectedDetails.contact_time = CoordinateRec.timestamp AND
      InfectedDetails.infected_person_id <> CoordinateRec.person_id AND
      SQRT(SQUARE(CoordinateRec.x_coordinates - InfectedDetails.x1) + SQUARE(CoordinateRec.y_coordinates - InfectedDetails.y1) ) <= 2

GROUP BY infected_person_id, CoordinateRec.person_id
ORDER BY COUNT(*) DESC, last_time_of_contact DESC
;


/*
For Persons who tested positive in their swab test, find the location id of all locations 
these Persons checked-in over the past 14 days from the result date, 
and the person_ids of all other Persons who were present at these locations 
while the potential carrier was there.
*/
SELECT DISTINCT
      CheckInOut.location_id AS location_id,
      InfectedDetails.infected_person_id AS infected_person_id,
      CheckInOut.person_id AS suspect_person_id

FROM (
    SELECT
            SwabTest.person_id AS infected_person_id,
            CheckInOut.checkin_time AS infected_checkin_time,
            CheckInOut.checkout_time AS infected_checkout_time,
            CheckInOut.location_id AS location_id

      FROM CheckInOut, SwabTest

      WHERE 
            SwabTest.person_id = CheckInOut.person_id AND
            test_result = 'positive' AND
            DATEADD(DAY, -14, SwabTest.timestamp) < CheckInOut.checkin_time AND
            DATEADD(DAY, -14, SwabTest.timestamp) < CheckInOut.checkout_time AND SwabTest.timestamp > CheckInOut.checkin_time AND
            SwabTest.timestamp > CheckInOut.checkout_time
 
) AS InfectedDetails , CheckInOut

WHERE 
InfectedDetails.location_id = CheckInOut.location_id AND
      InfectedDetails.infected_person_id <> CheckInOut.person_id AND
      InfectedDetails.infected_checkin_time <= CheckInOut.checkout_time AND
      InfectedDetails.infected_checkout_time >= CheckInOut.checkin_time
;
COMMIT;
