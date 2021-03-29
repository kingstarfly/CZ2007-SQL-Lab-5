USE ssr4g2_xx;
-- 5
CREATE TABLE Person
(
    person_id CHAR(9),
    sex VARCHAR(10) NOT NULL,
    birthday DATE NOT NULL,
    hometown VARCHAR(50) NOT NULL,
    risk_level VARCHAR(10) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    name VARCHAR(50) NOT NULL,
    company_id INT,

    PRIMARY KEY (person_id)
);

-- 10. ContactPerson
CREATE TABLE ContactPerson
(
    person_id CHAR(9) NOT NULL,

    PRIMARY KEY (person_id),
    FOREIGN KEY (person_id) REFERENCES Person(person_id) ON DELETE CASCADE ON UPDATE CASCADE
)

-- 8. Company 
CREATE TABLE Company
(
    company_id INT IDENTITY(1,1),
    company_name VARCHAR(50) NOT NULL,
    company_email VARCHAR(30) NOT NULL,
    company_address VARCHAR(50) NOT NULL,
    contact_person_id CHAR(9) NOT NULL,

    PRIMARY KEY (company_id),
    FOREIGN KEY (contact_person_id) REFERENCES ContactPerson(person_id)
);

-- 2
CREATE TABLE Location
(
    location_id INT IDENTITY(1,1),
    x_coordinates FLOAT NOT NULL,
    y_coordinates FLOAT NOT NULL,
    owner VARCHAR(50) NOT NULL,
    description VARCHAR(200),
    address VARCHAR(100) NOT NULL,
    name VARCHAR(50) NOT NULL,

    PRIMARY KEY (location_id)
);

-- 7
CREATE TABLE Post
(
    post_id INT IDENTITY(1,1),
    person_id CHAR(9),
    location_id INT,
    timestamp DATETIME,
    content VARCHAR(100) NOT NULL,

    PRIMARY KEY(post_id),
    FOREIGN KEY (person_id) REFERENCES ContactPerson(person_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (location_id) REFERENCES Location(location_id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- 1
CREATE TABLE SwabTest
(
    swab_test_id INT IDENTITY(1,1),
    person_id CHAR(9),
    location_id INT,
    timestamp DATETIME,
    test_result VARCHAR(10) NOT NULL,

    PRIMARY KEY(swab_test_id),
    FOREIGN KEY (person_id) REFERENCES Person(person_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (location_id) REFERENCES Location(location_id) ON DELETE SET NULL ON UPDATE CASCADE
);


-- 3
CREATE TABLE Comment
(
    comment_id INT IDENTITY(1,1),
    commentor_id CHAR(9),
    post_id INT,
    comment VARCHAR(300) NOT NULL,
    comment_timestamp DATETIME NOT NULL,

    PRIMARY KEY (comment_id),
    FOREIGN KEY (commentor_id) REFERENCES Person(person_id) ON DELETE SET NULL,
    FOREIGN KEY (post_id) REFERENCES Post(post_id) ON DELETE SET NULL
);

-- 4
CREATE TABLE Category
(
    label VARCHAR(50),

    PRIMARY KEY (label)
);


-- 6
CREATE TABLE SystemAdmin
(
    person_id CHAR(9),
    PRIMARY KEY (person_id),
    FOREIGN KEY (person_id) REFERENCES Person(person_id) ON DELETE CASCADE ON UPDATE CASCADE
)

-- 9. Family
CREATE TABLE Family
(
    person1_id CHAR(9),
    person2_id CHAR(9),
    relation_type VARCHAR(20) NOT NULL,

    PRIMARY KEY (person1_id, person2_id),
    FOREIGN KEY (person1_id) REFERENCES Person(person_ID),
    FOREIGN KEY (person2_id) REFERENCES Person(person_ID)
)


-- 11. Coordinate_Rec(person_ID, timestamp, x_coordinates, y_coordinates)
CREATE TABLE CoordinateRec
(
    rec_id INT IDENTITY(1,1),
    person_id CHAR(9),
    timestamp DATETIME NOT NULL,
    x_coordinates FLOAT NOT NULL,
    y_coordinates FLOAT NOT NULL,

    PRIMARY KEY (rec_id),
    FOREIGN KEY(person_id) REFERENCES Person(person_id) ON DELETE SET NULL ON UPDATE CASCADE,
)


-- 12. PartOf(super_category_label, sub_category_label)
CREATE TABLE PartOf
(
    super_category_label VARCHAR(50) NOT NULL,
    sub_category_label VARCHAR(50) NOT NULL,

    PRIMARY KEY (super_category_label, sub_category_label),
    FOREIGN KEY (super_category_label) REFERENCES Category(label),
    FOREIGN KEY (sub_category_label) REFERENCES Category(label)
)

-- 13. Temperature_Rec(person_ID, timestamp, temperature)
CREATE TABLE TemperatureRec
(
    rec_id INT IDENTITY(1,1),
    person_id CHAR(9),
    timestamp DATETIME NOT NULL,
    temperature FLOAT NOT NULL,

    PRIMARY KEY (rec_id),
    FOREIGN KEY (person_id) REFERENCES Person(person_id) ON DELETE SET NULL ON UPDATE CASCADE
)

-- 14. Check-In-Out(person_ID, location_ID, checkin_time, checkin_review, checkout_time, checkout_rating)
CREATE TABLE CheckInOut
(
    rec_id INT IDENTITY(1,1),
    person_id CHAR(9),
    location_id INT,
    checkin_time DATETIME NOT NULL,
    checkout_time DATETIME NOT NULL,
    checkin_review VARCHAR(255) NOT NULL,
    checkout_rating INT NOT NULL,

    PRIMARY KEY (rec_id),
    FOREIGN KEY (person_id) REFERENCES Person(person_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (location_id) REFERENCES Location(location_id) ON DELETE SET NULL ON UPDATE CASCADE
)

-- 15. AssociatedWith(location_ID, label)
CREATE TABLE AssociatedWith
(
    location_id INT NOT NULL,
    label VARCHAR(50) NOT NULL,

    PRIMARY KEY (location_id, label),
    FOREIGN KEY (location_id) REFERENCES Location(location_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (label) REFERENCES Category(label) ON DELETE CASCADE ON UPDATE CASCADE
)

GO
-- Add Foreign Key to Person
ALTER TABLE Person
ADD FOREIGN KEY (company_id) REFERENCES Company(company_id) ON DELETE SET NULL ON UPDATE CASCADE;
 

