-- Customers

INSERT INTO Customer VALUES

(1, 'Amanda', 'Bryant', 'amanda.b@email.com'),

(2, 'Daniel', 'Cole', NULL),

(3, 'Priya', 'Sharma', 'priya.s@email.com'),

(4, 'Luis', 'Martinez', 'luis@email.com');

-- Accounts

INSERT INTO Account VALUES

(101, 1, 'Checking', 1500.00),

(102, 2, 'Savings', 8000.00),

(103, 3, 'Checking', 2200.00),

(104, 4, 'Savings', 5600.00),

(105, 1, 'Savings', 3200.00);

-- Transactions

INSERT INTO Transaction VALUES

(1001, 101, '2023-07-01', 'Deposit', 500.00),

(1002, 102, '2023-07-02', 'Withdrawal', 1000.00),

(1003, 103, '2023-07-03', 'Deposit', 1200.00),

(1004, 104, '2023-07-05', 'Withdrawal', 600.00),

(1005, 105, '2023-07-06', 'Deposit', 800.00),

(1006, 101, '2023-07-07', 'Withdrawal', 200.00);
