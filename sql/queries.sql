
-- ============================================
-- E-commerce Customer Churn & RFM Analysis
-- SQL Queries: Business Metrics Extraction
-- ============================================

-- 1. Overall business summary
SELECT 
    ROUND(SUM(Quantity * Price), 2) AS total_revenue,
    MIN(InvoiceDate) AS first_transaction,
    MAX(InvoiceDate) AS last_transaction,
    COUNT(DISTINCT Invoice) AS total_orders,
    COUNT(DISTINCT "Customer ID") AS total_customers
FROM transactions;

-- 2. Monthly revenue trend (note: Dec 2011 is a partial month, data ends Dec 9)
SELECT 
    strftime('%Y-%m', InvoiceDate) AS month,
    ROUND(SUM(Quantity * Price), 2) AS monthly_revenue,
    COUNT(DISTINCT Invoice) AS orders
FROM transactions
GROUP BY month
ORDER BY month;

-- 3. Top 10 customers by revenue
SELECT 
    "Customer ID",
    Country,
    ROUND(SUM(Quantity * Price), 2) AS total_spent,
    COUNT(DISTINCT Invoice) AS num_orders
FROM transactions
GROUP BY "Customer ID"
ORDER BY total_spent DESC
LIMIT 10;

-- 4. Top 10 products by revenue (excluding non-product codes: Manual, Postage, Discount, Carriage)
SELECT 
    StockCode,
    Description,
    ROUND(SUM(Quantity * Price), 2) AS total_revenue,
    SUM(Quantity) AS total_units_sold
FROM transactions
WHERE StockCode NOT IN ('M', 'POST', 'D', 'C2', 'DOT')
GROUP BY StockCode, Description
ORDER BY total_revenue DESC
LIMIT 10;

-- 5. Revenue by country
SELECT 
    Country,
    ROUND(SUM(Quantity * Price), 2) AS total_revenue,
    COUNT(DISTINCT "Customer ID") AS num_customers
FROM transactions
GROUP BY Country
ORDER BY total_revenue DESC
LIMIT 10;
