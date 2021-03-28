USE ssr4g2_xx;

/* 
For Persons who tested positive in their swab test, find the person_id, 
time_of_contact for those who were in Nearby areas as these Persons in 
the timeframe of 14 days before the test result. 
Nearby areas are defined as having euclidean distance of <= 2.
 */
SELECT 
InfectedDetails.infected_person_id as infected_person_id,
InfectedDetails.confirm_infection_timestamp as confirm_infection_timestamp,
CoordinateRec.person_id as suspect_person_id, 
CoordinateRec.timestamp AS time_of_contact

FROM (
    SELECT 
    SwabTest.person_id AS infected_person_id, 
    SwabTest.[timestamp] AS confirm_infection_timestamp,
    CoordinateRec.timestamp as contact_time,
    CoordinateRec.x_coordinates as x1,
    CoordinateRec.y_coordinates as y1

    FROM CoordinateRec, SwabTest

    WHERE 
    SwabTest.person_id = CoordinateRec.person_id AND 
    test_result = 'positive' AND 
    DATEADD(DAY, -14, SwabTest.timestamp) <= CoordinateRec.timestamp AND 
    SwabTest.timestamp >= CoordinateRec.timestamp

) AS InfectedDetails , CoordinateRec

WHERE 
InfectedDetails.contact_time = CoordinateRec.timestamp AND
InfectedDetails.infected_person_id <> CoordinateRec.person_id AND
SQRT(SQUARE(CoordinateRec.x_coordinates - InfectedDetails.x1) + SQUARE(CoordinateRec.y_coordinates - InfectedDetails.y1) ) <= 2
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
    SwabTest.person_id =CheckInOut.person_id AND 
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

