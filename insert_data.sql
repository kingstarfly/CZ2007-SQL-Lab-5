USE ssr4g2_xx;

BEGIN TRANSACTION;

INSERT INTO Person
    (person_id, sex, birthday, hometown, risk_level, phone_number, name, company_id)
VALUES
    ('S9804253I', 'Male', CONVERT(date, '2013-01-29'), 'Singapore', 'high', '82033723', 'XX', NULL),
    ('S1234567A', 'Female', CONVERT(date, '2013-01-29'), 'Malaysia', 'low', '81234567', 'Brenda', NULL),
    ('S9810422D', 'Male', CONVERT(date, '1998-03-30'), 'Singapore', 'low', '97269993', 'Darren Ng', NULL),
    ('S9823465D', 'Male', CONVERT(date, '1956-03-30'), 'Wakanda', 'low', '91234567', 'Tchalla', NULL),
    ('T0032522A', 'Male', CONVERT(date, '2000-01-28'), 'Australia', 'high', '92250924', 'Bob Ng', NULL)
;

INSERT INTO ContactPerson
    (person_id)
VALUES
    ('S9804253I'),
    ('S1234567A'),
    ('S9810422D')
;

INSERT INTO Company
    (company_name, company_address, company_email, contact_person_id)
VALUES
    ('Intel', '64 Nanyang Crescent', 'intel@example.com', 'S9804253I'),
    ('AMD', '65 Nanyang Crescent', 'amd@example.com', 'S1234567A'),
    ('NVIDIA', '66 Nanyang Crescent', 'nvidia@example.com', 'S9810422D')
;

UPDATE Person
SET Person.company_id = 1

UPDATE Person
SET Person.company_id = 1
WHERE Person.person_id = 'S9804253I';

UPDATE Person
SET Person.company_id = 2
WHERE Person.person_id = 'S1234567A';

UPDATE Person
SET Person.company_id = 3
WHERE Person.person_id = 'S9810422D';

COMMIT;

-- LOCATIONS
BEGIN TRANSACTION;

INSERT INTO [Location]
    (x_coordinates, y_coordinates, owner, description, address, name)
VALUES
    (1, 1, 'Capitaland', 'This is a Shopping Mall', '01 Nanyang Avenue', 'Jurong Point'),
    (2, 2, 'Far East', 'This is a Condominium' , '02 Nanyang Avenue', 'North Hill'),
    (3, 3, 'SMRT', 'This is an MRT Station', '03 Nanyang Avenue', 'Boon Lay MRT Station'),
    (4, 4, 'DBS', 'This is a Bank Branch', '04 Nanyang Avenue', 'DBS Bank Jurong West'),
    (5, 5, 'Golden Village', 'This is a Cinema', '05 Nanyang Avenue', 'GV Jurong Point'),
    (6, 6, 'Cathay', 'This is a Cinema too', '06 Nanyang Avenue', 'Cathay Jurong Point')
;

COMMIT;

-- CATEGORIES
BEGIN TRANSACTION;

INSERT INTO Category
    (label)
VALUES
    ('Mall'),
    ('Cinema'),
    ('Bank'),
    ('MRT Station'),
    ('Residence'),
    ('Condominium')
;

INSERT INTO PartOf
    (super_category_label, sub_category_label)
VALUES
    ('Mall', 'Cinema'),
    ('Residence', 'Condominium')
;
COMMIT;

-- ASSOCIATEDWITH
BEGIN TRANSACTION;

INSERT INTO AssociatedWith
    (location_id, label)
VALUES
    (1, 'Mall'),
    (2, 'Condominium'),
    (3, 'MRT Station'),
    (4, 'Bank'),
    (5, 'Cinema'),
    (6, 'Cinema')
;

COMMIT;

-- FAMILY
BEGIN TRANSACTION;

INSERT INTO Family
    (person1_id, person2_id, relation_type)
VALUES
    ('S9804253I', 'S1234567A', 'Married'),
    ('S9810422D', 'S9823465D', 'Married'),
    ('S1234567A', 'S9823465D', 'Daughter-Father')
;

COMMIT;

-- QUERY 4 COUPLES
BEGIN TRANSACTION;

INSERT INTO CheckInOut
    (person_id, location_id, checkin_time, checkin_review, checkout_time, checkout_rating)
VALUES
    ('S9804253I', 1, CONVERT(datetime, '2021-01-01 12:34:56'), 'this place is great', CONVERT(datetime, '2021-01-01 14:34:56'), 5),
    ('S1234567A', 1, CONVERT(datetime, '2021-01-01 12:35:56'), 'this place not too bad', CONVERT(datetime, '2021-01-01 14:35:56'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-01-01 17:34:56'), 'this place not good', CONVERT(datetime, '2021-01-01 19:34:56'), 2),
    ('S1234567A', 2, CONVERT(datetime, '2021-01-01 17:35:56'), 'this place quite bad', CONVERT(datetime, '2021-01-01 19:35:56'), 1)
;


COMMIT;

-- QUERY 1 (5 ratings)
BEGIN TRANSACTION;

INSERT INTO CheckInOut
    (person_id, location_id, checkin_time, checkin_review, checkout_time, checkout_rating)
VALUES
    ('S9804253I', 1, CONVERT(datetime, '2020-12-01 12:00:00'), 'this place is great', CONVERT(datetime, '2020-12-01 16:00:00'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2020-12-02 12:00:00'), 'this place not too bad', CONVERT(datetime, '2020-12-02 16:00:00'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2020-12-03 12:00:00'), 'this place not good', CONVERT(datetime, '2020-12-03 16:00:00'), 5),
    ('S1234567A', 1, CONVERT(datetime, '2020-12-04 12:00:00'), 'this place quite bad', CONVERT(datetime, '2020-12-04 16:00:00'), 5),
    ('S1234567A', 1, CONVERT(datetime, '2020-12-05 12:00:00'), 'this place quite bad', CONVERT(datetime, '2020-12-05 16:00:00'), 5),
    ('S1234567A', 1, CONVERT(datetime, '2020-12-06 12:00:00'), 'this place quite bad', CONVERT(datetime, '2020-12-06 16:00:00'), 3),

    ('S9810422D', 2, CONVERT(datetime, '2020-12-01 12:00:00'), 'this place is great', CONVERT(datetime, '2020-12-01 16:00:00'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2020-12-02 12:00:00'), 'this place not too bad', CONVERT(datetime, '2020-12-02 16:00:00'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2020-12-03 12:00:00'), 'this place not good', CONVERT(datetime, '2020-12-03 16:00:00'), 5),
    ('S9823465D', 2, CONVERT(datetime, '2020-12-04 12:00:00'), 'this place quite bad', CONVERT(datetime, '2020-12-04 16:00:00'), 5),
    ('S9823465D', 2, CONVERT(datetime, '2020-12-05 12:00:00'), 'this place quite bad', CONVERT(datetime, '2020-12-05 16:00:00'), 5),
    ('S9823465D', 2, CONVERT(datetime, '2020-12-06 12:00:00'), 'this place quite bad', CONVERT(datetime, '2020-12-06 16:00:00'), 1),

    ('T0032522A', 3, CONVERT(datetime, '2020-12-01 12:00:00'), 'this place is great', CONVERT(datetime, '2020-12-01 16:00:00'), 5),
    ('T0032522A', 3, CONVERT(datetime, '2020-12-02 12:00:00'), 'this place not too bad', CONVERT(datetime, '2020-12-02 16:00:00'), 5),
    ('T0032522A', 3, CONVERT(datetime, '2020-12-03 12:00:00'), 'this place not good', CONVERT(datetime, '2020-12-03 16:00:00'), 5),
    ('T0032522A', 3, CONVERT(datetime, '2020-12-04 12:00:00'), 'this place quite bad', CONVERT(datetime, '2020-12-04 16:00:00'), 5),
    ('T0032522A', 3, CONVERT(datetime, '2020-12-05 12:00:00'), 'this place quite bad', CONVERT(datetime, '2020-12-05 16:00:00'), 5),
    ('T0032522A', 3, CONVERT(datetime, '2020-12-06 12:00:00'), 'this place quite bad', CONVERT(datetime, '2020-12-06 16:00:00'), 1),
    ('T0032522A', 3, CONVERT(datetime, '2020-12-07 12:00:00'), 'this place quite bad', CONVERT(datetime, '2020-12-07 16:00:00'), 1)
;

COMMIT;

-- QUERY 2 POSTS
BEGIN TRANSACTION;

INSERT INTO Post
    (person_id, location_id, timestamp, content)
VALUES
    ('S9804253I', 1, CONVERT(datetime, '2021-03-03 12:00:00'), 'Jurong Point has nice shops!'),
    -- week 1 winner
    ('S9810422D', 3, CONVERT(datetime, '2021-03-05 12:00:00'), 'Boon Lay MRT station is very close to JP!'),

    ('S1234567A', 2, CONVERT(datetime, '2021-03-10 12:00:00'), 'North Hill has nice monkeys!'),
    -- week 2 winner
    ('S1234567A', 2, CONVERT(datetime, '2021-03-11 12:00:00'), 'I love North Hill :D'),

    ('S9810422D', 3, CONVERT(datetime, '2021-03-17 12:00:00'), 'Boon Lay MRT station is very close to JP!'),
    -- week 3 winner

    ('S9804253I', 2, CONVERT(datetime, '2021-03-24 12:00:00'), 'I live in North Hill.')
-- week 4 winner
;


COMMIT;

-- QUERY 2 COMMENTS
BEGIN TRANSACTION;

INSERT INTO Comment
    (post_id, commentor_id, comment, comment_timestamp)
VALUES
    -- week 1
    (1, 'T0032522A', 'I agree.', CONVERT(datetime, '2021-03-04 12:00:00')),
    (1, 'T0032522A', 'I concur.', CONVERT(datetime, '2021-03-04 12:01:00')),
    (1, 'T0032522A', 'Why nobody agree with me?', CONVERT(datetime, '2021-03-04 12:02:00')),
    (1, 'T0032522A', 'Hello anyone there...', CONVERT(datetime, '2021-03-04 12:03:00')),
    (2, 'T0032522A', 'Train breakdown today D:', CONVERT(datetime, '2021-03-05 12:00:00')),

    -- week 2
    (3, 'T0032522A', 'I like monkeys.', CONVERT(datetime, '2021-03-10 17:00:00')),
    (3, 'T0032522A', 'Anyone else likes monkeys?.', CONVERT(datetime, '2021-03-10 17:01:00')),
    (3, 'T0032522A', 'Remember to close your windows!!', CONVERT(datetime, '2021-03-10 17:02:00')),
    (1, 'T0032522A', 'Im back', CONVERT(datetime, '2021-03-11 12:00:00')),
    (4, 'T0032522A', 'Hey I <3 nh too.', CONVERT(datetime, '2021-03-12 12:00:00')),

    -- week 3
    (5, 'T0032522A', 'Boon lay rocks yeaa', CONVERT(datetime, '2021-03-18 12:00:00')),

    -- week 4
    (6, 'T0032522A', 'hey which block?', CONVERT(datetime, '2021-03-25 12:00:00'))
;

COMMIT;

-- QUERY 3 LOCATIONS CHECKINOUT
BEGIN TRANSACTION;

INSERT INTO CheckInOut
    (person_id, location_id, checkin_time, checkin_review, checkout_time, checkout_rating)
VALUES

    -- day 1
    ('S9804253I', 1, CONVERT(datetime, '2021-03-23 12:00:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:00:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-23 12:01:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:01:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-23 12:02:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:02:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-23 12:03:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:03:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-23 12:04:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:04:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-23 12:05:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:05:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-23 12:06:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:06:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-23 12:07:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:07:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-23 12:08:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:08:01'), 5),
    ('S9804253I', 4, CONVERT(datetime, '2021-03-23 12:09:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:09:01'), 5),
    ('S9804253I', 5, CONVERT(datetime, '2021-03-23 12:10:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:10:01'), 5),

    -- day 2
    ('S9804253I', 1, CONVERT(datetime, '2021-03-24 12:00:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:00:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-24 12:01:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:01:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-24 12:02:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:02:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-24 12:03:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:03:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-24 12:04:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:04:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-24 12:05:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:05:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-24 12:06:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:06:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-24 12:07:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:07:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-24 12:08:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:08:01'), 5),
    ('S9804253I', 4, CONVERT(datetime, '2021-03-24 12:09:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:09:01'), 5),
    ('S9804253I', 5, CONVERT(datetime, '2021-03-24 12:10:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:10:01'), 5),

    -- day 3
    ('S9804253I', 1, CONVERT(datetime, '2021-03-25 12:00:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:00:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-25 12:01:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:01:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-25 12:02:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:02:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-25 12:03:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:03:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-25 12:04:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:04:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-25 12:05:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:05:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-25 12:06:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:06:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-25 12:07:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:07:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-25 12:08:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:08:01'), 5),
    ('S9804253I', 4, CONVERT(datetime, '2021-03-25 12:09:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:09:01'), 5),
    ('S9804253I', 5, CONVERT(datetime, '2021-03-25 12:10:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:10:01'), 5),

    -- day 4
    ('S9804253I', 1, CONVERT(datetime, '2021-03-26 12:00:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:00:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-26 12:01:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:01:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-26 12:02:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:02:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-26 12:03:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:03:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-26 12:04:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:04:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-26 12:05:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:05:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-26 12:06:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:06:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-26 12:07:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:07:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-26 12:08:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:08:01'), 5),
    ('S9804253I', 4, CONVERT(datetime, '2021-03-26 12:09:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:09:01'), 5),
    ('S9804253I', 5, CONVERT(datetime, '2021-03-26 12:10:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:10:01'), 5),

    -- day 5
    ('S9804253I', 1, CONVERT(datetime, '2021-03-27 12:00:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:00:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-27 12:01:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:01:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-27 12:02:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:02:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-27 12:03:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:03:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-27 12:04:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:04:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-27 12:05:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:05:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-27 12:06:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:06:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-27 12:07:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:07:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-27 12:08:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:08:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-27 12:09:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:09:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-27 12:10:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:10:01'), 5),

    -- day 6!!!
    ('S9804253I', 1, CONVERT(datetime, '2021-03-28 12:00:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:00:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-28 12:01:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:01:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-28 12:02:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:02:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-28 12:03:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:03:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-28 12:04:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:04:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-28 12:05:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:05:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-28 12:06:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:06:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-28 12:07:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:07:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-28 12:08:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:08:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-28 12:09:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:09:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-28 12:10:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:10:01'), 5),

    -- day 7
    ('S9804253I', 1, CONVERT(datetime, '2021-03-29 12:00:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:00:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-29 12:01:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:01:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-29 12:02:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:02:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-29 12:03:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:03:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-29 12:04:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:04:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-29 12:05:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:05:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-29 12:06:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:06:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-29 12:07:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:07:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-29 12:08:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:08:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-29 12:09:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:09:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-29 12:10:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:10:01'), 5),

    -- day 8
    ('S9804253I', 1, CONVERT(datetime, '2021-03-30 12:00:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:00:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-30 12:01:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:01:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-30 12:02:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:02:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-30 12:03:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:03:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-30 12:04:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:04:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-30 12:05:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:05:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-30 12:06:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:06:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-30 12:07:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:07:01'), 5),
    ('S9804253I', 3, CONVERT(datetime, '2021-03-30 12:08:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:08:01'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-03-30 12:09:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:09:01'), 5),
    ('S9804253I', 2, CONVERT(datetime, '2021-03-30 12:10:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:10:01'), 5),

    -- NEXT USER

    -- day 1
    ('S9810422D', 1, CONVERT(datetime, '2021-03-23 12:00:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:00:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-23 12:01:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:01:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-23 12:02:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:02:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-23 12:03:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:03:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-23 12:04:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:04:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-23 12:05:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:05:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-23 12:06:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:06:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-23 12:07:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:07:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-23 12:08:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:08:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-23 12:09:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:09:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-23 12:10:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:10:01'), 5),

    -- day 2
    ('S9810422D', 1, CONVERT(datetime, '2021-03-24 12:00:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:00:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-24 12:01:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:01:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-24 12:02:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:02:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-24 12:03:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:03:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-24 12:04:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:04:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-24 12:05:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:05:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-24 12:06:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:06:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-24 12:07:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:07:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-24 12:08:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:08:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-24 12:09:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:09:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-24 12:10:00'), 'this place is great', CONVERT(datetime, '2021-03-24 12:10:01'), 5),

    -- day 3
    ('S9810422D', 1, CONVERT(datetime, '2021-03-25 12:00:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:00:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-25 12:01:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:01:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-25 12:02:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:02:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-25 12:03:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:03:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-25 12:04:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:04:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-25 12:05:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:05:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-25 12:06:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:06:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-25 12:07:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:07:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-25 12:08:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:08:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-25 12:09:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:09:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-25 12:10:00'), 'this place is great', CONVERT(datetime, '2021-03-25 12:10:01'), 5),

    -- day 4
    ('S9810422D', 1, CONVERT(datetime, '2021-03-26 12:00:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:00:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-26 12:01:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:01:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-26 12:02:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:02:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-26 12:03:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:03:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-26 12:04:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:04:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-26 12:05:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:05:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-26 12:06:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:06:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-26 12:07:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:07:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-26 12:08:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:08:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-26 12:09:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:09:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-26 12:10:00'), 'this place is great', CONVERT(datetime, '2021-03-26 12:10:01'), 5),

    -- day 5
    ('S9810422D', 1, CONVERT(datetime, '2021-03-27 12:00:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:00:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-27 12:01:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:01:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-27 12:02:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:02:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-27 12:03:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:03:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-27 12:04:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:04:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-27 12:05:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:05:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-27 12:06:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:06:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-27 12:07:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:07:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-27 12:08:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:08:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-27 12:09:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:09:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-27 12:10:00'), 'this place is great', CONVERT(datetime, '2021-03-27 12:10:01'), 5),

    -- day 6!!!
    ('S9810422D', 1, CONVERT(datetime, '2021-03-28 12:00:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:00:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-28 12:01:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:01:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-28 12:02:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:02:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-28 12:03:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:03:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-28 12:04:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:04:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-28 12:05:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:05:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-28 12:06:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:06:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-28 12:07:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:07:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-28 12:08:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:08:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-28 12:09:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:09:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-28 12:10:00'), 'this place is great', CONVERT(datetime, '2021-03-28 12:10:01'), 5),

    -- day 7
    ('S9810422D', 1, CONVERT(datetime, '2021-03-29 12:00:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:00:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-29 12:01:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:01:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-29 12:02:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:02:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-29 12:03:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:03:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-29 12:04:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:04:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-29 12:05:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:05:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-29 12:06:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:06:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-29 12:07:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:07:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-29 12:08:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:08:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-29 12:09:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:09:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-29 12:10:00'), 'this place is great', CONVERT(datetime, '2021-03-29 12:10:01'), 5),

    -- day 8
    ('S9810422D', 1, CONVERT(datetime, '2021-03-30 12:00:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:00:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-30 12:01:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:01:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-30 12:02:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:02:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-30 12:03:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:03:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-30 12:04:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:04:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-30 12:05:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:05:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-30 12:06:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:06:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-30 12:07:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:07:01'), 5),
    ('S9810422D', 3, CONVERT(datetime, '2021-03-30 12:08:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:08:01'), 5),
    ('S9810422D', 1, CONVERT(datetime, '2021-03-30 12:09:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:09:01'), 5),
    ('S9810422D', 2, CONVERT(datetime, '2021-03-30 12:10:00'), 'this place is great', CONVERT(datetime, '2021-03-30 12:10:01'), 5)
;

COMMIT;


BEGIN TRANSACTION;
-- QUERY 5 Adding distinct users to checkinout in last 10 days
INSERT INTO CheckInOut
    (person_id, location_id, checkin_time, checkin_review, checkout_time, checkout_rating)
VALUES
    ('S9823465D', 6, CONVERT(datetime, '2021-03-23 12:00:00'), 'this place is great', CONVERT(datetime, '2021-03-23 12:00:01'), 5)
;
COMMIT;


-- YET TO POPULATE:

-- SWABTEST
-- SYSTEMADMIN
-- TEMPERATUREREC
-- COORDINATEREC
BEGIN TRANSACTION;

INSERT INTO SwabTest
    (person_id, location_id, [timestamp], test_result)
VALUES
    ('S9804253I', 2, CONVERT(datetime, '2021-01-02 12:00:00'), 'Negative'),
    ('S1234567A', 2, CONVERT(datetime, '2021-01-03 12:00:00'), 'Negative'),
    ('S9810422D', 2, CONVERT(datetime, '2021-01-04 12:00:00'), 'Negative'),
    ('S9823465D', 2, CONVERT(datetime, '2021-01-05 12:00:00'), 'Negative'),
    ('T0032522A', 2, CONVERT(datetime, '2021-01-06 12:00:00'), 'Negative'),
    ('S1234567A', 2, CONVERT(datetime, '2021-01-30 12:00:00'), 'Positive')
;

INSERT INTO SystemAdmin
    (person_id)
VALUES
    ('S9823465D'),
    ('T0032522A')
;
INSERT INTO TemperatureRec
    (person_id, [timestamp], temperature)
VALUES
    ('S1234567A', CONVERT(datetime, '2021-03-27 08:00:00'), 36.5),
    ('S1234567A', CONVERT(datetime, '2021-03-27 20:00:00'), 36.9),
    ('S1234567A', CONVERT(datetime, '2021-03-28 08:00:00'), 36.7),
    ('S1234567A', CONVERT(datetime, '2021-03-28 20:00:00'), 37.2),
    ('S1234567A', CONVERT(datetime, '2021-03-29 08:00:00'), 35.9),
    ('S1234567A', CONVERT(datetime, '2021-03-29 20:00:00'), 36.2),
    ('S1234567A', CONVERT(datetime, '2021-03-30 08:00:00'), 36.5)


COMMIT;

BEGIN TRANSACTION;
-- For custom query 1
INSERT INTO CoordinateRec
    (person_id, [timestamp], x_coordinates, y_coordinates)
VALUES

    -- Infection date is 30 Jan 2021.

    -- 1st Jan 2021 (not infectious)
    ('S1234567A', CONVERT(datetime, '2021-01-01 16:00:00'), 13, 10),
    ('S9804253I', CONVERT(datetime, '2021-01-01 16:00:00'), 13, 11),


    -- 16th Jan 2021
    ('S1234567A', CONVERT(datetime, '2021-01-16 13:00:00'), 10, 10),
    ('S1234567A', CONVERT(datetime, '2021-01-16 13:05:00'), 11, 11),
    ('S1234567A', CONVERT(datetime, '2021-01-16 13:10:00'), 12, 12),
    ('S1234567A', CONVERT(datetime, '2021-01-16 13:15:00'), 13, 13),
    ('S1234567A', CONVERT(datetime, '2021-01-16 13:20:00'), 14, 14),

    ('S9823465D', CONVERT(datetime, '2021-01-16 13:10:00'), 12, 12),
    ('S9823465D', CONVERT(datetime, '2021-01-16 13:15:00'), 7, 7),

    -- 29th Jan 2021
    ('S1234567A', CONVERT(datetime, '2021-01-29 09:15:00'), 100, 100),
    ('S1234567A', CONVERT(datetime, '2021-01-29 09:20:00'), 105, 105),
    ('S1234567A', CONVERT(datetime, '2021-01-29 09:25:00'), 112, 112),
    ('S1234567A', CONVERT(datetime, '2021-01-29 09:30:00'), 123, 123),
    ('S1234567A', CONVERT(datetime, '2021-01-29 09:35:00'), 149, 149),

    ('T0032522A', CONVERT(datetime, '2021-01-29 09:15:00'), 100, 101),
    ('S9804253I', CONVERT(datetime, '2021-01-29 09:15:00'), 99, 100),
    ('S9804253I', CONVERT(datetime, '2021-01-29 09:35:00'), 150, 150),

    ('S9810422D', CONVERT(datetime, '2021-01-29 09:30:00'), 123, 122)


;
COMMIT;

BEGIN TRANSACTION;
-- For custom query 2

-- Infection date is 30 Jan 2021.

INSERT INTO CheckInOut
    (person_id, location_id, checkin_time, checkin_review, checkout_time, checkout_rating)
VALUES
    ('S1234567A', 1, CONVERT(datetime, '2021-01-25 12:00:00'), 'this place is great', CONVERT(datetime, '2021-01-25 17:00:00'), 5),
    ('S1234567A', 3, CONVERT(datetime, '2021-01-27 12:00:00'), 'this place is great', CONVERT(datetime, '2021-01-27 17:00:00'), 5),
    ('S1234567A', 5, CONVERT(datetime, '2021-01-29 12:00:00'), 'this place is great', CONVERT(datetime, '2021-01-29 17:00:00'), 5),

    ('T0032522A', 1, CONVERT(datetime, '2021-01-25 13:00:00'), 'this place is great', CONVERT(datetime, '2021-01-25 14:30:00'), 5),
    ('S9804253I', 1, CONVERT(datetime, '2021-01-25 10:00:00'), 'this place is great', CONVERT(datetime, '2021-01-25 15:00:01'), 5),
    ('S9823465D', 3, CONVERT(datetime, '2021-01-27 12:00:00'), 'this place is great', CONVERT(datetime, '2021-01-27 16:00:00'), 5)

;
COMMIT;

