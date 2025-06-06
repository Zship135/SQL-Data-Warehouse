/*
===============================================================
Create Database and Schemas
===============================================================
Purpose:
  This script directs into the DataWarehouse database if need be. It drops the database and recreates it if it already exists. The last purpose is to create the schemas
  for the three layers of the warehouse, 'bronze', 'silver', and 'gold'.

WARNING:
  Running this script WILL drop the "DataWarehouse" database and all of the content in it. Please have backups before running this.
*/

-- Make sure you are in the correct database if need be
-- Database: DataWarehouse

DROP DATABASE IF EXISTS "DataWarehouse";
CREATE DATABASE "DataWarehouse"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- CREATE SCHEMA FOR LAYERS OF DATA WAREHOUSE ARCHITECTURE
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
