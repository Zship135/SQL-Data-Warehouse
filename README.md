# SQL-Data-Warehouse
### Problem Statement
**Objective**

Develop a modern data warehouse using PostgreSQL to consolidate customer, sales, and product data for enhanced data analyses and business decision-making. 

**Specification**

- **Data Source**: Import CRM and ERP data from CSV files.
- **Data Architecture**: Building a data warehouse using Medallion Architecture.

---

### Building the Architecture
**Overview**

Before building the warehouse we need to know three things: where the data is coming from, how the warehouse will process it, and what it will be used for once loaded into the warehouse. Here is an illustration of how this will look.

![HighLevelOverviewOfArchitecture](https://github.com/user-attachments/assets/2ca377f8-3946-456b-80a0-f045577e43d6)

We are extracting our data by parsing CSV files and then using several layers in the warehouse to transform and load the data. Finally, our data analysts and business users can consume the data.

**Initialize**
Having this overview, we can begin to sketch out our database with PostgreSQL. 


