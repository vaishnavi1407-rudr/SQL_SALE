SQL RETAILS

SQL Retails sales analysis - p1 

CREATE DATABASE sql_project_p1

WE HAVE TO CREATE TABLE 

CREATE TABLE retail_sales
                        (
						transactions_id	INT PRIMARY KEY,
						sale_date DATE,
						sale_time TIME,
						customer_id	INT,
						gender	VARCHAR(15),
						age	INT,
						category VARCHAR(15),	
						quantiy	INT,
						price_per_unit FLOAT,	
						cogs FLOAT,
						total_sale FLOAT
						);
