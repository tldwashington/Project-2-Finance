-- Customer table

CREATE TABLE Customer (

    customer_id INT PRIMARY KEY,

    first_name VARCHAR(50),

    last_name VARCHAR(50),

    email VARCHAR(100)

);

-- Account table

CREATE TABLE Account (

    account_id INT PRIMARY KEY,

    customer_id INT,

    account_type VARCHAR(20),

    balance DECIMAL(10,2)

);

-- Transaction table

CREATE TABLE Transaction (

    transaction_id INT PRIMARY KEY,

    account_id INT,

    transaction_date DATE,

    transaction_type VARCHAR(20),

    amount DECIMAL(10,2)

);
