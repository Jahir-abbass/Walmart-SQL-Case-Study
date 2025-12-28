create database walmart;
use walmart;
select * from walmart_sales;


-- 1. Total revenue 
SELECT 
     ROUND(SUM(Weekly_Sales), 2) AS total_revenue
FROM walmart_sales;

-- 2. TOTAL NUMBER OF STORES
SELECT 
     COUNT(DISTINCT Store) as total_store 
FROM walmart_sales;

-- 3. Top 5 stores by total sales 
SELECT 
     Store,
     ROUND(SUM(Weekly_Sales), 2) AS total_sales 
From walmart_sales
group by store 
order by total_sales DESC 
LIMIT 5;

-- 4. Holiday VS Non-Holiday Average sales 
SELECT 
    Holiday_Flag,
    ROUND(AVG(Weekly_Sales), 2) AS average_weekly_sales
FROM
    walmart_sales
GROUP BY Holiday_FLag;


-- 5. Monthly Sales Trend 
SELECT 
     DATE_FORMAT(STR_TO_DATE(Date, '%d-%m-%Y'), '%Y-%m') AS month,
     ROUND(SUM(Weekly_Sales), 2) AS total_sales 
FROM walmart_sales
group by month 
order by month;

-- 6. Rank stores by total sales (Window Function)
SELECT 
      Store, 
      ROUND(SUM(Weekly_Sales), 2) AS total_sales,
      RANK() OVER (ORDER BY SUM(Weekly_Sales) DESC) AS sales_rank 
FROM walmart_sales
group by Store;

-- 7. Stores Performing Above Average 
SELECT 
     Store,
     ROUND(SUM(Weekly_Sales), 2) AS total_sales  
from walmart_sales
group by Store
having total_sales > (select avg(Weekly_Sales) from walmart_sales);

-- 8. Holiday Impact (Difference in sales)
SELECT 
      Holiday_Flag,
      ROUND(AVG(Weekly_Sales), 2)  AS Average_Sales 
FROM walmart_sales
group by Holiday_Flag;


-- 9. Sales Category using case 
SELECT 
	 Store,
     CASE 
         WHEN SUM(Weekly_Sales)  > 120000000 THEN 'High'
         WHEN SUM(Weekly_Sales)  BETWEEN 80000000 AND 120000000 THEN 'Medium'
         else 'Low'
		END AS sales_Category 
FROM walmart_sales
GROUP BY Store;


-- 10. Year wise sales trends 
SELECT 
      YEAR(str_to_date(date, '%d-%m-%Y')) as Year,
      ROUND(SUM(Weekly_Sales), 2) as Total_sales  
from walmart_sales
GROUP BY Year
ORDER BY Year ASC;


-- 11. Month Wise Sales Trends 
SELECT 
      MONTH(str_to_date(date, '%d-%m-%Y')) as Month,
      ROUND(SUM(Weekly_Sales), 2) as Total_sales  
from walmart_sales
GROUP BY Month 
ORDER BY Month ASC;
