-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS hotelReservation;

-- Use the created database
USE hotelReservation;

-- Create table if it doesn't exist
CREATE TABLE IF NOT EXISTS hotel_reservations (
  Booking_ID INT,
  no_of_adults INT,
  no_of_children INT,
  no_of_weekend_nights INT,
  no_of_week_nights INT,
  type_of_meal_plan VARCHAR(50),
  room_type_reserved VARCHAR(50),
  lead_time INT,
  arrival_date DATE,
  market_segment_type VARCHAR(50),
  avg_price_per_room DECIMAL(10, 2),
  booking_status VARCHAR(20)
);

-- Check table content (should return 0 rows if table is empty)
SELECT * FROM hotel_reservations LIMIT 0, 2000;

-- Count rows in the table
SELECT COUNT(*) FROM hotel_reservations;

-- (1) What is the total number of reservations in the dataset? 
SELECT COUNT(*) AS total_reservations
FROM hotel_reservations;

-- (2) Which meal plan is the most popular among guests?  
SELECT type_of_meal_plan, COUNT(*) AS count
FROM hotel_reservations
GROUP BY type_of_meal_plan
ORDER BY count DESC
LIMIT 1;

-- (3) What is the average price per room for reservations involving children?  
SELECT AVG(avg_price_per_room) AS average_price
FROM hotel_reservations
WHERE no_of_children > 0;

-- (4) How many reservations were made for the year 2024?  
SELECT COUNT(*) AS reservations_in_year
FROM hotel_reservations
WHERE YEAR(arrival_date) = 2024;

-- (5) What is the most commonly booked room type? 
SELECT room_type_reserved, COUNT(*) AS count
FROM hotel_reservations
GROUP BY room_type_reserved
ORDER BY count DESC
LIMIT 1;

-- (6) How many reservations fall on a weekend (no_of_weekend_nights > 0)? 
SELECT COUNT(*) AS weekend_reservations
FROM hotel_reservations
WHERE no_of_weekend_nights > 0;

-- (7) What is the highest and lowest lead time for reservations?  
SELECT MAX(lead_time) AS max_lead_time, MIN(lead_time) AS min_lead_time
FROM hotel_reservations;

-- (8) What is the most common market segment type for reservations? 
SELECT market_segment_type, COUNT(*) AS count
FROM hotel_reservations
GROUP BY market_segment_type
ORDER BY count DESC
LIMIT 1;

-- (9) How many reservations have a booking status of "Confirmed"? 
SELECT COUNT(*) AS confirmed_reservations
FROM hotel_reservations
WHERE booking_status = 'Confirmed';

-- (10) What is the total number of adults and children across all reservations? 
SELECT SUM(no_of_adults) AS total_adults, SUM(no_of_children) AS total_children
FROM hotel_reservations;

-- (11) What is the average number of weekend nights for reservations involving children?  
SELECT AVG(no_of_weekend_nights) AS average_weekend_nights
FROM hotel_reservations
WHERE no_of_children > 0;

-- (12) How many reservations were made in each month of the year? 
SELECT MONTH(arrival_date) AS month, COUNT(*) AS reservations_count
FROM hotel_reservations
GROUP BY MONTH(arrival_date)
ORDER BY month;

-- (13) What is the average number of nights (both weekend and weekday) spent by guests for each room type?
SELECT room_type_reserved, 
       AVG(no_of_weekend_nights + no_of_week_nights) AS average_nights
FROM hotel_reservations
GROUP BY room_type_reserved;

-- (14) For reservations involving children, what is the most common room type, and what is the average price for that room type?  
SELECT room_type_reserved, COUNT(*) AS count, AVG(avg_price_per_room) AS average_price
FROM hotel_reservations
WHERE no_of_children > 0
GROUP BY room_type_reserved
ORDER BY count DESC
LIMIT 1;

-- (15)  Find the market segment type that generates the highest average price per room.  
SELECT market_segment_type, AVG(avg_price_per_room) AS average_price
FROM hotel_reservations
GROUP BY market_segment_type
ORDER BY average_price DESC
LIMIT 1;
