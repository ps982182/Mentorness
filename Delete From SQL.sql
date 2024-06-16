-- Create a database if it does not exist
CREATE DATABASE IF NOT EXISTS MyNewDatabase;
USE MyNewDatabase;

-- Create a table
CREATE TABLE IF NOT EXISTS MyNewTable (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);

-- Insert some sample data
INSERT INTO MyNewTable (name, age) VALUES ('Alice', 30);
INSERT INTO MyNewTable (name, age) VALUES ('Bob', 25);
INSERT INTO MyNewTable (name, age) VALUES ('Charlie', 35);
INSERT INTO MyNewTable (name, age) VALUES ('David', 28);

-- Display all records in the table
SELECT * FROM MyNewTable;

-- Deleting records based on a condition (age greater than 30)
DELETE FROM MyNewTable WHERE id > 0 AND age > 29;

-- Display records after deletion
SELECT * FROM MyNewTable;

-- Drop the table if no longer needed
-- DROP TABLE MyNewTable;