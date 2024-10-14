-- Drop tables

DROP TABLE ticket_info;
DROP TABLE flight_details;
DROP TABLE credit_card_details;
DROP TABLE flight;
DROP TABLE passenger;

-- Create tables

CREATE TABLE flight (
flight_id NUMBER PRIMARY KEY,
airline_id NUMBER NOT NULL,
airline_name VARCHAR(50) NOT NULL,
from_location VARCHAR(50) NOT NULL,
to_location VARCHAR(50) NOT NULL,
departure_time VARCHAR(50) NOT NULL,
arrival_time VARCHAR(50) NOT NULL,
total_seats NUMBER CHECK (total_seats >= 100 AND total_seats <= 1000)
);

CREATE TABLE passenger (
profile_id NUMBER PRIMARY KEY,
password VARCHAR(50) NOT NULL,
f_name VARCHAR(50) NOT NULL,
l_name VARCHAR(50) NOT NULL,
m_name VARCHAR(20),
address VARCHAR(50),
mobile_no VARCHAR(50) NOT NULL UNIQUE,
email VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE credit_card_details (
profile_id NUMBER NOT NULL,
card_number VARCHAR(50) PRIMARY KEY,
card_type VARCHAR(50) NOT NULL,
expiration_month VARCHAR(50) NOT NULL,
expiration_year NUMBER NOT NULL,
FOREIGN KEY (profile_id) REFERENCES passenger(profile_id)
);

CREATE TABLE flight_details (
flight_id NUMBER NOT NULL,
flight_departure_date DATE,
price NUMBER NOT NULL CHECK (price >= 1000 AND price <= 100000),
PRIMARY KEY (flight_id, flight_departure_date),
FOREIGN KEY (flight_id) REFERENCES flight(flight_id)
);

CREATE TABLE ticket_info (
ticket_id NUMBER PRIMARY KEY,
profile_id NUMBER NOT NULL,
flight_id NUMBER NOT NULL,
flight_d_date DATE NOT NULL,
status VARCHAR(50),
FOREIGN KEY (flight_id) REFERENCES flight(flight_id),
FOREIGN KEY (profile_id) REFERENCES passenger(profile_id),
FOREIGN KEY (flight_id, flight_d_date) REFERENCES flight_details(flight_id, flight_departure_date)
);

-- Add column in the table

ALTER TABLE flight ADD duration VARCHAR(50);

-- Modify column definition in the table

ALTER TABLE flight MODIFY duration VARCHAR(20);

-- Rename the column name

ALTER TABLE flight RENAME COLUMN total_seats TO seats;

-- Drop the column from table

ALTER TABLE passenger DROP COLUMN m_name;
ALTER TABLE flight DROP COLUMN duration;