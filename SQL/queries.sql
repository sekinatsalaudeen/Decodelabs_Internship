USE dda;

-- 1. Revenue by Order Status
SELECT
OrderStatus,
SUM(TotalPrice) AS Revenue
FROM dda
GROUP BY OrderStatus;

-- 2. Product Revenue Trend Analysis
SELECT
YEAR AS Year,
Product,
SUM(TotalPrice) AS Revenue
FROM dda
GROUP BY Product, YEAR
ORDER BY Product, Year;

-- 3. Order Volume Trend by Product
SELECT
YEAR AS Year,
Product,
COUNT(OrderID) AS Orders
FROM dda
GROUP BY YEAR, Product
ORDER BY Product, Year;

-- 4. Successful vs Unsuccessful Revenue
SELECT
CASE
WHEN OrderStatus IN ('Delivered','Shipped')
THEN 'Successful'
ELSE 'Unsuccessful'
END AS OrderOutcome,
SUM(TotalPrice) AS Revenue
FROM dda
GROUP BY OrderOutcome;

-- 5. Percentage of Successful vs Unsuccessful Revenue
SELECT
CASE
WHEN OrderStatus IN ('Delivered','Shipped')
THEN 'Successful'
ELSE 'Unsuccessful'
END AS OrderOutcome,
SUM(TotalPrice) AS Revenue,
ROUND(
SUM(TotalPrice) * 100.0 /
(SELECT SUM(TotalPrice) FROM dda),
2
) AS RevenuePercentage
FROM dda
GROUP BY OrderOutcome;

-- 6. Revenue Ranking by Order Status
SELECT
OrderStatus,
SUM(TotalPrice) AS Revenue
FROM dda
GROUP BY OrderStatus
ORDER BY Revenue DESC;

-- 7. Unsuccessful Revenue by Product
SELECT
Product,
SUM(TotalPrice) AS UnsuccessfulRevenue
FROM dda
WHERE OrderStatus IN ('Cancelled','Returned','Pending')
GROUP BY Product
ORDER BY UnsuccessfulRevenue DESC;
