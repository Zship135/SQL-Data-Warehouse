/*
===============================================================
Create Tables For Silver Layer
===============================================================
This script creates the tables for the silver layer by copying the content from the bronze layer with the addition
of the dwh_create_date column. This new column describes the last time the silver layer was created.
*/

DROP TABLE IF EXISTS silver.crm_cust_info;
CREATE TABLE silver.crm_cust_info (
	cust_id INT,
	cust_key CHAR(10),
	cust_firstname VARCHAR(50),
	cust_lastname VARCHAR(50),
	cust_marital_status CHAR(50),
	cust_gender CHAR(50),
	cust_create_date DATE,
	dwh_create_date TIMESTAMP DEFAULT current_timestamp
);

DROP TABLE IF EXISTS silver.crm_product_info;
CREATE TABLE silver.crm_product_info (
	product_id CHAR(3),
	product_key VARCHAR(20),
	product_name VARCHAR(250),
	product_cost INT,
	product_line CHAR(1),
	product_start_date DATE,
	product_end_date DATE,
	dwh_create_date TIMESTAMP DEFAULT current_timestamp
);

DROP TABLE IF EXISTS silver.crm_sales_info;
CREATE TABLE silver.crm_sales_info (
	sales_order_num CHAR(7),
	sales_product_key CHAR(10),
	sales_cust_id INT,
	sales_order_date INT,
	sales_ship_date INT,
	sales_due_date INT,
	sales_sales INT,
	sales_quantity INT,
	sales_price INT,
	dwh_create_date TIMESTAMP DEFAULT current_timestamp
);

DROP TABLE IF EXISTS silver.erp_cust_az12;
CREATE TABLE silver.erp_cust_az12 (
	cust_id VARCHAR(13),
	birthdate DATE,
	gender VARCHAR(6),
	dwh_create_date TIMESTAMP DEFAULT current_timestamp
);

DROP TABLE IF EXISTS silver.erp_loc_a101;
CREATE TABLE silver.erp_loc_a101 (
	cust_id VARCHAR(11),
	country VARCHAR(50),
	dwh_create_date TIMESTAMP DEFAULT current_timestamp
);

DROP TABLE IF EXISTS silver.erp_px_cat_g1v2;
CREATE TABLE silver.erp_px_cat_g1v2 (
	id CHAR(5),
	category VARCHAR(50),
	subcategory VARCHAR(50),
	maintenance VARCHAR(3),
	dwh_create_date TIMESTAMP DEFAULT current_timestamp
);
