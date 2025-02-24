# Data Engineer Assignment Documentation

## Handling Incremental Loads
- We used the `ingestion_timestamp` column to identify new or updated records.
- Incremental loads are handled by comparing the `ingestion_timestamp` with the latest timestamp in the target tables.

## Data Quality Handling
- **Missing Values**: Default values like 'Unknown' are used for missing `first_name` or `last_name`. Records with missing `email` are skipped.
- **Duplicate Values**: `DISTINCT` and `NOT IN` are used to avoid inserting duplicate records.

## Assumptions
- `email` is used as a unique identifier for users.
- `transaction_id` is the primary key for transactions.
- `product_id` is the primary key for products.