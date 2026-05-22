-- Question 1:
-- Calculate the average deliver time per carrier, ordered from slowest to fastest. 

SELECT 
	ca.carrier_name, 
	AVG(s.delivery_time_days) AS avg_delivery
FROM Shipment s
JOIN Carrier ca 
	ON s.carrier_id = ca.carrier_id
GROUP BY ca.carrier_name
ORDER BY avg_delivery DESC


-- Question 2: 
-- Generate a list of distinct delivery statuses used across all shipments.

SELECT DISTINCT delivery_status FROM Shipment

-- Question 3:
-- Create a list of customers showing their full names and label missing emails as 'email needed'.


-- Question 4:
-- List all shipments with customer and carrier names, including shipments for customers who don't have an email address on file. 
