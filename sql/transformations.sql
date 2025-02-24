USE silver_layer;

-- Insert into dim_users
INSERT INTO dim_users (first_name, last_name, email)
SELECT DISTINCT first_name, last_name, email
FROM bronze_layer.source_a
WHERE email NOT IN (SELECT email FROM dim_users);

-- Insert into dim_products
INSERT INTO dim_products (product_id, product_name)
SELECT DISTINCT product_id, product_name
FROM bronze_layer.source_b
WHERE product_id NOT IN (SELECT product_id FROM dim_products);

-- Insert into dim_transaction_types
INSERT INTO dim_transaction_types (transaction_type)
SELECT DISTINCT transaction_type
FROM bronze_layer.source_a
WHERE transaction_type NOT IN (SELECT transaction_type FROM dim_transaction_types);

-- Insert into fact_user_transactions
INSERT INTO fact_user_transactions (transaction_id, user_id, transaction_date, transaction_amount, transaction_type)
SELECT a.transaction_id, u.user_id, a.transaction_date, a.transaction_amount, a.transaction_type
FROM bronze_layer.source_a a
JOIN dim_users u ON a.email = u.email
WHERE a.transaction_id NOT IN (SELECT transaction_id FROM fact_user_transactions);

-- Insert into fact_product_sales
INSERT INTO fact_product_sales (transaction_id, product_id, transaction_quantity)
SELECT b.transaction_id, b.product_id, b.transaction_quantity
FROM bronze_layer.source_b b
WHERE b.transaction_id NOT IN (SELECT transaction_id FROM fact_product_sales);