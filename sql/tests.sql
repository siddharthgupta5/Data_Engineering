USE silver_layer;

-- Test 1: Check the number of users in dim_users
SELECT 
    (SELECT COUNT(*) FROM dim_users) AS actual_user_count,
    4 AS expected_user_count; -- Expected number of users based on source_a.csv

-- Test 2: Check the number of products in dim_products
SELECT 
    (SELECT COUNT(*) FROM dim_products) AS actual_product_count,
    3 AS expected_product_count; -- Expected number of products based on source_b.csv

-- Test 3: Check the number of transaction types in dim_transaction_types
SELECT 
    (SELECT COUNT(*) FROM dim_transaction_types) AS actual_transaction_type_count,
    2 AS expected_transaction_type_count; -- Expected transaction types: 'sale' and 'returned'

-- Test 4: Check the number of transactions in fact_user_transactions
SELECT 
    (SELECT COUNT(*) FROM fact_user_transactions) AS actual_transaction_count,
    4 AS expected_transaction_count; -- Expected number of transactions based on source_a.csv

-- Test 5: Check the number of product sales in fact_product_sales
SELECT 
    (SELECT COUNT(*) FROM fact_product_sales) AS actual_product_sale_count,
    4 AS expected_product_sale_count; -- Expected number of product sales based on source_b.csv

-- Test 6: Check for missing user IDs in fact_user_transactions
SELECT 
    (SELECT COUNT(*) 
     FROM fact_user_transactions 
     WHERE user_id NOT IN (SELECT user_id FROM dim_users)) AS missing_user_ids,
    0 AS expected_missing_user_ids; -- Expected: No missing user IDs

-- Test 7: Check for missing product IDs in fact_product_sales
SELECT 
    (SELECT COUNT(*) 
     FROM fact_product_sales 
     WHERE product_id NOT IN (SELECT product_id FROM dim_products)) AS missing_product_ids,
    0 AS expected_missing_product_ids; -- Expected: No missing product IDs

-- Test 8: Check for missing transaction types in fact_user_transactions
SELECT 
    (SELECT COUNT(*) 
     FROM fact_user_transactions 
     WHERE transaction_type NOT IN (SELECT transaction_type FROM dim_transaction_types)) AS missing_transaction_types,
    0 AS expected_missing_transaction_types; -- Expected: No missing transaction types

-- Test 9: Verify specific user data in dim_users
SELECT 
    (SELECT COUNT(*) 
     FROM dim_users 
     WHERE email = 'john.doe@example.com') AS actual_john_doe_count,
    1 AS expected_john_doe_count; -- Expected: John Doe should exist once

-- Test 10: Verify specific product data in dim_products
SELECT 
    (SELECT COUNT(*) 
     FROM dim_products 
     WHERE product_name = 'Product_A') AS actual_product_a_count,
    1 AS expected_product_a_count; -- Expected: Product_A should exist once