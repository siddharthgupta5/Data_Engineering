# Data Engineer Assignment

This project involves transforming raw data from CSV files into a structured format for reporting and analytics. The raw data is stored in bronze layer tables and is transformed into a silver layer schema using SQL.

Database Used: MySQL

## Folder Structure
- `data/`: Contains the raw CSV files.
- `sql/`: Contains SQL scripts for setup, transformations, incremental loads, and tests(revised).
- `docs/`: Contains documentation for the project (revised).

## How to Run
1. Set up the database by running `setup.sql`.
2. Run `transformations.sql` to transform the raw data.
3. Run `incremental_load.sql` for incremental loading.
4. Run `tests.sql` to validate the data.
