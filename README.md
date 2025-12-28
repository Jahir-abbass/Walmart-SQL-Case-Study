# Walmart Sales Performance Analysis (SQL Case Study)

## Objective
Analyze Walmart’s weekly sales data to understand sales trends, store performance, and the impact of holidays using SQL and provide recomendation based on the insights.

## Tools Used
- MySQL
- SQL (GROUP BY, HAVING, CASE, Window Functions, Date Functions)

## Dataset
Source: https://www.kaggle.com/datasets/varsharam/walmart-sales-dataset-of-45stores

---

## Key Insights
- A small number of stores contribute a disproportionately large share of total revenue.
- Holiday weeks show higher average weekly sales compared to non-holiday weeks.
- Year-wise analysis reveals a consistent upward trend in total sales.
- Sales performance varies significantly across stores, indicating regional demand differences.
- Clear seasonality is observed in monthly sales trends.

---

## Skills Demonstrated
- Writing complex SQL queries using `GROUP BY`, `HAVING`, and aggregate functions.
- Performing time-based analysis using date functions.
- Applying window functions (`RANK()`) to rank stores by performance.
- Translating raw data into meaningful business insights.
- Structuring analytical findings in a professional, readable format.

---

## Outcome & Recommendations
- Focus marketing and inventory efforts on top-performing stores to maximize revenue.
- Leverage holiday periods with targeted promotions to further boost sales.
- Analyze underperforming stores to identify improvement opportunities.
- Use seasonal trends to optimize staffing and supply chain planning.

## Business Questions & SQL Analysis:-

### 1. What is the total revenue generated?
```sql
SELECT 
     ROUND(SUM(Weekly_Sales), 2) AS total_revenue
FROM walmart_sales;
```

### 2. How many unique stores are included?
```sql
SELECT 
     COUNT(DISTINCT Store) as total_store 
FROM walmart_sales;
```

### 3. Which are the top 5 stores by total sales?
```sql
SELECT 
     Store,
     ROUND(SUM(Weekly_Sales), 2) AS total_sales 
From walmart_sales
group by store 
order by total_sales DESC 
LIMIT 5;
```

### 4. How do holiday weeks compare to non-holiday weeks in terms of sales?
```sql
SELECT 
    Holiday_Flag,
    ROUND(AVG(Weekly_Sales), 2) AS average_weekly_sales
FROM
    walmart_sales
GROUP BY Holiday_FLag;
```

### 5. What are the monthly sales trends?
```sql
SELECT 
     DATE_FORMAT(STR_TO_DATE(Date, '%d-%m-%Y'), '%Y-%m') AS month,
     ROUND(SUM(Weekly_Sales), 2) AS total_sales 
FROM walmart_sales
group by month 
order by month;
```

### 6. How can stores be ranked by total sales?
```sql
SELECT 
      Store, 
      ROUND(SUM(Weekly_Sales), 2) AS total_sales,
      RANK() OVER (ORDER BY SUM(Weekly_Sales) DESC) AS sales_rank 
FROM walmart_sales
group by Store;
```

### 7. Which stores perform above the average sales level?
```sql
SELECT 
     Store,
     ROUND(SUM(Weekly_Sales), 2) AS total_sales  
from walmart_sales
group by Store
having total_sales > (select avg(Weekly_Sales) from walmart_sales);
```

### 8. What is the impact of holidays on average sales?
```sql
SELECT 
      Holiday_Flag,
      ROUND(AVG(Weekly_Sales), 2)  AS Average_Sales 
FROM walmart_sales
group by Holiday_Flag;

```

### 9. How can stores be categorized based on sales performance?
```sql
SELECT 
	 Store,
     CASE 
         WHEN SUM(Weekly_Sales)  > 120000000 THEN 'High'
         WHEN SUM(Weekly_Sales)  BETWEEN 80000000 AND 120000000 THEN 'Medium'
         else 'Low'
		END AS sales_Category 
FROM walmart_sales
GROUP BY Store;
```

### 10. What is the yearly sales trend?
```sql
SELECT 
      YEAR(str_to_date(date, '%d-%m-%Y')) as Year,
      ROUND(SUM(Weekly_Sales), 2) as Total_sales  
from walmart_sales
GROUP BY Year
ORDER BY Year ASC;
```

### 11. Month wise sales trends?
```sql
SELECT 
      MONTH(str_to_date(date, '%d-%m-%Y')) as Month,
      ROUND(SUM(Weekly_Sales), 2) as Total_sales  
from walmart_sales
GROUP BY Month 
ORDER BY Month ASC;
```
