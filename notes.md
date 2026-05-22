-- Scenario:
-- You’re working with the logistics analytics team at a national shipping company. Your job is to analyze delivery records, identify trends in carrier performance, and ensure accurate customer contact data for future notifications. 
-- You’ll work with three related tables: Shipment, Carrier, and Customer.

-- 1. Calculate the average deliver time per carrier, ordered from slowest to fastest. 

-- First, I look for the table(s) which contain the delivery time, which is the Shipment table, titled delivery_time_days. I know I'll use the AVG function in this query, but for now, I want to know each carrier's average delivery time.
-- The Shipment table also has the carrier_id column. This is a good way to identify the carriers, but a better option is to check for other tables that may have better identifying information for our output. The Carrier table has carrier_id and carrier_name. With a JOIN function in our query, we can "translate" the carrier id numbers into carrier names in our output.
-- Our output should be ordered from slowest to fastest delivery time. our field tells us that delivery time is measured in days: the slower the time, the higher the number (integer). Naturally, less/lower days = faster delivery time. We can use the ORDER BY function so our query knows how to order the average delivery time in our output: by days, not by carrier_name or carrier_id. We will pair ORDER BY with DESC, so that the highest number of days are at the top.

-- Let's make a first attempt of a query:

-- SELECT FROM Shipment s
-- carrier_id,
-- AVG delivery_time_days AS avg_delivery_time_days
-- JOIN Carrier ca ON s.carrier_id = ca.carrier_id
-- ORDER BY carrier_name DESC

-- Something isn't in the right order in the first line. Let's try:

-- SELECT carrier_id FROM Shipment s
--    AVG delivery_time_days AS avg_delivery
-- JOIN Carrier ca ON s.carrier_id = ca.carrier_id
-- ORDER BY carrier_name DESC

-- I hit the some snags: I remembered that any sort of math functions need parentheses, for one. But the same error message comes up:
-- "'AVG (delivery_time_days) AS avg_delivery JOIN Carrier ca ON s.carrier_id = c'"
-- Ultimately I realized the order is off - I'm trying to average delivery times, rename a column in the output, and join two tables AFTER telling SQL to select from Shipment. Let's have the query do the math first in Shipment, THEN query the join. The structure is off and I need to build this up. Let's pare down to pulling the two columns we're working with in Shipment:


-- SELECT carrier_id, delivery_time_days
-- FROM Shipment s

-- OK, that output looks good so far. Now, we want to do the math first - let's calculate the average delivery time for each carrier.

-- SELECT carrier_id, delivery_time_days
-- FROM Shipment s
-- AVG(s.delivery_time_days) AS avg_delivery

-- none of that worked. I need to do something before I average times across carriers. Group them first?

-- SELECT carrier_id, delivery_time_days
-- GROUP BY carrier_id
-- AVG(delivery_time_days) AS avg_delivery
-- FROM Shipment s

-- no, that's wrong. I want to select carrier IDs and delivery times from Shipment, and group them in the output by carrier.

-- SELECT 
--	carrier_id, 
--	AVG(delivery_time_days) AS avg_delivery
-- FROM Shipment
-- GROUP BY carrier_id

-- OK I missed a LOT - and the format makes a difference in seeing the error. I want to select carrier id AND average the delivery time, and "listing" them under SELECT, and that pesky comma I missed, made the difference. I don't need an alias for Shipment,  but I do want to group by carrier id before I join tables.
-- (insert screenshot)

-- OK, let's join tables. The common key is carrier_id and we want to join the Carrier table to translate the carrier_id to carrier_name.

-- SELECT 
--	carrier_id, 
--	AVG(delivery_time_days) AS avg_delivery
-- FROM Shipment
-- GROUP BY carrier_id
-- JOIN Carrier ON carrier_id = carrier_id

-- ORDER BY carrier_name DESC

-- We're looking for the average delivery time per carrier, but we need to specify that we want to see the averages for each (unique) carrier by a group. So a couple more tweaks to the order. We select, then join, then group, then calculate (avg), then order (by time)

-- Let's try:

-- SELECT 
--	carrier_id, 
--	AVG(delivery_time_days) AS avg_delivery
-- FROM Shipment s
-- JOIN Carrier ca 
--	ON s.carrier_id = ca.carrier_id
-- GROUP BY ca.carrier_name

-- Query Error: Column 'carrier_id' in field list is ambiguous
-- Ok, which "carrier_id" is ambiguous? I've already clarified in the join, but before the join, SQL doesn't know which table to select "carrier_id" from. When run, the query is starting with FROM, then JOIN, then SELECT. So even though I named the alias in the FROM line, I have to be consistent throughout.

-- SELECT 
--	s.carrier_id, 
--	AVG(delivery_time_days) AS avg_delivery
-- FROM Shipment s
-- JOIN Carrier ca 
--	ON s.carrier_id = ca.carrier_id
-- GROUP BY s.carrier_id
-- ORDER BY avg_delivery DESC

-- (insert screenshot P1Q1.5) So I got an output! This query gives me my average delivery in descending order, and I feel back on track. Full circle, when I started this question, I made a better decision to identify the carriers by carrier_name. I see in the last query, I used GROUP BY ca.carrier_name but then switched. Finally, since I ended up using aliases afterall, let's acount for that in our AVG function.

-- When I made those two changes, I got a different error: (insert sreenshot P1Q1.6)
-- My SELECT needs to match my GROUP BY. I know I want the output to display average times by carrier name, and in debugging, I didn't think to update s.carrier_id to ca.carrier_name. Now that I understand that SQL processes in a different order than the way the query is written, the query makes much more sense.


SELECT 
	ca.carrier_name, 
	AVG(s.delivery_time_days) AS avg_delivery
FROM Shipment s
JOIN Carrier ca 
	ON s.carrier_id = ca.carrier_id
GROUP BY ca.carrier_name
ORDER BY avg_delivery DESC

-- Key Takeaways: 

-- This took way too long! I understood what needed to happen, but the order and punctuation, AND being less ambiguous with aliases. Commas matter, and YES to aliases - make sure I'm using the right aliases in the right places.

-- NULL Values and AVG()

-- Aggregate functions like `AVG()` automatically ignore `NULL` values in MySQL rather than treating them as `0`. I knew that, and is what prompted me to backtrack to that NULL value.

-- Shipment 1003 has a missing `delivery_time_days` value did not negatively impact the carrier's average delivery time calculation. SQL treats the `NULL` value as "unknown" and excluded it from the calculation entirely. In real-world, a NULL is maybe bad recordkeeping and data entry, but a zero value might raise an eyebrow - did that delivery actually happen? How can a delivery take no days? Did someone pick the package up in person? Looking at the date and status columns, we can make an educated assumption that (in the US) 7/4/23 is a holiday with no delivery service, and the "Pending" status further supports that assumption. Eyebrow lowered, all good.

-- 2. Distinct Delivery Statuses
-- Goal: Generate a list of distinct delivery statuses used across all shipments.

-- Analysis:
-- I know I am pulling sh.delivery_status, and need a DISTINCT query, but I don't remember where to start. I'll start with my gut:
  DISTINCT sh.delivery_status
  
-- That wasn't correct - too simple of a query. But maybe I need to SELECT the sh.delivery_status first, then query to pull only DISTINCT delivery statuses. Let's try:
  SELECT DISTINCT sh.delivery_status

-- I got this error message:
-- "unknown table 'sh' in field list", which means I need to create the alias first for SQL to recognize what table I'm referencing (Shipment). Let's try this:
  SELECT FROM Shipment sh

-- I got this error message:
-- "check the manual that corresponds to your MySQL server version for the right syntax to use near 'FROM Shipment sh -- Create a list of customers showing their full names and lab' at line 25." (in this document, line 19)

-- I can tell from the schema that my output should return a short list of two distinct delivery_status (Delivered and Pending). I know I need to:
-- 1. create an alias for table Shipment sh
-- 2. use SELECT and DISTINCT functions
-- 3. pull values from Shipment

-- Let's try:

SELECT DISTINCT FROM Shipment sh
  sh.delivery_status AS distinct_status
    
-- I got this error message: 
-- "check the manual that corresponds to your MySQL server version for the right syntax to use near 'FROM Shipment sh sh.delivery_status AS distinct_status -- Create a list of cus' at line 35" (in this document, line 31). 
-- I'm a bit stumped but I feel like all the pieces are there, and not in the right order or format. When the error says "-- Create a list of cus" it's reading non-query text from the schema code, at least in a way that prevents MY query from running. I've gotten too far off base - I don't need to rename that column!

-- Let me step back and build up: I know how to pull a list of all delivery status records (not types). I'd run:
  SELECT * FROM Shipment
-- (insert screenshot here)

-- Great, that gave me what I expected: the full Shipment table with all columns and values. I'm confident in running a query to output just the delivery_status column:
  SELECT delivery_status FROM Shipment
-- (insert screenshot here)

-- Yes, on the right track. I have one column, delivery_status, that returns ALL records. NOW I need to use the DISTINCT function to give me an output of just two rows to read "Delivered" and "Pending." But order and syntax matters. Let's try:
  SELECT DISTINCT delivery_status FROM Shipment
-- (insert screenshot here)

-- Result: I knew the output should've resulted in two statuses under delivery_status: Delivered and Pending. The DISTINCT function tells SQL to pull unique values - we did not need every record of every delivery status.
-- Key takeaways:
-- 1. I needed to break down and build up to the query being asked. I had all the right elements and correctly identified which table, column, and values were needed to query and execute.
-- 2. I wasted time and confused myself on creating an alias for the Shipment table, and didn't need to, especially since this is such a small data set. My first couple attempts took me away from the query.
-- 3. I knew DISTINCT function would be used, and placement matters. I got sidetracked, attempting to use our SELECT FROM WHERE query foundation, and using DISTINCT later.


3. Create a list of customers showing their full names and label missing emails as 'email needed'.

4. Generate a list of distinct delivery statues used across all shipments.  

5. List all shipments with customer and carrier names, including shipments for customers who don't have an email address on file. 
