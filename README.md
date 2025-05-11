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

      Objectives

       1) Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
       2) Data Cleaning: Identify and remove any records with missing or null values.
       3) Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
       4) Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.
       
Null Value Check: Check for any null values in the dataset and delete records with missing data.

select *
from retail_sales
where transactions_id is null
or
sale_date is null
or 
sale_time is null
or
customer_id is null
or 
gender is null
or
age is null
or
category is null
or 
quantiy is null
or 
price_per_unit is null
or 
cogs is null
or 
total_sale is null

Null Value Delete: Data cleaning.

DELETE FROM retail_sales
where transactions_id is null
or
sale_date is null
or 
sale_time is null
or
customer_id is null
or 
gender is null
or
age is null
or
category is null
or 
quantiy is null
or 
price_per_unit is null
or 
cogs is null
or 
total_sale is null

Record Count: Determine the total number of records in the dataset.

select count(*)
from retail_sales

Customer Count: Find out how many unique customers are in the dataset.

SELECT COUNT(DISTINCT customer_id) as unique_customer
FROM retail_sales

Category Count: Identify all unique product categories in the dataset.

SELECT DISTINCT category
from retail_sales

Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

Q.1) Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

Q.2) Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4

Q.3) Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1

Q.4) Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'

Q.5) Write a SQL query to find all transactions where the total_sale is greater than 1000.:

SELECT * FROM retail_sales
WHERE total_sale > 1000

Q.6) Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT gender,category,
count(transactions_id) as total_number_of_transaction
FROM retail_sales
group by 1,2
order by 1

Q.7) Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

With table1 as
(
SELECT *,
extract(month from sale_date) as month,
extract(year from sale_date) as year
FROM retail_sales
),table2 as 
(
select
year,
month,
avg(total_sale) as avg_sale,
rank() over(partition by year order by avg(total_sale) desc) as rn
from table1
group by 1,2
)
select 
year,month,avg_sale
from table2
where rn = 1

Q.8) Write a SQL query to find the top 5 customers based on the highest total sales:


SELECT customer_id,
sum(total_sale) as total_sales
FROM retail_sales
group by 1
order by 2 desc
limit 5

Q.9) Write a SQL query to find the number of unique customers who purchased items from each category:

SELECT category,
count(DISTINCT(customer_id)) as unique_customer
from retail_sales
group by 1

Q.10) Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

Findings
Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
Sales Trends: Monthly analysis shows variations in sales, helping identify peak seasons.
Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.
Reports


Sales Summary: A detailed report summarizing total sales, customer demographics, and category performance.
Trend Analysis: Insights into sales trends across different months and shifts.
Customer Insights: Reports on top customers and unique customer counts per category.


Conclusion
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

How to Use
Clone the Repository: Clone this project repository from GitHub.
Set Up the Database: Run the SQL scripts provided in the database_setup.sql file to create and populate the database.
Run the Queries: Use the SQL queries provided in the analysis_queries.sql file to perform your analysis.
Explore and Modify: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.


Author - Zero Analyst
This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!



