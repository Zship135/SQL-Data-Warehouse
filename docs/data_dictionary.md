# Data Dictionary for Gold Layer of Warehouse

dim_customer
------------------------------------------------------------------------
| Column Name     | Data Type   | Description                          | 
|-----------------|-------------|--------------------------------------|
| customer_key    | BIGINT      | unique value for each row of data    |
| customer_id     | INT         | internal customer identifier         |
| customer_number | CHAR(10)    | business-facing customer identifier  |
| first_name      | VARCHAR(50) | customer first name                  |
| last_name       | VARCHAR(50) | customer last name                   |
| marital_status  | VARCHAR(50) | customer is either married or single |
| gender          | VARCHAR(50) | customer gender                      |
| birthdate       | DATE        | customer date of birth               |
| country         | VARCHAR(50) | customer country of origin           |
------------------------------------------------------------------------

dim_products
---------------------------------------------------------------------------------------------
| Column Name    | Data Type    | Description                                               |
|----------------|--------------|-----------------------------------------------------------|
| product_key    | BIGINT       | unique value for each row of data                         |
| product_id     | CHAR(3)      | internal product identifier                               |
| product_number | VARCHAR(20)  | business-facing product identifier                        |
| product_name   | VARCHAR(250) | written description of product                            |
| category_id    | VARCHAR(50)  | identifier of what category the product belongs to        |
| category       | VARCHAR(50)  | written out description of product category               |
| subcategory    | VARCHAR(50)  | written out description of product subcategory            |
| maintenance    | VARCHAR(3)   | boolean value denoting if product may require maintenance |
| cost           | INT          | the price of the product in-store                         |
| product_line   | VARCHAR(50)  | description of what line the product belongs to           |
| start_date     | DATE         | the date the product began being sold                     |
---------------------------------------------------------------------------------------------

fact_sales
-------------------------------------------------------------------
| Column Name   | Data Type | Description                         |
|---------------|-----------|-------------------------------------|
| order_number  | CHAR(7)   | identifier for a customer order     |
| product_key   | BIGINT    | what product was ordered            |
| customer_key  | BIGINT    | which customer placed the order     |
| order_date    | DATE      | date when customer placed the order |
| shipping_date | DATE      | date when product is shipped out    |
| due_date      | DATE      | date when customer receives product |
| sales_amount  | INT       | calculated by (quantity) * price    |
| quantity      | INT       | amount of product ordered           |
| price         | INT       | price of product ordered            |
-------------------------------------------------------------------

