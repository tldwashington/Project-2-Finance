-- Customer table

CREATE TABLE Customer (

    customer_id INT PRIMARY KEY,

    first_name VARCHAR(50),

    last_name VARCHAR(50),

    email VARCHAR(100)

);

-- Carrier table

CREATE TABLE Carrier (

    carrier_id INT PRIMARY KEY,

    carrier_name VARCHAR(100),

    region VARCHAR(50)

);

-- Shipment table

CREATE TABLE Shipment (

    shipment_id INT PRIMARY KEY,

    customer_id INT,

    carrier_id INT,

    shipment_date DATE,

    delivery_status VARCHAR(20),

    delivery_time_days INT,

    cost DECIMAL(10,2)

);
