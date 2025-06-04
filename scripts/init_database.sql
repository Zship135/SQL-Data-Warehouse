/*
===============================================================
Create Database and Schemas
===============================================================
The purpose of this script is to initialize a new database named "DataWarehouse" if it does not already exist.
It is also meant to create three schemas, "bronze", "silver", and "gold."

WARNING:
  Running this script WILL drop the "DataWarehouse" database and all of the content in it. Please have backups before running this.
*/

-- Database: DataWarehouse

-- DROP DATABASE IF EXISTS "DataWarehouse";

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
