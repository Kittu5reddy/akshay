# Data-Warehouse

## Project Overview

This project implements a Data Warehouse solution to centralize and organize data from CRM (Customer Relationship Management) and ERP (Enterprise Resource Planning) systems. The solution is designed to support analytics, reporting, and business intelligence by providing a clean, consistent, and scalable data foundation.

## Architecture

The data warehouse follows a multi-layered architecture:

- **Bronze Layer:** Raw data ingestion from CRM and ERP CSV files. Tables in this layer mirror the structure of the source files and serve as the initial landing zone for all incoming data.
- **Silver Layer:** Staging and cleansing layer. Data from the bronze layer is validated, cleaned, and transformed as needed to ensure consistency and readiness for analytics or further transformation.

## Folder Structure

# Data-Warehouse

Data-Warehouse/
├── Scripts/
│ ├── Bronze_Layer/
│ │ ├── ddl.sql # DDL scripts for Bronze layer table creation
│ │ └── extraction.sql # Extraction/loading scripts for Bronze layer
│ ├── Silver_Layer/
│ │ ├── ddl.sql # DDL scripts for Silver layer table creation
│ │ └── extraction.sql # Extraction/loading scripts for Silver layer
├── README.md # Project documentation
└── (Other files as needed)

## Workflow

1. **Database Initialization:**  
   Ensure the `DataWarehouse` database and required schemas (`bronze`, `silver`) exist.

2. **Bronze Layer Table Creation:**  
   Run `Scripts/Brownze_Layer/ddl.sql` to create or reset all bronze layer tables.

3. **Bronze Layer Data Loading:**  
   Use `Scripts/Brownze_Layer/extration.sql` to load raw CSV data into the bronze tables.

4. **Silver Layer Table Creation:**  
   Run `Scripts/Silver_Layer/ddl.sql` to create or reset all silver layer tables.

5. **Silver Layer Data Loading:**  
   Use `Scripts/Silver_Layer/extration.sql` to transform and load data from bronze to silver tables.

6. **Analysis & Reporting:**  
   Use the silver layer as the foundation for further ETL, analytics, or reporting.

## Table Summary

| Layer  | Table Name               | Description                              | Source |
| ------ | ------------------------ | ---------------------------------------- | ------ |
| Bronze | bronze.crm_customer_info | CRM customer details                     | CRM    |
| Bronze | bronze.crm_product_info  | CRM product information                  | CRM    |
| Bronze | bronze.crm_sales_details | CRM sales transactions                   | CRM    |
| Bronze | bronze.erp_cust_az12     | ERP customer demographics                | ERP    |
| Bronze | bronze.erp_loc_a101      | ERP customer location details            | ERP    |
| Bronze | bronze.erp_px_cat_g1v2   | ERP product category and maintenance     | ERP    |
| Silver | silver.crm_customer_info | Cleaned CRM customer details             | CRM    |
| Silver | silver.crm_product_info  | Cleaned CRM product information          | CRM    |
| Silver | silver.crm_sales_details | Cleaned CRM sales transactions           | CRM    |
| Silver | silver.erp_cust_az12     | Cleaned ERP customer demographics        | ERP    |
| Silver | silver.erp_loc_a101      | Cleaned ERP customer location details    | ERP    |
| Silver | silver.erp_px_cat_g1v2   | Cleaned ERP product category/maintenance | ERP    |

## Key Features

- **Automated Table Management:** Scripts to drop and recreate tables for clean data loads.
- **Source Integration:** Handles both CRM and ERP data sources.
- **Schema Alignment:** Table structures match source file formats for easy ingestion.
- **Layered Cleansing:** Bronze for raw data, silver for cleaned/staged data.
- **Extensible:** Easily add new tables or layers as requirements grow.

## Notes

- Some date fields are stored as `INT` for compatibility; consider converting to `DATE` if required.
- There is a typo in the column name `mainteanane` (should be `maintenance`) in some tables—consider correcting for consistency.
- Use `init.sql` if provided, to initialize database and schemas before running DDL scripts.

## Author

- [Palvai Kaushik Reddy]
