use ecommerce_project;

SELECT * FROM sales LIMIT 10;

# Total Revenue
SELECT SUM(Quantity * UnitPrice) AS Total_Revenue
FROM sales;

# Total Customers
SELECT COUNT(DISTINCT CustomerID) AS Total_Customers
FROM sales;

# Total Order
SELECT COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM sales;

# Monthly Revenue Trend
SELECT 
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month,
    SUM(Quantity * UnitPrice) AS Revenue
FROM sales
GROUP BY Month
ORDER BY Month;

#Top 10 Customers
SELECT 
    CustomerID,
    SUM(Quantity * UnitPrice) AS Revenue
FROM sales
GROUP BY CustomerID
ORDER BY Revenue DESC
LIMIT 10;


#Top 10 Products
SELECT 
    Description,
    SUM(Quantity * UnitPrice) AS Revenue
FROM sales
GROUP BY Description
ORDER BY Revenue DESC
LIMIT 10;

# Highest Revenue of a Month
SELECT 
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month,
    SUM(Quantity * UnitPrice) AS Revenue
FROM sales
GROUP BY Month
ORDER BY Revenue desc;
-- Insight: November 2011 recorded the highest revenue,
-- likely due to seasonal demand and holiday sales.

#Repeat vs One-Time Customers
SELECT 
    CASE 
        WHEN order_count = 1 THEN 'One-Time'
        ELSE 'Repeat'
    END AS Customer_Type,
    COUNT(*) AS Customer_Count
FROM (
    SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS order_count
    FROM sales
    GROUP BY CustomerID
) t
GROUP BY Customer_Type;
-- Repeat customers dominate over one-time customers, indicating strong customer retention and loyalty within the business.
    
