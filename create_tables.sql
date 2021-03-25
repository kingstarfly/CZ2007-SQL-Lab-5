USE ssr4g2;
-- 5
CREATE TABLE Person
(
    person_id CHAR(9) PRIMARY KEY,
    sex VARCHAR(10) NOT NULL,
    birthday DATE NOT NULL,
    hometown VARCHAR(50) NOT NULL,
    risk_level VARCHAR(10) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    name VARCHAR(50) NOT NULL,
    -- company_id VARCHAR(20) REFERENCES Company(company_id) TODOOOOOO!!!
    company_id VARCHAR(20)

);

-- 10. ContactPerson
CREATE TABLE ContactPerson
(
    person_id CHAR(9) FOREIGN KEY REFERENCES Person(person_id) ON DELETE NO ACTION ON UPDATE CASCADE,
    PRIMARY KEY (person_id)
);

-- 8. Company 
CREATE TABLE Company
(
    company_id VARCHAR(20) PRIMARY KEY,
    company_email VARCHAR(30) NOT NULL,
    company_address VARCHAR(50) NOT NULL,
    contact_person_id CHAR(9) REFERENCES ContactPerson(person_id)
    ON
    DELETE
    SET NULL
    ON
    UPDATE CASCADE

);

-- 2
CREATE TABLE Location
(
    location_id VARCHAR(10) PRIMARY KEY,
    x_coordinates FLOAT NOT NULL,
    y_coordinates FLOAT NOT NULL,
    owner VARCHAR(50) NOT NULL,
    description VARCHAR(200),
    address VARCHAR(100) NOT NULL,
    name VARCHAR(50) NOT NULL
);

-- 7
CREATE TABLE Post
(
    -- post_id INT PRIMARY KEY IDENTITY(1,1),
    person_id CHAR(9) FOREIGN KEY REFERENCES Person(person_id) ON DELETE NO ACTION ON UPDATE CASCADE,
    location_id VARCHAR(10) FOREIGN KEY REFERENCES Location(location_id) ON DELETE NO ACTION ON UPDATE CASCADE,
    timestamp DATETIME,
    content VARCHAR(100) NOT NULL,
    PRIMARY KEY(person_id, location_id, timestamp)
);

-- 1
CREATE TABLE SwabTest
(
    person_id CHAR(9) FOREIGN KEY REFERENCES Person(person_id) ON DELETE NO ACTION ON UPDATE CASCADE,
    location_id VARCHAR(10) FOREIGN KEY REFERENCES Location(location_id) ON DELETE NO ACTION ON UPDATE CASCADE,
    timestamp DATETIME,
    test_result VARCHAR(10) NOT NULL
        PRIMARY KEY(person_id, location_id, timestamp)
);


-- 3
CREATE TABLE Comment
(
    person_id CHAR(9) FOREIGN KEY REFERENCES Person(person_id) ON DELETE NO ACTION ON UPDATE CASCADE,
    poster_person_id CHAR(9),
    location_id VARCHAR(10),
    post_timestamp DATETIME,
    comment VARCHAR(300) NOT NULL,
    comment_timestamp DATETIME NOT NULL,
    FOREIGN KEY (poster_person_id, location_id, post_timestamp) REFERENCES Post(person_id, location_id, timestamp) ON DELETE NO ACTION ON UPDATE CASCADE,
    PRIMARY KEY (person_id, poster_person_id, location_id, post_timestamp)
);

-- 4
CREATE TABLE Category
(
    label VARCHAR(50) PRIMARY KEY
);


-- 6
CREATE TABLE SystemAdmin
(
    person_id CHAR(9) FOREIGN KEY REFERENCES Person(person_id) ON DELETE NO ACTION ON UPDATE CASCADE,
    PRIMARY KEY (person_id)
)

-- 9. Family
CREATE TABLE Family
(
    person1_id CHAR(9) FOREIGN KEY REFERENCES Person(person_ID) ON DELETE NO ACTION ON UPDATE CASCADE,
    person2_id CHAR(9) FOREIGN KEY REFERENCES Person(person_ID) ON DELETE NO ACTION ON UPDATE CASCADE,
    Relation_type VARCHAR(20) NOT NULL,
    PRIMARY KEY (person1_id, person2_id)
)


-- 11. Coordinate_Rec(person_ID, timestamp, x_coordinates, y_coordinates)
CREATE TABLE CoordinateRec
(
    person_id CHAR(9) NOT NULL,
    timestamp DATETIME NOT NULL,
    x_coordinates FLOAT NOT NULL,
    y_coordinates FLOAT NOT NULL,
    FOREIGN KEY(person_id) REFERENCES Person(person_id) ON DELETE NO ACTION ON UPDATE CASCADE,
    PRIMARY KEY (person_id, timestamp)
)


-- 12. PartOf(super_category_label, sub_category_label)
CREATE TABLE PartOf
(
    super_category_label VARCHAR(50) NOT NULL,
    sub_category_label VARCHAR(50) NOT NULL,
    FOREIGN KEY (super_category_label) REFERENCES Category(label) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (sub_category_label) REFERENCES Category(label) ON DELETE NO ACTION ON UPDATE CASCADE,
    PRIMARY KEY (super_category_label, sub_category_label)
)

-- 13. Temperature_Rec(person_ID, timestamp, temperature)
CREATE TABLE TemperatureRec
(
    person_id CHAR(9) NOT NULL,
    timestamp DATETIME NOT NULL,
    temperature FLOAT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES Person(person_id) ON DELETE NO ACTION ON UPDATE CASCADE,
    PRIMARY KEY (timestamp, person_id)
)

-- 14. Check-In-Out(person_ID, location_ID, checkin_time, checkin_review, checkout_time, checkout_rating)
CREATE TABLE CheckInOut
(
    person_id CHAR(9) NOT NULL,
    location_id VARCHAR(10) NOT NULL,
    checkin_time DATETIME NOT NULL,
    checkout_time DATETIME NOT NULL,
    checkin_review VARCHAR(255) NOT NULL,
    checkout_rating INT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES Person(person_id) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (location_id) REFERENCES Location(location_id) ON DELETE NO ACTION ON UPDATE CASCADE,
    PRIMARY KEY (checkin_time, person_id, location_id)
)

-- 15. AssociatedWith(location_ID, label)
CREATE TABLE AssociatedWith
(
    location_id VARCHAR(10) NOT NULL,
    label VARCHAR(50) NOT NULL,
    FOREIGN KEY (location_id) REFERENCES Location(location_id) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (label) REFERENCES Category(label) ON DELETE NO ACTION ON UPDATE CASCADE,
    PRIMARY KEY (location_id, label)
)
 
GO
-- Add Foreign Key to Person
ALTER TABLE Person
ADD FOREIGN KEY (company_id) REFERENCES Company(company_id) ON DELETE SET NULL ON UPDATE CASCADE;
 

