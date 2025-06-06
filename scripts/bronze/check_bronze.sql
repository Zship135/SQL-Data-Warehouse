/*
===============================================================
Check What Needs Cleaning in the Bronze Layer
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

---------------------------------------------------------------
-- crm_product_info --
---------------------------------------------------------------

-- Check for duplicate primary key values and NULL primary key values --
SELECT product_id, COUNT(*)
FROM bronze.crm_product_info
GROUP BY product_id
HAVING COUNT(*) > 1 OR product_id IS NULL;

-- Check data quality --
-- Check unwanted white space --
SELECT product_name
FROM bronze.crm_product_info
WHERE product_name != TRIM(product_name); -- DOES NOT NEED CLEANED --

-- Check for negative numbers or NULL --
SELECT product_cost
FROM bronze.crm_product_info
WHERE product_cost < 0 OR product_cost IS NULL; -- HAS NULL VALUES --

-- check data consistency --
SELECT DISTINCT product_line
FROM bronze.crm_product_info;

-- check for invalid dates
SELECT *
FROM bronze.crm_product_info
WHERE product_end_date < product_start_date;

---------------------------------------------------------------
-- crm_sales_info --
---------------------------------------------------------------

-- Check data quality --
-- Check unwanted white space --
SELECT sales_order_num
FROM bronze.crm_sales_info
WHERE sales_order_num != TRIM(sales_order_num); -- DOES NOT NEED CLEANED --

SELECT sales_product_key
FROM bronze.crm_sales_info
WHERE sales_product_key != TRIM(sales_product_key); -- DOES NOT NEED CLEANED --

-- Check invalid dates --
SELECT sales_order_date
FROM bronze.crm_sales_info
WHERE sales_order_date <= 0 OR LENGTH(sales_order_date::TEXT) != 8;

SELECT sales_ship_date
FROM bronze.crm_sales_info
WHERE sales_ship_date <= 0 OR LENGTH(sales_ship_date::TEXT) != 8;

SELECT sales_due_date
FROM bronze.crm_sales_info
WHERE sales_due_date <= 0 OR LENGTH(sales_due_date::TEXT) != 8;

SELECT *
FROM bronze.crm_sales_info
WHERE sales_order_date > sales_ship_date OR sales_ship_date > sales_due_date OR sales_order_date > sales_due_date;

-- Check business rules --
SELECT DISTINCT sales_sales, sales_quantity, sales_price
FROM bronze.crm_sales_info
WHERE sales_sales != sales_quantity * sales_price
OR sales_sales IS NULL OR sales_quantity IS NULL OR sales_price IS NULL
OR sales_sales <= 0 OR sales_quantity <= 0 OR sales_price <= 0;

---------------------------------------------------------------
-- erp_cust_az12 --
---------------------------------------------------------------

-- Check birthdate range --
SELECT birthdate
FROM bronze.erp_cust_az12
WHERE birthdate < '1925-01-01' OR birthdate > CURRENT_DATE;

-- check data consistency --
SELECT DISTINCT gender
FROM bronze.erp_cust_az12;

---------------------------------------------------------------
-- erp_loc_a101 --
---------------------------------------------------------------

-- check data consistency --
SELECT DISTINCT country
FROM bronze.erp_loc_a101;

---------------------------------------------------------------
-- erp_px_cat_g1v2 --
---------------------------------------------------------------

-- Check data quality --
-- Check unwanted white space --
SELECT category
FROM bronze.erp_px_cat_g1v2
WHERE category != TRIM(category); -- DOES NOT NEED CLEANED --

SELECT subcategory
FROM bronze.erp_px_cat_g1v2
WHERE subcategory != TRIM(subcategory); -- DOES NOT NEED CLEANED --

SELECT maintenance
FROM bronze.erp_px_cat_g1v2
WHERE maintenance != TRIM(maintenance); -- DOES NOT NEED CLEANED --

-- check data consistency --
SELECT DISTINCT category
FROM bronze.erp_px_cat_g1v2;

SELECT DISTINCT subcategory
FROM bronze.erp_px_cat_g1v2;

SELECT DISTINCT maintenance
FROM bronze.erp_px_cat_g1v2;

