--SQL Retails sales analysis - p1
CREATE DATABASE sql_project_p1

--create Table
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
select *
from retail_sales
limit 10

select count(*)
from retail_sales

--
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

-- DATA CLEANING

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

--DATA EXPLORATION

--HOW MANY SALE WE HAVE

SELECT COUNT(*) AS TOTAL_SALE
FROM retail_sales

--HOW MANY UNIQUE CUSTOMER WE HAVE
SELECT COUNT(DISTINCT customer_id) as unique_customer
FROM retail_sales

--categories
SELECT DISTINCT category
from retail_sales

--DATA ANALYSIS AND BUSINESS KEY PROBLEM AND ANSWER

--Q.1) Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05'

--Q.2) Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
and TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
and quantiy >= 4

--Q.3) Write a SQL query to calculate the total sales (total_sale) for each category


SELECT category,
sum(total_sale) as total_sale
FROM retail_sales
GROUP BY 1

--Q.4) Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

SELECT customer_id,
ROUND(avg(age),2) as avg_age
FROM retail_sales
WHERE category ='Beauty'
group by 1

--Q.5) Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT *
FROM retail_sales
WHERE total_sale > 1000

--Q.6) Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT gender,category,
count(transactions_id) as total_number_of_transaction
FROM retail_sales
group by 1,2
order by 1

--Q.7) Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

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

--Q.8) Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id,
sum(total_sale) as total_sales
FROM retail_sales
group by 1
order by 2 desc
limit 5

--Q.9)Write a SQL query to find the number of unique customers who purchased items from each category

SELECT category,
count(DISTINCT(customer_id)) as unique_customer
from retail_sales
group by 1

--Q.10)Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH table1 as 
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
FROM table1 
GROUP BY 1

--END OF PROJECT

