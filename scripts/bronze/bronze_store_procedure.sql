/*
===============================================================
Bronze Layer Store Procedure
===============================================================
Purpose:
	This script creates a store procedure for the bronze layer with update messages included. We need to use PSQL for this since
	pgAdmin does not have the 'COPY' function.
*/

CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS
$$
BEGIN
	RAISE NOTICE '=======================================================';
	RAISE NOTICE 'Loading Bronze Layer...';
	RAISE NOTICE '=======================================================';

	RAISE NOTICE '-------------------------------------------------------';
	RAISE NOTICE '>> Truncating Table: bronze.crm_cust_info';
    TRUNCATE TABLE bronze.crm_cust_info;
	RAISE NOTICE '>> Inserting Data From: cust_info.csv';
	RAISE NOTICE '                  Into: bronze.crm_cust_info';
    COPY bronze.crm_cust_info FROM 'C:/Users/zship/projects/sql_projects/sql_data_warehouse/datasets/source_crm/cust_info.csv' 
    WITH (FORMAT csv, HEADER, DELIMITER ',');
	RAISE NOTICE '-------------------------------------------------------';

	RAISE NOTICE '-------------------------------------------------------';
	RAISE NOTICE '>> Truncating Table: bronze.crm_product_info';
	RAISE NOTICE '>> Inserting Data From: prd_info.csv';
	RAISE NOTICE '                  Into: bronze.crm_product_info';
    TRUNCATE TABLE bronze.crm_product_info;
    COPY bronze.crm_product_info FROM 'C:/Users/zship/projects/sql_projects/sql_data_warehouse/datasets/source_crm/prd_info.csv' 
    WITH (FORMAT csv, HEADER, DELIMITER ',');
	RAISE NOTICE '-------------------------------------------------------';

	RAISE NOTICE '-------------------------------------------------------';
	RAISE NOTICE '>> Truncating Table: bronze.crm_sales_info';
	RAISE NOTICE '>> Inserting Data From: sales_details.csv';
	RAISE NOTICE '                  Into: bronze.crm_sales_info';
    TRUNCATE TABLE bronze.crm_sales_info;
    COPY bronze.crm_sales_info FROM 'C:/Users/zship/projects/sql_projects/sql_data_warehouse/datasets/source_crm/sales_details.csv' 
    WITH (FORMAT csv, HEADER, DELIMITER ',');
	RAISE NOTICE '-------------------------------------------------------';

	RAISE NOTICE '-------------------------------------------------------';
	RAISE NOTICE '>> Truncating Table: bronze.erp_cust_az12';
	RAISE NOTICE '>> Inserting Data From: CUST_AZ12.csv';
	RAISE NOTICE '                  Into: bronze.erp_cust_az12';
    TRUNCATE TABLE bronze.erp_cust_az12;
    COPY bronze.erp_cust_az12 FROM 'C:/Users/zship/projects/sql_projects/sql_data_warehouse/datasets/source_erp/CUST_AZ12.csv' 
    WITH (FORMAT csv, HEADER, DELIMITER ',');
	RAISE NOTICE '-------------------------------------------------------';

	RAISE NOTICE '-------------------------------------------------------';
	RAISE NOTICE '>> Truncating Table: bronze.erp_loc_a101';
	RAISE NOTICE '>> Inserting Data From: LOC_A101.csv';
	RAISE NOTICE '                  Into: bronze.erp_loc_a101';
    TRUNCATE TABLE bronze.erp_loc_a101;
    COPY bronze.erp_loc_a101 FROM 'C:/Users/zship/projects/sql_projects/sql_data_warehouse/datasets/source_erp/LOC_A101.csv' 
    WITH (FORMAT csv, HEADER, DELIMITER ',');
	RAISE NOTICE '-------------------------------------------------------';

	RAISE NOTICE '-------------------------------------------------------';
	RAISE NOTICE '>> Truncating Table: bronze.erp_px_cat_g1v2';
	RAISE NOTICE '>> Inserting Data From: PX_CAT_G1V2.csv';
	RAISE NOTICE '                  Into: bronze.erp_px_cat_g1v2';
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    COPY bronze.erp_px_cat_g1v2 FROM 'C:/Users/zship/projects/sql_projects/sql_data_warehouse/datasets/source_erp/PX_CAT_G1V2.csv' 
    WITH (FORMAT csv, HEADER, DELIMITER ',');
	RAISE NOTICE '-------------------------------------------------------';
END;
$$;
