# 🏗️ Transactional Data Warehouse Project

A hands-on SQL-based data warehousing project designed to extract, transform, and load (ETL) transactional data from CSV files into a normalized and query-ready PostgreSQL database. This project demonstrates my understanding of data modeling, SQL transformations, and data architecture best practices.

## 📌 Project Overview

The goal of this project is to simulate a business environment where raw transactional data is transformed into a structured, efficient format that supports analytics and reporting. Key features include:

- Data ingestion from CSVs
- Creation of normalized 3NF schema
- Implementation of ETL logic using SQL scripts
- Surrogate key generation and SCD2 handling
- Logging and error handling mechanisms

## 🗂️ Project Structure

transactional-data-warehouse/
│
├── create_tables.sql # create tables for the data warehouse for all layers
│
├── log_setup.sql # exceute logging procedures
│
├── load_data.sql # procedures to load data into tables
│
├── Source_files_csv/ # Original CSV files
│
├── diagrams/
│ └── Snowflake_Schema.png # ER diagram of the 3NF model
│ └── Star_Schema.png # ER diagram of the dimensional model
│
└── README.md # This file

🛠️ Technologies Used
SQL (PostgreSQL dialect)

PostgreSQL (as the database engine)

DBeaver (for SQL development and visualization)

CSV files as the source data format

📊 Key Concepts Demonstrated
ETL Process: Manual implementation of Extract, Transform, and Load workflows

3NF Modeling: Designing normalized schemas to eliminate redundancy

Surrogate Keys & Natural Keys: Handling uniqueness and referential integrity

SCD Type 2: Slowly changing dimension handling with START_DT, END_DT, IS_ACTIVE

Logging: Centralized logging table with timestamps and error messages

## 🚀 Getting Started

To set up the project in a PostgreSQL environment:

1. **Create Tables**  
   Run `create_tables.sql` to generate the schema.

2. **Set Up Logging**  
   Run `log_setup.sql` to create the `log_etl_events` table and its associated stored procedures.

3. **Insert Data**  
   Run `insert_data.sql` to load data into the tables. Logging is automatically performed at each step.

You can run each SQL script in order using a tool like DBeaver or psql.

git clone https://github.com/yourusername/transactional-data-warehouse.git

✅ Example Use Cases

Business analytics on customer orders

Tracking historical changes in customer or product data

Building a foundation for data marts or BI dashboards

📈 Future Improvements

Automate ETL with Python or Bash

Add unit tests for SQL procedures

🧑‍💻 Author

Krisztina Furdui
Aspiring Data Analyst / Python Developer

📄 License
This project is licensed under the MIT License.
