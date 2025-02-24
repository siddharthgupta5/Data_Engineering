USE silver_layer;

-- Test for dim_users
SELECT COUNT(*) AS user_count FROM dim_users;

-- Test for dim_products
SELECT COUNT(*) AS product_count FROM dim_products;

-- Test for dim_transaction_types
SELECT COUNT(*) AS transaction_type_count FROM dim_transaction_types;

-- Test for fact_user_transactions
SELECT COUNT(*) AS user_transaction_count FROM fact_user_transactions;

-- Test for fact_product_sales
SELECT COUNT(*) AS product_sale_count FROM fact_product_sales;

-- Test for data integrity
SELECT COUNT(*) AS missing_user_ids
FROM fact_user_transactions
WHERE user_id NOT IN (SELECT user_id FROM dim_users);

SELECT COUNT(*) AS missing_product_ids
FROM fact_product_sales
WHERE product_id NOT IN (SELECT product_id FROM dim_products);

SELECT COUNT(*) AS missing_transaction_types
FROM fact_user_transactions
WHERE transaction_type NOT IN (SELECT transaction_type FROM dim_transaction_types);