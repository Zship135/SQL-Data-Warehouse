/*
===============================================================
Insert Clean Data Into Silver Layer
===============================================================

*/
----------------------------------------------
-- crm_cust_info --
----------------------------------------------
INSERT INTO silver.crm_cust_info (
  cust_id,
  cust_key,
  cust_firstname,
  cust_lastname,
  cust_marital_status,
  cust_gender,
  cust_create_date
)
SELECT 
cust_id, 
cust_key, 
TRIM(cust_firstname), 
TRIM(cust_lastname), 
CASE UPPER(TRIM(cust_marital_status))
	 WHEN 'S' THEN 'Single'
	 WHEN 'M' THEN 'Married'
	 ELSE 'n/a'
END cust_marital_status,
CASE UPPER(TRIM(cust_gender))
	 WHEN 'F' THEN 'Female'
	 WHEN 'M' THEN 'Male'
	 ELSE 'n/a'
END cust_gender,
cust_create_date
FROM (
	SELECT *, ROW_NUMBER() OVER (PARTITION BY cust_id ORDER BY cust_create_date DESC) AS last_flag 
	FROM bronze.crm_cust_info
	WHERE cust_id IS NOT NULL
) WHERE last_flag = 1;

----------------------------------------------
-- crm_product_info --
----------------------------------------------

INSERT INTO silver.crm_product_info (
product_id,
cat_id,
product_key,
product_name,
product_cost,
product_line,
product_start_date,
product_end_date
)
SELECT
product_id,
REPLACE(SUBSTRING(product_key, 1, 5), '-', '_') AS cat_id,
SUBSTRING(product_key, 7, LENGTH(product_key)) AS product_key,
product_name,
COALESCE(product_cost, 0) AS product_cost,
CASE UPPER(TRIM(product_line))
	 WHEN 'M' THEN 'Mountain'
	 WHEN 'R' THEN 'Road'
	 WHEN 'S' THEN 'Other Sales'
	 WHEN 'T' THEN 'Touring'
	 ELSE 'n/a'
END AS product_line,
CAST(product_start_date AS DATE) AS product_start_date,
CAST(LEAD (product_start_date) OVER (PARTITION BY product_key ORDER BY product_start_date)-1 AS DATE) AS product_end_date
FROM bronze.crm_product_info;

