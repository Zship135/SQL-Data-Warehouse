# SQL-Data-Warehouse
### Problem Statement
**Objective**

Develop a modern data warehouse using PostgreSQL to consolidate customer, sales, and product data for enhanced data analyses and business decision-making. 

**Specification**

- **Data Source**: Import CRM and ERP data from CSV files.
- **Data Architecture**: Building a data warehouse using Medallion Architecture.

---

# Building the Architecture
**Overview**

Before building the warehouse we need to know three things: where the data is coming from, how the warehouse will process it, and what it will be used for once loaded into the warehouse. Here is an illustration of how this will look.

![HighLevelOverviewOfArchitecture](https://github.com/user-attachments/assets/2ca377f8-3946-456b-80a0-f045577e43d6)

We are extracting our data by parsing CSV files and then using several layers in the warehouse to transform and load the data. Finally, our data analysts and business users can consume the data.

---

**Initialize**

Having this overview, we can begin to sketch out our database with PostgreSQL. The script for this initialization can be found [here](scripts/init_database.sql).
The general idea of the script is as follows:
- If the "Data Warehouse" database already exists, drop it and recreate it.
- Create the schemas for our three layers, "bronze", "silver", and "gold".

---

**The Bronze Layer**

The purpose of the bronze layer is to take raw, unprocessed data and store it in tables. This layer is what takes from our sources ()in our case, CSV files). Data Engineers are the only people intended to see this data as allowing anyone else access would be unnecessary because we will have better data in the silver and gold layers. Here is a breakdown of how we will make the bronze layer.

![BronzeLayer](https://github.com/user-attachments/assets/ce7337bd-9e25-4d28-b63d-7cd23704aa2a)

**Analyze**

Ordinarily, we would interview some sort of expert on the team to get the precise specifications and tech stack for building the warehouse. Let us say that these are our specifications for extraction:
- We will use a type of extraction known as full extraction. This means we will take all of the data from the source at one time.
- We will use a method of extraction known as pull extraction. This means the data is being taken from the source, rather than the source pushing the data into the warehouse.
- The extraction technique we will use is file parsing. This is because our data is stored in CSV files.

**Code**

We will use data definition language (DDL) to write a script to create tables for our data.







