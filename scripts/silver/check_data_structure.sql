/*
===========================================
Check Data Structure
===========================================
This is a simple script that allows me to sample the first 1000 rows of each table so I can see the connections and structure of the data. I used this script to aid in
the creation of the relational schema.
*/

SELECT * FROM bronze.crm_cust_info LIMIT 1000;
SELECT * FROM bronze.crm_product_info LIMIT 1000;
SELECT * FROM bronze.crm_sales_info LIMIT 1000;
SELECT * FROM bronze.erp_cust_az12 LIMIT 1000;
SELECT * FROM bronze.erp_loc_a101 LIMIT 1000;
SELECT * FROM bronze.erp_px_cat_g1v2 LIMIT 1000;
