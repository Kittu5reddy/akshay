-- ====================================================================
-- Context: Bronze Layer Table Creation for CRM and ERP Sources
-- Purpose:
--     - Drops and recreates tables under schema [bronze].
--     - Ensures a clean slate for raw data ingestion from CSVs.
--     - Aligns table structure with expected source file format.
--     - Use `init.sql` beforehand if connection or schema issues arise.
-- ====================================================================

-- ========================================
-- Connect to DataWarehouse database
-- ========================================
USE DataWarehouse;
GO

-- =====================================================
-- CRM Source Tables: Bronze Layer (3 Tables)
-- Source: CRM flat files (CSV)
-- =====================================================

-- -----------------------------------------
-- Drop and Create: bronze.crm_customer_info
-- Customer master information from CRM
-- -----------------------------------------
PRINT 'Creation started at ' + CAST(GETDATE () AS VARCHAR);

IF EXISTS (
    SELECT *
    FROM sys.tables
    WHERE
        name = 'crm_customer_info'
        AND SCHEMA_NAME (schema_id) = 'bronze'
) BEGIN
DROP TABLE bronze.crm_customer_info;

PRINT 'bronze.crm_customer_info dropped';

END

CREATE TABLE bronze.crm_customer_info (
    cst_id INT,
    cst_key VARCHAR(225),
    cst_firstname VARCHAR(225),
    cst_lastname VARCHAR(225),
    cst_marital_status VARCHAR(225),
    cst_gndr VARCHAR(225),
    cst_create_date DATE
);

PRINT 'bronze.crm_customer_info created';

PRINT '--------------------------------';
GO

-- -----------------------------------------
-- Drop and Create: bronze.crm_product_info
-- Product information from CRM
-- -----------------------------------------
IF EXISTS (
    SELECT *
    FROM sys.tables
    WHERE
        name = 'crm_product_info'
        AND SCHEMA_NAME (schema_id) = 'bronze'
) BEGIN
DROP TABLE bronze.crm_product_info;

PRINT 'bronze.crm_product_info dropped';

END

CREATE TABLE bronze.crm_product_info (
    prd_id INT,
    prd_key VARCHAR(225),
    prd_nm VARCHAR(225),
    prd_cost VARCHAR(225),
    prd_line VARCHAR(225),
    prd_start_dt VARCHAR(225),
    prd_end_dt DATE
);

PRINT 'bronze.crm_product_info created';

PRINT '--------------------------------';
GO

-- -----------------------------------------
-- Drop and Create: bronze.crm_sales_details
-- Sales transaction details from CRM
-- Note: Dates are stored as INT; convert to DATE if needed.
-- -----------------------------------------
IF EXISTS (
    SELECT *
    FROM sys.tables
    WHERE
        name = 'crm_sales_details'
        AND SCHEMA_NAME (schema_id) = 'bronze'
) BEGIN
DROP TABLE bronze.crm_sales_details;

PRINT 'bronze.crm_sales_details dropped';

END

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num VARCHAR(225),
    sls_prd_key VARCHAR(225),
    sls_cust_id INT,
    sls_order_dt INT, -- Consider changing to DATE
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

PRINT 'bronze.crm_sales_details created';

PRINT '--------------------------------';
GO

-- =====================================================
-- ERP Source Tables: Bronze Layer (3 Tables)
-- Source: ERP CSV exports
-- =====================================================

-- -----------------------------------------
-- Drop and Create: bronze.erp_cust_az12
-- ERP customer demographic details
-- -----------------------------------------
IF EXISTS (
    SELECT *
    FROM sys.tables
    WHERE
        name = 'erp_cust_az12'
        AND SCHEMA_NAME (schema_id) = 'bronze'
) BEGIN
DROP TABLE bronze.erp_cust_az12;

PRINT 'bronze.erp_cust_az12 dropped';

END

CREATE TABLE bronze.erp_cust_az12 (
    cid VARCHAR(225),
    bdate DATE,
    gen VARCHAR(225)
);

PRINT 'bronze.erp_cust_az12 created';

PRINT '--------------------------------';
GO

-- -----------------------------------------
-- Drop and Create: bronze.erp_loc_a101
-- ERP customer location details
-- -----------------------------------------
IF EXISTS (
    SELECT *
    FROM sys.tables
    WHERE
        name = 'erp_loc_a101'
        AND SCHEMA_NAME (schema_id) = 'bronze'
) BEGIN
DROP TABLE bronze.erp_loc_a101;

PRINT 'bronze.erp_loc_a101 dropped';

END

CREATE TABLE bronze.erp_loc_a101 (
    cid VARCHAR(225),
    cntry VARCHAR(225)
);

PRINT 'bronze.erp_loc_a101 created';

PRINT '--------------------------------';
GO

-- -----------------------------------------
-- Drop and Create: bronze.erp_px_cat_g1v2
-- ERP product categories and maintenance types
-- -----------------------------------------
IF EXISTS (
    SELECT *
    FROM sys.tables
    WHERE
        name = 'erp_px_cat_g1v2'
        AND SCHEMA_NAME (schema_id) = 'bronze'
) BEGIN
DROP TABLE bronze.erp_px_cat_g1v2;

PRINT 'bronze.erp_px_cat_g1v2 dropped';

END

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id VARCHAR(225),
    cat VARCHAR(225),
    subcat VARCHAR(225),
    mainteanane VARCHAR(225) -- Typo: should be 'maintenance'
);

PRINT 'bronze.erp_px_cat_g1v2 created';

PRINT '--------------------------------';

PRINT 'Creation ended at ' + CAST(GETDATE () AS VARCHAR);
GO

-- ========================================
-- Execute procedure to load CSV data
-- ========================================
EXEC load_bronze;