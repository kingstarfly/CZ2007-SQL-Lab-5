USE ssr4g2_xx;

BEGIN TRANSACTION;

INSERT INTO Person(nric, sex, birthday, hometown, risk_level, phone_number, name, company_id)
VALUES
  (
    'S9804253I',
    'Male',
    CONVERT(date, '2013-01-29'),
    'singapore',
    'high',
    '82033723',
    'xx',
    NULL
  );

INSERT INTO ContactPerson
VALUES
    (
        1
    );

INSERT INTO Company(company_address, company_email, contact_person_id)
VALUES
(
    'company1address',
    'company1email',
    1
)

UPDATE Person
SET Person.company_id = 1
-- WHERE Person.person_id = 1;

COMMIT