-- ------------------------------------------------------------------
-- 0). First, How Many Rows are in the Products Table?
-- ------------------------------------------------------------------
SELECT COUNT(*) 
FROM northwind.products;

-- ------------------------------------------------------------------
-- 1). Product Name and Unit/Quantity
-- ------------------------------------------------------------------
SELECT product_name
	, quantity_per_unit 
FROM northwind.products;

-- ------------------------------------------------------------------
-- 2). Product ID and Name of Current Products
-- ------------------------------------------------------------------
SELECT id AS product_id
	, product_name
FROM northwind.products
WHERE discontinued != 1;

-- ------------------------------------------------------------------
-- 3). Product ID and Name of Discontinued Products
-- ------------------------------------------------------------------
SELECT id AS product_id
	, product_name
FROM northwind.products
WHERE discontinued = 1;


-- ------------------------------------------------------------------
-- 4). Name & List Price of Most & Least Expensive Products
-- ------------------------------------------------------------------
SELECT product_name
	, list_price
FROM northwind.products
WHERE list_price = (SELECT min(list_price) AS min_price FROM northwind.products)
OR list_price = (SELECT max(list_price) AS max_price FROM northwind.products)
ORDER BY list_price;

-- ------------------------------------------------------------------
-- 5). Product ID, Name & List Price Costing Less Than $20
-- ------------------------------------------------------------------
SELECT id AS product_id
	, product_name
    , list_price
FROM northwind.products
WHERE list_price < 20.00
ORDER BY list_price DESC;

-- ------------------------------------------------------------------
-- 6). Product ID, Name & List Price Costing Between $15 and $20
-- ------------------------------------------------------------------
SELECT id AS product_id
	, product_name
    , list_price
FROM northwind.products
WHERE list_price >= 15.00
AND list_price <= 20.00
ORDER BY list_price DESC;


-- ------------------------------------------------------------------
-- 7). Product Name & List Price Costing Above Average List Price
-- ------------------------------------------------------------------
SELECT product_name
	, list_price
FROM northwind.products
WHERE list_price > (SELECT ROUND(AVG(list_price), 2) AS min_price FROM northwind.products)
ORDER BY list_price DESC;
-- ------------------------------------------------------------------
-- 8). Product Name & List Price of 10 Most Expensive Products 
-- ------------------------------------------------------------------
SELECT product_name
	, ROUND(list_price, 2) AS list_price
FROM northwind.products
ORDER BY list_price DESC
LIMIT 10;

-- ------------------------------------------------------------------ 
-- 9). Count of Current and Discontinued Products 
-- ------------------------------------------------------------------
UPDATE northwind.products SET discontinued = 1 WHERE id IN (95, 96, 97);
SELECT CASE WHEN discontinued = 1 THEN 'yes'
	ELSE 'no'
	END AS is_discontinued
	, COUNT(*) as product_count
FROM northwind.products
GROUP BY discontinued;
        
    

-- ------------------------------------------------------------------
-- 10). Product Name, Units on Order and Units in Stock
--      Where Quantity In-Stock is Less Than the Quantity On-Order. 
-- ------------------------------------------------------------------
SELECT product_name
	, reorder_level
    , (target_level - reorder_level) AS units_in_stock
FROM northwind.products
WHERE reorder_level < (target_level - reorder_level)
ORDER BY reorder_level DESC;


-- ------------------------------------------------------------------
-- EXTRA CREDIT -----------------------------------------------------
-- ------------------------------------------------------------------


-- ------------------------------------------------------------------
-- 11). Products with Supplier Company & Address Info
-- ------------------------------------------------------------------
SELECT p.id as product_id
	, p.product_name
    , s.id AS supplier_id
    , s.company
    , s.address
    , s.city
    , s.state_province
    , s.zip_postal_code
    , s.country_region
FROM northwind.products AS p
JOIN northwind.suppliers AS s
ON s.id = p.supplier_ids;


-- ------------------------------------------------------------------
-- 12). Number of Products per Category With Less Than 5 Units
-- ------------------------------------------------------------------
SELECT category
	, COUNT(*) as units
FROM northwind.products 
GROUP BY category
HAVING COUNT(*) < 5
ORDER BY COUNT(*) DESC; 


-- ------------------------------------------------------------------
-- 13). Number of Products per Category Priced Less Than $20.00
-- ------------------------------------------------------------------
SELECT category
	, COUNT(*) as units
FROM northwind.products 
WHERE list_price < 20
GROUP BY category;
