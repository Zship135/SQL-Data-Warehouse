/*
===============================================================
Check What Needs Cleaned in the Bronze Layer
===============================================================
The purpose of this script is to check the integrity of the data in the bronze layer so we know what needs to be cleaned. We will write another script to insert
the cleaned data into the silver layer.
*/
---------------------------------------------------------------
-- crm_cust_info --
---------------------------------------------------------------

-- Check for duplicate primary key values and NULL primary key values --
SELECT cust_id, COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cust_id
HAVING COUNT(*) > 1 OR cust_id IS NULL;

-- Check data quality --
-- Check unwanted white space --
SELECT cust_firstname
FROM bronze.crm_cust_info
WHERE cust_firstname != TRIM(cust_firstname); -- NEEDS CLEANED --

SELECT cust_lastname
FROM bronze.crm_cust_info
WHERE cust_lastname != TRIM(cust_lastname); -- NEEDS CLEANED --

SELECT cust_marital_status
FROM bronze.crm_cust_info
WHERE cust_marital_status != TRIM(cust_marital_status); -- DOES NOT NEED CLEANED --

SELECT cust_gender
FROM bronze.crm_cust_info
WHERE cust_gender != TRIM(cust_gender); -- DOES NOT NEED CLEANED --

-- check data consistency --
SELECT DISTINCT cust_gender
FROM bronze.crm_cust_info;

SELECT DISTINCT cust_marital_status
FROM bronze.crm_cust_info;
