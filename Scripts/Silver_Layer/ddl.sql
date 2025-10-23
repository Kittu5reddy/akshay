-- ====================================================================
-- Context: silver Layer Table Creation for CRM and ERP Sources
-- Purpose:
--     - Drops and recreates tables under schema [silver].
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
-- CRM Source Tables: silver Layer (3 Tables)
-- Source: CRM flat files (CSV)
-- =====================================================

-- -----------------------------------------
-- Drop and Create: silver.crm_customer_info
-- -----------------------------------------
print 'creatation started at ' + cast(getDate () as varchar);

IF EXISTS (
    SELECT *
    FROM sys.tables
    WHERE
        name = 'crm_customer_info'
        AND SCHEMA_NAME (schema_id) = 'silver'
) BEGIN
DROP TABLE silver.crm_customer_info;

PRINT 'silver.crm_customer_info dropped';

END

CREATE TABLE silver.crm_customer_info (
    cst_id INT,
    cst_key VARCHAR(225),
    cst_firstname VARCHAR(225),
    cst_lastname VARCHAR(225),
    cst_marital_status VARCHAR(225),
    cst_gndr VARCHAR(225),
    cst_create_date DATE
);

PRINT 'silver.crm_customer_info created';

PRINT '--------------------------------';
GO

-- -----------------------------------------
-- Drop and Create: silver.crm_product_info
-- -----------------------------------------
IF EXISTS (
    SELECT *
    FROM sys.tables
    WHERE
        name = 'crm_product_info'
        AND SCHEMA_NAME (schema_id) = 'silver'
) BEGIN
DROP TABLE silver.crm_product_info;

PRINT 'silver.crm_product_info dropped';

END

CREATE TABLE silver.crm_product_info (
    prd_id INT,
    prd_key VARCHAR(225),
    prd_nm VARCHAR(225),
    prd_cost VARCHAR(225),
    prd_line VARCHAR(225),
    prd_start_dt VARCHAR(225),
    prd_end_dt DATE
);

PRINT 'silver.crm_product_info created';

PRINT '--------------------------------';
GO

-- -----------------------------------------
-- Drop and Create: silver.crm_sales_details
-- Note: Date fields are currently stored as INT.
--       Consider changing to DATE if applicable.
-- -----------------------------------------
IF EXISTS (
    SELECT *
    FROM sys.tables
    WHERE
        name = 'crm_sales_details'
        AND SCHEMA_NAME (schema_id) = 'silver'
) BEGIN
DROP TABLE silver.crm_sales_details;

PRINT 'silver.crm_sales_details dropped';

END

CREATE TABLE silver.crm_sales_details (
    sls_ord_num VARCHAR(225),
    sls_prd_key VARCHAR(225),
    sls_cust_id INT,
    sls_order_dt INT, -- Change to DATE if needed
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

PRINT 'silver.crm_sales_details created';

PRINT '--------------------------------';
GO

-- =====================================================
-- ERP Source Tables: silver Layer (3 Tables)
-- Source: ERP CSV exports
-- =====================================================

-- -----------------------------------------
-- Drop and Create: silver.erp_cust_az12
-- Customer demographics from ERP
-- -----------------------------------------
IF EXISTS (
    SELECT *
    FROM sys.tables
    WHERE
        name = 'erp_cust_az12'
        AND SCHEMA_NAME (schema_id) = 'silver'
) BEGIN
DROP TABLE silver.erp_cust_az12;

PRINT 'silver.erp_cust_az12 dropped';

END

CREATE TABLE silver.erp_cust_az12 (
    cid VARCHAR(225),
    bdate DATE,
    gen VARCHAR(225)
);

PRINT 'silver.erp_cust_az12 created';

PRINT '--------------------------------';
GO

-- -----------------------------------------
-- Drop and Create: silver.erp_loc_a101
-- Customer location details from ERP
-- -----------------------------------------
IF EXISTS (
    SELECT *
    FROM sys.tables
    WHERE
        name = 'erp_loc_a101'
        AND SCHEMA_NAME (schema_id) = 'silver'
) BEGIN
DROP TABLE silver.erp_loc_a101;

PRINT 'silver.erp_loc_a101 dropped';

END

CREATE TABLE silver.erp_loc_a101 (
    cid VARCHAR(225),
    cntry VARCHAR(225)
);

PRINT 'silver.erp_loc_a101 created';

PRINT '--------------------------------';
GO

-- -----------------------------------------
-- Drop and Create: silver.erp_px_cat_g1v2
-- Product category and maintenance type
-- -----------------------------------------
IF EXISTS (
    SELECT *
    FROM sys.tables
    WHERE
        name = 'erp_px_cat_g1v2'
        AND SCHEMA_NAME (schema_id) = 'silver'
) BEGIN
DROP TABLE silver.erp_px_cat_g1v2;

PRINT 'silver.erp_px_cat_g1v2 dropped';

END

CREATE TABLE silver.erp_px_cat_g1v2 (
    id VARCHAR(225),
    cat VARCHAR(225),
    subcat VARCHAR(225),
    mainteanane VARCHAR(225) -- Typo: Consider renaming to 'maintenance'
);

PRINT 'silver.erp_px_cat_g1v2 created';

PRINT '--------------------------------';

print 'creatation ended at ' + cast(getDate () as varchar);
GO