-- Create Database
CREATE DATABASE IF NOT EXISTS silver_layer;
USE silver_layer;

-- Create Dimension Tables
CREATE TABLE IF NOT EXISTS dim_users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255),
    UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS dim_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS dim_transaction_types (
    transaction_type VARCHAR(50) PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Fact Tables
CREATE TABLE IF NOT EXISTS fact_user_transactions (
    transaction_id VARCHAR(50) PRIMARY KEY,
    user_id INT,
    transaction_date TIMESTAMP,
    transaction_amount DECIMAL(10, 2),
    transaction_type VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES dim_users(user_id),
    FOREIGN KEY (transaction_type) REFERENCES dim_transaction_types(transaction_type)
);

CREATE TABLE IF NOT EXISTS fact_product_sales (
    transaction_id VARCHAR(50),
    product_id INT,
    transaction_quantity INT,
    FOREIGN KEY (transaction_id) REFERENCES fact_user_transactions(transaction_id),
    FOREIGN KEY (product_id) REFERENCES dim_products(product_id)
);