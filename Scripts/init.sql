-- ========================================
-- Step 1: Connect to the master database
-- and drop the existing DataWarehouse if it exists
-- ========================================
USE master;
GO

IF EXISTS (
    SELECT name
    FROM sys.databases
    WHERE
        name = 'DataWarehouse'
) BEGIN

DROP DATABASE DataWarehouse;

END
-- ========================================
-- Step 2: Create a new DataWarehouse database
-- ========================================
CREATE DATABASE DataWarehouse;
GO
-- Switch context to the newly created database
USE DataWarehouse;
GO

-- ========================================
-- Step 3: Drop existing schemas if they exist
-- and create new schemas for Bronze, Silver, and Gold layers
-- ========================================

-- Drop and create Bronze schema
IF EXISTS (
    SELECT name
    FROM sys.schemas
    WHERE
        name = 'bronze'
) BEGIN

DROP SCHEMA bronze;

END

CREATE SCHEMA bronze;
GO

-- Drop and create Silver schema
IF EXISTS (
    SELECT name
    FROM sys.schemas
    WHERE
        name = 'silver'
) BEGIN

DROP SCHEMA silver;

END

CREATE SCHEMA silver;
GO

-- Drop and create Gold schema
IF EXISTS (
    SELECT name
    FROM sys.schemas
    WHERE
        name = 'gold'
) BEGIN
DROP SCHEMA gold;

END

CREATE SCHEMA gold;
GO