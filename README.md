# SQL-Data-Warehouse

### Table of Contents
- [1. Problem Statement](#Problem-Statement)

- [2. Warehouse Architecture](#Warehouse-Architecture)

- [3. Initialize](#Initialize)

- [4. Builing the Warehouse](#Building-the-Warehouse)

  - [a. The Bronze Layer](#The-Bronze-Layer)

---

## Problem Statement

In many organizations, business data is spread across operational systems such as customer relationship managers (CRM) and enterprise resource planners (ERP). This fragmentation introduces challenges for data analysts, who often spend considerable time locating, cleaning, and reconciling inconsistent datasets.

This project addresses this by designing and implementing a centralized data warehouse using PostgreSQL. The warehouse ingests structured data exported from CRM and ERP systems in the form of CSV files, transforming it through multiple layers of refinement based on the Medallion Architecture (bronze, silver, gold).

The goal is to ensure that all stakeholders, analysts, and business users access the same consistent, clean, and well-structured data. This approach reduces the time spent on manual data preparation, improves data quality, and establishes a single source of data for reporting and analysis. In a real-world context, collaboration with a source systems engineer would be essential to resolve discrepancies and clarify data lineage.

---

## Warehouse Architecture
### Overview

Undertaking this project would require planning and collaboration with stakeholders and experts in the company. Using these expertise and needs of the company we must outline our extract, transform, and load (ETL) process.
<br>
<br>
<br>
***extraction***

For the extraction we are using a pull extraction where the warehouse reads the data directly from the CSV files. All of the data will be extracted from each file all
at once meaning we will full extract. Lastly, our extraction technique will be file parsing, as we are working with CSV files. 
<br>
<br>
<br>
***transformation***

All sorts of transformation is required in any architecture. In general, techniques of data enrichment, integration, normalization/ standardization, and aggregation will be needed. Removal of duplicate keys and outliers is also necessary. Data must also be consistent and follow common business rules and calculations.
<br>
<br>
<br>
***loading***

The data will be loaded in batches to the warehouse to ensure analysts and stakeholders have common information at any given time. All data will be fully loaded by truncating tables within the warehouse and inserting extracted data back in. We will use a Type 1 Common Changing Dimension (SCD 1) meaning we will simply overwrite previous data within the warehouse in each batch.
<br>
<br>
<br>
***Warehouse Architecture***

For the general architecture we will use a Medallion Architecture with three layers: bronze, silver, and gold.
- Bronze: raw data directly from the CSV files
  - accessibility: data engineer
- Silver: transformed, cleaned data
  - accessibility: data engineer, data analyst
- Gold: Business ready data which has simplified naming and is divided into integrated facts and dimension tables
  - accessibility: data analyst, business-users, stackholders

![HighLevelOverviewOfArchitecture](https://github.com/user-attachments/assets/2ca377f8-3946-456b-80a0-f045577e43d6)

---

## Initialize

The [script to initialize](scripts/init_database.sql) the database is used to create the 'DataWarehouse' database which will house all of our data. The script also creates three schemas, 'bronze', 'silver', and 'gold'. These schemas will hold all tables, views, and procedures for each layer.

---

## Building the Warehouse

### The Bronze Layer

The purpose of the bronze layer is to take raw, unprocessed data and store it in tables. This layer is what takes from our sources (in our case, CSV files). Data Engineers are the only people intended to see this data as allowing anyone else access would be unnecessary because we will have better data in the silver and gold layers. Here is a breakdown of how we will make the bronze layer.

![BronzeLayer](https://github.com/user-attachments/assets/ce7337bd-9e25-4d28-b63d-7cd23704aa2a)

***Analyze***

Ordinarily, we would interview some sort of expert on the team to get the precise specifications and tech stack for building the warehouse. Let us say that these are our specifications for extraction:
- We will use a type of extraction known as full extraction. This means we will take all of the data from the source at one time.
- We will use a method of extraction known as pull extraction. This means the data is being taken from the source, rather than the source pushing the data into the warehouse.
- The extraction technique we will use is file parsing. This is because our data is stored in CSV files.

**Code**

We will use data definition language (DDL) to write a [script](scripts/bronze/bronze_ddl.sql) to create tables for our data. The data from the CSV was imported using the built-in import feature in PGAdmin.
Once this is all imported, we check the integrity of the data to make sure that the row count is correct and that the data was inserted into the correct columns.
This is done with SELECT statements. The code for this can also be found [here](scripts/bronze/bronze_ddl.sql).

The bronze layer is now complete. We have ingested the raw data from our two sources and now we are ready to get started on the silver layer.

---

**The Silver Layer**

The silver layer is where we clean the raw data from the bronze layer so that it is usable by our analysts. While this data is not business-ready, it is almost there. 
We go through and analyze the structure of the data to understand the requirements for cleaning. This is done using a relational schema.

![SilverLayer](https://github.com/user-attachments/assets/0fa607ee-7979-4e97-82e7-42698ba40fec)

**Analyze**

For the analysis of this layer, we make a relational schema.

![DataStructure](https://github.com/user-attachments/assets/be3396fd-cb88-4639-9967-ee764a9666b1)

Here we can see the columns of all of the tables from both of our sources and how they interconnect. Knowing this gives the data engineers insight into building the code of the silver layer.

**Code** 

First, the [DDL code](scripts/silver/silver_ddl.sql) is written. The tables in the silver layer are initially the same as the bronze. We add the dwh_create_date table to give additional information on when the last time the tables were created. 





