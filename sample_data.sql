-- Customers

INSERT INTO Customer VALUES

(1, 'Lena', 'Morris', 'lena.morris@email.com'),

(2, 'Travis', 'Scott', NULL),

(3, 'Janelle', 'Parker', 'jparker@email.com'),

(4, 'Marcus', 'Jones', 'mjones@email.com');

-- Carriers

INSERT INTO Carrier VALUES

(101, 'QuickShip Logistics', 'East'),

(102, 'NationFreight Co.', 'West'),

(103, 'OnTime Express', 'Central');

-- Shipments

INSERT INTO Shipment VALUES

(1001, 1, 101, '2023-07-01', 'Delivered', 2, 40.00),

(1002, 2, 102, '2023-07-03', 'Delivered', 5, 65.00),

(1003, 3, 101, '2023-07-04', 'Pending', NULL, 35.00),

(1004, 4, 103, '2023-07-05', 'Delivered', 3, 55.00),

(1005, 2, 102, '2023-07-06', 'Delivered', 4, 60.00),

(1006, 1, 103, '2023-07-07', 'Delivered', 2, 42.00);
