/*

*/


DROP TABLE IF EXISTS bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info (
	cust_id INT,
	cust_key CHAR(10),
	cust_firstname VARCHAR(50),
	cust_lastname VARCHAR(50),
	cust_marital_status CHAR(1),
	cust_gender CHAR(1),
	cust_create_date DATE
);

DROP TABLE IF EXISTS bronze.crm_product_info;
CREATE TABLE bronze.crm_product_info (
	product_id CHAR(3),
	product_key VARCHAR(20),
	product_name VARCHAR(250),
	product_cost INT,
	product_line CHAR(1),
	product_start_date DATE,
	product_end_date DATE
);

DROP TABLE IF EXISTS bronze.crm_sales_info;
CREATE TABLE bronze.crm_sales_info (
	sales_order_num CHAR(7),
	sales_product_key CHAR(10),
	sales_cust_id INT,
	sales_order_date INT,
	sales_ship_date INT,
	sales_due_date INT,
	sales_sales INT,
	sales_quantity INT,
	sales_price INT
);

DROP TABLE IF EXISTS bronze.erp_cust_az12;
CREATE TABLE bronze.erp_cust_az12 (
	cust_id VARCHAR(13),
	birthdate DATE,
	gender VARCHAR(6)
);

DROP TABLE IF EXISTS bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101 (
	cust_id VARCHAR(11),
	country VARCHAR(50)
);

DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2 (
	id CHAR(5),
	category VARCHAR(50),
	subcategory VARCHAR(50),
	maintenance VARCHAR(3)
);
