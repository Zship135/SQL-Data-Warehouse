
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
CASE WHEN UPPER(TRIM(cust_marital_status)) = 'S' THEN 'Single'
	 WHEN UPPER(TRIM(cust_marital_status)) = 'M' THEN 'Married'
	 ELSE 'n/a'
END cust_marital_status,
CASE WHEN UPPER(TRIM(cust_gender)) = 'F' THEN 'Female'
	 WHEN UPPER(TRIM(cust_gender)) = 'M' THEN 'Male'
	 ELSE 'n/a'
END cust_gender,
cust_create_date
FROM (
	SELECT *, ROW_NUMBER() OVER (PARTITION BY cust_id ORDER BY cust_create_date DESC) AS last_flag 
	FROM bronze.crm_cust_info
	WHERE cust_id IS NOT NULL
) WHERE last_flag = 1;
