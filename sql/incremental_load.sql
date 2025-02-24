USE silver_layer;

-- Incremental load for dim_users
INSERT INTO dim_users (first_name, last_name, email)
SELECT DISTINCT first_name, last_name, email
FROM bronze_layer.source_a
WHERE ingestion_timestamp > (SELECT MAX(ingestion_timestamp) FROM dim_users);

-- Incremental load for dim_products
INSERT INTO dim_products (product_id, product_name)
SELECT DISTINCT product_id, product_name
FROM bronze_layer.source_b
WHERE ingestion_timestamp > (SELECT MAX(ingestion_timestamp) FROM dim_products);

-- Incremental load for dim_transaction_types
INSERT INTO dim_transaction_types (transaction_type)
SELECT DISTINCT transaction_type
FROM bronze_layer.source_a
WHERE ingestion_timestamp > (SELECT MAX(created_at) FROM dim_transaction_types);

-- Incremental load for fact_user_transactions
INSERT INTO fact_user_transactions (transaction_id, user_id, transaction_date, transaction_amount, transaction_type)
SELECT a.transaction_id, u.user_id, a.transaction_date, a.transaction_amount, a.transaction_type
FROM bronze_layer.source_a a
JOIN dim_users u ON a.email = u.email
WHERE a.ingestion_timestamp > (SELECT MAX(transaction_date) FROM fact_user_transactions);

-- Incremental load for fact_product_sales
INSERT INTO fact_product_sales (transaction_id, product_id, transaction_quantity)
SELECT b.transaction_id, b.product_id, b.transaction_quantity
FROM bronze_layer.source_b b
WHERE b.ingestion_timestamp > (SELECT MAX(transaction_date) FROM fact_product_sales);