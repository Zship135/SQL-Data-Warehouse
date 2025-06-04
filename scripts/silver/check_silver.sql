/*
===============================================================
Check What Needs Cleaned in the Silver Layer
===============================================================
After cleaning the the bronze layer we want to make sure that the data was cleaned correctly by 
checking again in the silver layer.
*/
---------------------------------------------------------------
-- crm_cust_info --
---------------------------------------------------------------

-- Check for duplicate primary key values and NULL primary key values --
SELECT cust_id, COUNT(*)
FROM silver.crm_cust_info
GROUP BY cust_id
HAVING COUNT(*) > 1 OR cust_id IS NULL;

-- Check data quality --
-- Check unwanted white space --
SELECT cust_firstname
FROM silver.crm_cust_info
WHERE cust_firstname != TRIM(cust_firstname); -- DOES NOT NEED CLEANED --

SELECT cust_lastname
FROM silver.crm_cust_info
WHERE cust_lastname != TRIM(cust_lastname); -- DOES NOT NEED CLEANED --

SELECT cust_marital_status
FROM silver.crm_cust_info
WHERE cust_marital_status != TRIM(cust_marital_status); -- DOES NOT NEED CLEANED --

SELECT cust_gender
FROM silver.crm_cust_info
WHERE cust_gender != TRIM(cust_gender); -- DOES NOT NEED CLEANED --

-- check data consistency --
SELECT DISTINCT cust_gender
FROM silver.crm_cust_info;

SELECT DISTINCT cust_marital_status
FROM silver.crm_cust_info;
