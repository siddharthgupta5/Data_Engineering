# Data Engineer Assignment Documentation

## Handling Incremental Loads
- We used the `ingestion_timestamp` column to identify new or updated records.
- Incremental loads are handled by comparing the `ingestion_timestamp` with the latest timestamp in the target tables.

## Data Quality Handling
- **Missing Values**: Default values like 'Unknown' are used for missing `first_name` or `last_name`. Records with missing `email` are skipped.
- **Duplicate Values**: `DISTINCT` and `NOT IN` are used to avoid inserting duplicate records.

## Design Decisions
- **Primary Key in `dim_users`**:
  - The `dim_users` table uses `user_id` (an auto-incremented integer) as the primary key instead of `email`. This decision is based on the following reasons:
    1. **Stability and Immutability**:
       - `user_id` is a surrogate key that never changes, even if a user updates their email. This avoids cascading updates in related tables (e.g., `fact_user_transactions`).
    2. **Uniqueness and Reliability**:
       - While emails are often unique, they are not guaranteed to be (e.g., shared family accounts or typos). `user_id` ensures a consistent and unique identifier.
    3. **Performance**:
       - Integer-based keys (e.g., `user_id`) are faster for indexing and joins compared to string-based keys (e.g., `email`).
    4. **Security and Privacy**:
       - Using `user_id` reduces the risk of exposing sensitive information (e.g., emails) in logs, error messages, or APIs.
    5. **Flexibility**:
       - Surrogate keys like `user_id` decouple the database design from business rules, making it easier to adapt to changes (e.g., allowing multiple emails per user).

- **Primary Keys in Other Tables**:
  - `dim_products` uses `product_id` as the primary key.
  - `dim_transaction_types` uses `transaction_type` as the primary key.
  - `fact_user_transactions` uses `transaction_id` as the primary key.
  - `fact_product_sales` uses a composite key of `transaction_id` and `product_id`.

## Assumptions
- `transaction_id` is the primary key for transactions.
- `product_id` is the primary key for products.
- `email` is used as a unique identifier for users at the application level, but `user_id` is used as the primary key in the database for the reasons outlined above.
