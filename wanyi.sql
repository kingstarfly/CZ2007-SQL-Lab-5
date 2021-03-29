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