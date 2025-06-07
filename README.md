# SQL-Data-Warehouse

### Table of Contents
- [1. Problem Statement](#Problem-Statement)

- [2. Warehouse Architecture](#Warehouse-Architecture)

- [3. Initialize](#Initialize)

- [4. Building the Warehouse](#Building-the-Warehouse)

  - [a. The Bronze Layer](#The-Bronze-Layer)
    
  - [b. The Silver Layer](#The-Silver-Layer)
 
  - [c. The Gold Layer](#The-Gold-Layer)
    
- [5. Conclusion](#Conclusion)

---

## Problem Statement

In many organizations, business data is spread across operational systems such as customer relationship managers (CRM) and enterprise resource planners (ERP). This fragmentation introduces challenges for data analysts, who often spend considerable time locating, cleaning, and reconciling inconsistent datasets.

This project addresses this by designing and implementing a centralized data warehouse using PostgreSQL. The warehouse ingests structured data exported from CRM and ERP systems in the form of CSV files, transforming it through multiple layers of refinement based on the Medallion Architecture (bronze, silver, gold).

The goal is to ensure that all stakeholders, analysts, and business users access the same consistent, clean, and well-structured data. This approach reduces the time spent on manual data preparation, improves data quality, and establishes a single source of data for reporting and analysis. In a real-world context, collaboration with a source systems engineer would be essential to resolve discrepancies and clarify data lineage.

---

## Warehouse Architecture
### Overview

Undertaking this project would require planning and collaboration with stakeholders and experts in the company. Using the expertise and needs of the company we must outline our extract, transform, and load (ETL) process.
<br>
<br>
<br>
***extraction***

For the extraction we are using a pull extraction where the warehouse reads the data directly from the CSV files. All of the data will be extracted from each file all
at once meaning we will fully extract. Lastly, our extraction technique will be file parsing, as we are working with CSV files. 
<br>
<br>
<br>
***transformation***

All sorts of transformations are required in any architecture. In general, techniques of data enrichment, integration, normalization/ standardization, and aggregation will be needed. Removal of duplicate keys and outliers is also necessary. Data must also be consistent and follow common business rules and calculations.
<br>
<br>
<br>
***loading***

The data will be loaded in batches to the warehouse to ensure analysts and stakeholders have common information at any given time. All data will be fully loaded by truncating tables within the warehouse and inserting extracted data back in. We will use a Type 1 Common Changing Dimension (SCD 1) meaning we will simply overwrite previous data within the warehouse in each batch.
<br>
<br>
<br>
***Warehouse Architecture***

For the general architecture, we will use a Medallion Architecture with three layers: bronze, silver, and gold.
- Bronze: raw data directly from the CSV files
  - accessibility: data engineer
- Silver: transformed, cleaned data
  - accessibility: data engineer, data analyst
- Gold: Business-ready data that has simplified naming and is divided into integrated facts and dimension tables
  - accessibility: data analyst, business users, stakeholders

![HighLevelOverviewOfArchitecture](https://github.com/user-attachments/assets/2ca377f8-3946-456b-80a0-f045577e43d6)

---

## Initialize

The [script to initialize](scripts/init_database.sql) database is used to create the 'DataWarehouse' database which will house all of our data. The script also creates three schemas, 'bronze', 'silver', and 'gold'. These schemas will hold all tables, views, and procedures for each layer.

---

## Building the Warehouse

### The Bronze Layer

The purpose of the bronze layer is to take raw, unprocessed data and store it in tables. This layer is what takes from our sources (in our case, CSV files). Data Engineers are the only people intended to see this data as allowing anyone else access would be unnecessary because we will have better data in the silver and gold layers. Here is a breakdown of how we will make the bronze layer.

![BronzeLayer](https://github.com/user-attachments/assets/ce7337bd-9e25-4d28-b63d-7cd23704aa2a)

<br>
<br>
<br>

***Analyze***

Ordinarily, we would interview some sort of expert on the team to get the precise specifications and tech stack for building the warehouse. Let us say that these are our specifications for extraction:
- We will use a type of extraction known as full extraction. This means we will take all of the data from the source at one time.
- We will use a method of extraction known as pull extraction. This means the data is being taken from the source, rather than the source pushing the data into the warehouse.
- The extraction technique we will use is file parsing. This is because our data is stored in CSV files.
We can also view the data lineage for the bronze layer.

![BronzeLayerDataLineage](https://github.com/user-attachments/assets/cf3c3c77-a98c-4457-93e3-08c07deadb7e)

<br>
<br>
<br>

***Code***

We will use data definition language (DDL) to write a script to create tables for our data. We import data from the CSV files directly using a store procedure. To import the data we need to use PSQL within pgAdmin to gain access to the COPY function. 
> [Bronze DDL Script](scripts/bronze/bronze_ddl.sql)

> [Bronze Store Procedure](scripts/bronze/bronze_store_procedure.sql)
<br>
<br>
<br>

***Validate***

Once this is all imported, we check the integrity of the data to make sure that the row count is correct and that the data was inserted into the correct columns.
This is done with SELECT statements.
> [Check What Needs Cleaning in Bronze Layer](scripts/bronze/check_bronze.sql)

---

### The Silver Layer

The silver layer is where we clean the raw data from the bronze layer so that it is usable by our analysts. While this data is not business-ready, it is almost there. 
The process of coding and analyzing cycles until the data is properly cleaned.

![SilverLayer](https://github.com/user-attachments/assets/0fa607ee-7979-4e97-82e7-42698ba40fec)

<br>
<br>
<br>

**Analyze**

To validate and clean the data it is important to understand how the tables are related. This is especially important with multiple data sources. In addition to looking at the relationships, we can use scripts to check what needs cleaning in the bronze layer. We can also take a look at the silver layer added to the current data lineage. 
> [Check Bronze Layer](scripts/bronze/check_bronze.sql)

![DataStructure](https://github.com/user-attachments/assets/a6b764ce-f362-4161-9208-19701ff0ea28)

![SilverLayerDataLineage](https://github.com/user-attachments/assets/48e379d9-1009-48b7-a388-10f9a179ae48)

<br>
<br>
<br>

**Code** 

First, the DDL code is written. The tables in the silver layer are initially the same as the bronze. We add the dwh_create_date table to give additional information on when the last time the tables were created. We go through the process of cleaning each table one by one using what we learned by checking the bronze layer and then writing a store procedure to insert the cleaned data.
> [Silver DDL](scripts/silver/silver_ddl.sql)

> [Silver Layer Clean and Insert](scripts/silver/insert_clean_data.sql) 

<br>
<br>
<br>

***Validate***

After inserting the clean data into the silver layer, we must validate the silver layer. This ensures we did not make mistakes when cleaning and inserting.
> [Check Silver Layer](scripts/silver/check_silver.sql)

---

### The Gold Layer

The gold layer is the final layer of the warehouse and where the data becomes business-ready. Instead of tables, this layer will use views. Furthermore, we will use the Star Schema to connect our dimension tables and fact tables.

<br>
<br>
<br>

***Analyze***

The first step to creating the gold layer is to combine the tables into more general, business-friendly views. We do this by analyzing the integration model and categorizing each table into business objects. We can also get a look at the final data lineage of the entire warehouse.

![BusinessObjects](https://github.com/user-attachments/assets/17b9f6ef-0452-4da5-b3ea-a0f76850a9ad)

![FinalDataLineage](https://github.com/user-attachments/assets/8b83bb16-3ea5-4198-ad4c-f517feb59d01)



<br>
<br>
<br>

***Code***

The code for the gold layer involves left joining tables of the same business object, integrating the data between them, and then giving the column names user-friendly names. We then write a final store procedure.

> [Gold Layer DDL](scripts/gold/gold_ddl.sql)

> [Gold Layer Store Procedure](scripts/gold/gold_store_procedure.sql)

---

## Conclusion

This project demonstrates the design and implementation of a structured data warehouse using the Medallion Architecture in PostgreSQL, with raw data sourced from CRM and ERP systems in CSV format. By building out the bronze, silver, and gold layers, the warehouse effectively ingests, cleans, and prepares business data for consumption by analysts and decision-makers.

The bronze layer provides a secure landing zone for raw source data, the silver layer introduces normalization and quality assurance, and the gold layer delivers analytical outputs aligned with business needs. Each transformation step was implemented using SQL and managed via layered stored procedures, simulating the extract-load-transform (ELT) paradigm typical in modern data engineering pipelines.

While this project used static CSV files for simplicity, the architecture and methods used here are designed to scale toward more dynamic and automated ingestion scenarios. The result is a clean, centralized, and business-aligned data asset that reduces manual data wrangling and promotes consistent, trusted analytics.

The final result for the business user in the gold layer is a data mart which can be described by the following schema.

![DataMart](https://github.com/user-attachments/assets/723e7dae-556d-43b8-85e3-ee597bb6e8a0)






