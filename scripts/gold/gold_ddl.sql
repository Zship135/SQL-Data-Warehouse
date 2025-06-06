
-- Dimension for customers --

DROP VIEW IF EXISTS gold.dim_customers CASCADE;
CREATE VIEW gold.dim_customers AS
SELECT
	ROW_NUMBER() OVER (ORDER BY ci.cust_id) AS customer_key,
	ci.cust_id AS customer_id, 
	ci.cust_key AS customer_number,
	ci.cust_firstname AS first_name,
	ci.cust_lastname AS last_name,
	ci.cust_marital_status AS marital_status,
	CASE WHEN ci.cust_gender != 'n/a' THEN ci.cust_gender
		 ELSE COALESCE(ca.gender, 'n/a')
	END AS gender,
	ca.birthdate,
	la.country
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca ON ci.cust_key = ca.cust_id
LEFT JOIN silver.erp_loc_a101 la ON ci.cust_key = la.cust_id;

-- Dimension for products

DROP VIEW IF EXISTS gold.dim_products;
CREATE VIEW gold.dim_products AS
SELECT
	ROW_NUMBER() OVER (ORDER BY product_start_date, product_key) AS product_key,
	pn.product_id,
	pn.product_key AS product_number,
	pn.product_name,
	pn.cat_id AS category_id,
	pc.category,
	pc.subcategory,
	pc.maintenance,
	pn.product_cost AS cost,
	pn.product_line,
	pn.product_start_date AS start_date
FROM silver.crm_product_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc ON pc.id = pn.cat_id
WHERE product_end_date IS NULL;

-- Fact table for sales --

DROP VIEW IF EXISTS gold.fact_sales CASCADE;
CREATE VIEW gold.fact_sales AS
SELECT
	si.sales_order_num AS order_number,
	pr.product_key,
	cs.customer_key,
	si.sales_order_date AS order_date,
	si.sales_ship_date AS shipping_date,
	si.sales_due_date AS due_date,
	si.sales_sales AS sales_amount,
	si.sales_quantity AS quantity,
	si.sales_price AS price
FROM silver.crm_sales_info si
LEFT JOIN gold.dim_products pr ON si.sales_product_key = pr.product_number
LEFT JOIN gold.dim_customers cs ON si.sales_cust_id = cs.customer_id;
