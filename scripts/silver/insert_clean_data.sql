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

----------------------------------------------
-- crm_sales_info --
----------------------------------------------
INSERT INTO silver.crm_sales_info (
	sales_order_num,
	sales_product_key,
	sales_cust_id,
	sales_order_date,
	sales_ship_date,
	sales_due_date,
	sales_sales,
	sales_quantity,
	sales_price
)
SELECT
sales_order_num,
sales_product_key,
sales_cust_id,
CASE WHEN sales_order_date <= 0 OR LENGTH(sales_order_date::TEXT) != 8 THEN NULL
	 ELSE CAST(CAST(sales_order_date AS VARCHAR)AS DATE)
END AS sales_order_date,
CASE WHEN sales_ship_date <= 0 OR LENGTH(sales_ship_date::TEXT) != 8 THEN NULL
	 ELSE CAST(CAST(sales_ship_date AS VARCHAR)AS DATE)
END AS sales_ship_date,
CASE WHEN sales_due_date <= 0 OR LENGTH(sales_due_date::TEXT) != 8 THEN NULL
	 ELSE CAST(CAST(sales_due_date AS VARCHAR)AS DATE)
END AS sales_due_date,
CASE WHEN sales_sales <= 0 OR sales_sales IS NULL OR sales_sales != ABS(sales_quantity) * ABS(sales_price) THEN ABS(sales_quantity) * ABS(sales_price)
	 ELSE sales_sales
END AS sales_sales,
sales_quantity,
CASE WHEN sales_price <= 0 OR sales_price IS NULL OR sales_price != ABS(sales_sales) / COALESCE(ABS(sales_quantity), 0) THEN ABS(sales_sales) / COALESCE(ABS(sales_quantity), 0)
	 ELSE sales_price
END AS sales_price
FROM bronze.crm_sales_info;

