Create schema sales_analysis;
Use sales_analysis;

-- SALES PERFORMANCE --

-- 1. Total Revenue --
SELECT SUM(`Total Revenue`) AS total_revenue
FROM sales_data;

-- 2. Total Profit --
SELECT SUM(`Total Profit`) AS total_profit
FROM sales_data;

-- 3. Total Cost --
SELECT SUM(`Total Cost`) AS total_cost
FROM sales_data;

SELECT * FROM sales_data;

-- 4.  Profit Margin % --
SELECT 
    (SUM(`Total Profit`) / SUM(`Total Revenue`)) * 100 AS profit_margin_percent
FROM sales_data;

-- 5. Average Order Value --
SELECT AVG(`Total Revenue`) AS avg_order_value
FROM sales_data;

-- TIME BASED ANALYSIS --

-- 6.Monthly Revenue Trend  --
SELECT
    DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y'), '%Y-%m') AS month_year,
    SUM(`Total Revenue`) AS revenue
FROM sales_data
GROUP BY month_year
ORDER BY month_year;

-- 7. Monthly Profit Trend  --
SELECT 
     DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y'), '%Y-%m') AS month_year,
    SUM(`Total Profit`) AS profit
FROM sales_data
GROUP BY month_year
ORDER BY month_year;

-- 8. Yearly Sales --
SELECT 
     DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y'), '%Y-%m') AS year,
    SUM(`Total Revenue`) AS revenue
FROM sales_data
GROUP BY year
ORDER BY year;

-- 9.  Daily Orders --
SELECT 
    `Order Date`,
    COUNT(*) AS total_orders
FROM sales_data
GROUP BY `Order Date`
ORDER BY `Order Date`;

-- COUNTRY AND REGION --

-- 10. Revenue by Region --
SELECT Region, SUM(`Total Revenue`) AS revenue
FROM sales_data
GROUP BY Region
ORDER BY revenue DESC;

-- 11.  Revenue by Country --
SELECT Country, SUM(`Total Revenue`) AS revenue
FROM sales_data
GROUP BY Country
ORDER BY revenue DESC;

-- 12. Top 5 Countries by Profit --
SELECT Country, SUM(`Total Profit`) AS profit
FROM sales_data
GROUP BY Country
ORDER BY profit DESC
LIMIT 5; 

-- ITEM ANALYSIS  --

-- 13.  Top 5 Items by Sales --
SELECT `Item Type`, SUM(`Total Revenue`) AS revenue
FROM sales_data
GROUP BY `Item Type`
ORDER BY revenue DESC
LIMIT 5;

-- 14. Least Selling Items --
SELECT `Item Type` , SUM(`Total Revenue`) AS revenue
FROM sales_data
GROUP BY `Item Type`
ORDER BY revenue ASC;

-- 15. Most Profitable Item --
SELECT 	`Item Type`, SUM(`Total Profit`) AS profit
FROM sales_data
GROUP BY `Item Type`
ORDER BY profit DESC
LIMIT 1;

-- 16.  Average Price per Item Type --
SELECT `Item Type` , AVG(`Unit Price`) AS avg_price
FROM sales_data
GROUP BY `Item Type`;

-- SALES CHANNEL --

-- 17. Revenue by Channel --
SELECT `Sales Channel` , SUM(`Total Revenue`) AS revenue
FROM sales_data
GROUP BY `Sales Channel`;

-- 18. Profit by Channel --
SELECT `Sales Channel` , SUM(`Total Profit`) AS profit
FROM sales_data
GROUP BY `Sales Channel`;

--  ORDER PROCESSING & OPERATIONS --

-- 19. Average Processing Time (days) --
SELECT 
    AVG(
        DATEDIFF(
            STR_TO_DATE(`ship date` , '%m/%d/%Y'),
            STR_TO_DATE(`order date`, '%m/%d/%Y')
        )
    ) AS avg_processing_days
FROM sales_data;

-- 20. Orders Delayed (>10 days) --
SELECT *
FROM sales_data
WHERE  DATEDIFF( 
            STR_TO_DATE(`ship date` , '%m/%d/%Y'),
            STR_TO_DATE(`order date`, '%m/%d/%Y')) > 10;
            
-- 21. Monthly Processing Trend --
SELECT 
   DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y'), '%Y-%m') AS month,
    AVG (DATEDIFF(
            STR_TO_DATE(`ship date` , '%m/%d/%Y'),
            STR_TO_DATE(`order date`, '%m/%d/%Y')
        ) 
        ) AS avg_processing_days
FROM sales_data
GROUP BY month
ORDER BY month;

--  PRIORITY ORDERS --

-- 22. High Priority Orders Count -- 
SELECT COUNT(*) AS high_priority_orders
FROM sales_data
WHERE `Order Priority` = 'H';

-- 23. Medium Priority Orders Count --
SELECT COUNT(*) AS medium_priority_orders
FROM sales_data
WHERE `Order Priority` = 'M';

-- 24. Profit from High Priority Orders --
SELECT SUM(`Total Profit`) AS profit
FROM sales_data
WHERE `Order Priority` = 'H';

 -- COST & MARGINS --
 
-- 25. Cost vs Revenue by Item --
SELECT 
    `Item Type`,
    SUM(`Total Cost`) AS total_cost,
    SUM(`Total Revenue`) AS total_revenue
FROM sales_data
GROUP BY `Item Type`;

-- 26. Profit Margin by Item --
SELECT 
    `Item Type` ,
    (SUM(`Total Profit`) / SUM(`Total Revenue`)) * 100 AS margin_percent
FROM sales_data
GROUP BY `Item Type`
ORDER BY margin_percent DESC;

 -- SALES QUANTITY --
 
-- 27. Total Units Sold --
SELECT SUM(`Units Sold`) AS total_units_sold
FROM sales_data;

-- 28.  Units Sold per Item Type --
SELECT `Item Type`, SUM(`Units Sold`) AS units
FROM sales_data
GROUP BY `Item Type`
ORDER BY units DESC;

-- ORDER-LEVEL INSIGHTS --

-- 29. Highest Revenue Order --
SELECT *
FROM sales_data
ORDER BY `Total Revenue` DESC
LIMIT 5;

-- 30.  Orders with High Profit Margin (>40%) --
SELECT *
FROM sales_data
WHERE (`Total Profit` / `Total Revenue`) > 0.40;



















 











