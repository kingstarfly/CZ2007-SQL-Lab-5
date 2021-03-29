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