-- Create database
CREATE DATABASE ecommerce_project;
USE ecommerce_project;

-- Create table
CREATE TABLE user_events (
    event_id INT PRIMARY KEY,
    user_id INT,
    event_type VARCHAR(50),
    event_date TIMESTAMP,
    product_id INT,
    amount DECIMAL(10,2),
    traffic_source VARCHAR(50)
);