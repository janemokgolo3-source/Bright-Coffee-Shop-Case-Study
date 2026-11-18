

SELECT *
FROM retails_casestudy.sales.brightcoffee;

--Limit the number of rows to 10: 
SELECT *
FROM retails_casestudy.sales.brightcoffee
LIMIT 10;


---Convert Unit price to decimal (for digits) commas:
---Check all columns are in the correct format when it come to data type. If not u need to convert.
---CAST(unit_price AS DOUBLE)
SELECT
    transaction_id,
    CAST(REPLACE(unit_price,',','.') AS DOUBLE) AS Unit_price --- Double means we are converting to decimal for digits.
FROM retails_casestudy.sales.brightcoffee;

SELECT
  date_format(transaction_time,'HH:mm:ss') AS trans_time,
  CAST(transaction_time AS TIMESTAMP) AS trans_time
FROM retails_casestudy.sales.brightcoffee;

--- Another example.
---SELECT 
---date_format(transaction_time,'HH:mm:ss') AS trans_time
---CAST(transaction_time AS TIME) AS trans_time
-----FROM retails_casestudy.sales.brightcoffee;

---Homework:
---Check for number of records:
SELECT
  COUNT(*) AS total_records
FROM retails_casestudy.sales.brightcoffee;

---Check for duplicates (It must be on a row-basis, and ot column-basis):
SELECT *,
   COUNT(*) AS Duplicate_count
FROM retails_casestudy.sales.brightcoffee
GROUP BY ALL---Grouping similar items
HAVING COUNT(*) > 1;--- USED TO CHECK THE DUPLCATES OF ROWS.

---Check for NULL Values:
SELECT *
FROM retails_casestudy.sales.brightcoffee
WHERE transaction_id is NULL OR transaction_date is NULL OR transaction_time is NULL OR transaction_qty is NULL OR store_id is NULL OR store_location is NULL OR product_id is NULL OR unit_price is NULL OR product_category is NULL OR product_type is NULL OR product_detail is NULL;
--No Null values
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  ---1. Total Revenue:

---1.1 total revenue,also using CAST AND replace to get the digital .
SELECT
     transaction_id,
     transaction_qty * CAST(REPLACE(unit_price,',','.') AS DOUBLE)AS Total_Amount
FROM retails_casestudy.sales.brightcoffee;

---1.2 We sum up total revenue column
SELECT
     SUM(transaction_qty * (CAST(REPLACE(unit_price,',','.') AS DOUBLE)))AS Total_Amount
FROM retails_casestudy.sales.brightcoffee;

---1.3 Showing total reveue to two decimal places

   SELECT
     SUM(transaction_qty * (CAST(REPLACE(unit_price,',','.') AS DECIMAL(10,2))))AS Total_Amount
FROM retails_casestudy.sales.brightcoffee;

---2.TOTAL REVENUE PER PRODUCT CATEGORY
   SELECT
   Product_category,
   SUM(transaction_qty * (CAST(REPLACE(unit_price,',','.') AS DECIMAL(10,2))))AS Total_Amount
FROM retails_casestudy.sales.brightcoffee
GROUP BY ALL;


---3 TOTAL REVENUE PER PRODUCT CATEGORY  AND PRODUCT DETAILS
SELECT
   Product_category,
   product_detail,
   SUM(transaction_qty * (CAST(REPLACE(unit_price,',','.') AS DECIMAL(10,2))))AS Total_Amount
FROM retails_casestudy.sales.brightcoffee
---WHERE product_category='Tea' 
---WHERE product_category = 'coffee'
GROUP BY ALL
ORDER BY product_category;

---4. TOTAL REVENUE PER PRODUCT TYPE
SELECT
   Product_type,
   SUM(transaction_qty * (CAST(REPLACE(unit_price,',','.') AS DECIMAL(10,2))))AS Total_Amount
FROM retails_casestudy.sales.brightcoffee
GROUP BY ALL;


---5.TOTAL UNITS SOLD
SELECT 
   SUM(transaction_qty) AS Total_units_sold
   FROM retails_casestudy.sales.brightcoffee;

---6.TOTAL REVENUE PER STORE LOCATION

SELECT
   store_location,
   SUM(transaction_qty * (CAST(REPLACE(unit_price,',','.') AS DECIMAL(10,2))))AS Total_Amount
FROM retails_casestudy.sales.brightcoffee
GROUP BY ALL;


---7.TOTAL REVENUE BASED ON THE TIME OF THE DAY-formeaning purpose
 --Earlist and latest transaction time

  SELECT  
    MIN(transaction_time),
    MAX(transaction_time)
   FROM  retails_casestudy.sales.brightcoffee;
   

   --- 6am - 11:59:59 > Morning
   ---12pm - 16.59:59 _Afternoon
   ---17pm - 19:59:59 _Evening
   --- After 20pm >_Night
   
   ---7 CONVERTING TIME TO 24 HOUR FORMAT
   SELECT
   CASE
     WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
     WHEN transaction_time BETWEEN '02:00:00' AND '16:59:59' THEN 'Afternoon'
     WHEN transaction_time BETWEEN '17:00:00' AND '19:59:59' THEN 'Evening'
     ELSE 'Night'
   END AS time_bucket,
    COUNT(TRANSACTION_ID) AS Total_transactions
   FROM retails_casestudy.sales.brightcoffee
   GROUP BY ALL;

   
   ---Number of transaction per time bucket--for learning purpose

 SELECT
  --- transaction_time,
   ---product_category,
   CASE
     WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
     WHEN transaction_time BETWEEN '02:00:00' AND '16:59:59' THEN 'Afternoon'
     WHEN transaction_time BETWEEN '17:00:00' AND '19:59:59' THEN 'Evening'
     ELSE 'Night'
   END AS time_bucket,
   SUM(transaction_qty * (CAST(REPLACE(unit_price,',','.') AS DECIMAL(10,2))))AS Total_Amount
   FROM retails_casestudy.sales.brightcoffee
   GROUP BY ALL;


--- 8. Date extraction (Month name,month id,day name )

SELECT  
  transaction_date,
  MONTHNAME(transaction_date) AS month_name,
  MONTH(transaction_date) AS month_number,
  DATE_FORMAT(transaction_date, 'yyyy-MM') AS month,
  DAYNAME(transaction_date),
  DAYOFWEEK(transaction_date)
FROM retails_casestudy.sales.brightcoffee;

------------------------------------------------------------------------------------------------------------------------


-- COMBINE ALL THE CODES

SELECT *
FROM retails_casestudy.sales.brightcoffee;

--Limit the number of rows to 10: 
SELECT *
FROM retails_casestudy.sales.brightcoffee
LIMIT 10;


---Convert Unit price to decimal (for digits) commas:
---Check all columns are in the correct format when it come to data type. If not u need to convert.
---CAST(unit_price AS DOUBLE)
SELECT
    transaction_id,
    CAST(REPLACE(unit_price,',','.') AS DOUBLE) AS Unit_price --- Double means we are converting to decimal for digits.
FROM retails_casestudy.sales.brightcoffee;

SELECT
  date_format(transaction_time,'HH:mm:ss') AS trans_time,
  CAST(transaction_time AS TIMESTAMP) AS trans_time
FROM retails_casestudy.sales.brightcoffee;

--- Another example.
---SELECT 
---date_format(transaction_time,'HH:mm:ss') AS trans_time
---CAST(transaction_time AS TIME) AS trans_time
-----FROM retails_casestudy.sales.brightcoffee;

---Homework:
---Check for number of records:
SELECT
  COUNT(*) AS total_records
FROM retails_casestudy.sales.brightcoffee;

---Check for duplicates (It must be on a row-basis, and ot column-basis):
SELECT *,
   COUNT(*) AS Duplicate_count
FROM retails_casestudy.sales.brightcoffee
GROUP BY ALL---Grouping similar items
HAVING COUNT(*) > 1;--- USED TO CHECK THE DUPLCATES OF ROWS.

---Check for NULL Values:
SELECT *
FROM retails_casestudy.sales.brightcoffee
WHERE transaction_id is NULL OR transaction_date is NULL OR transaction_time is NULL OR transaction_qty is NULL OR store_id is NULL OR store_location is NULL OR product_id is NULL OR unit_price is NULL OR product_category is NULL OR product_type is NULL OR product_detail is NULL;
--No Null values
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  ---1. Total Revenue:

---1.1 total revenue,also using CAST AND replace to get the digital .
SELECT
     transaction_id,
     transaction_qty * CAST(REPLACE(unit_price,',','.') AS DOUBLE)AS Total_Amount
FROM retails_casestudy.sales.brightcoffee;

---1.2 We sum up total revenue column
SELECT
     SUM(transaction_qty * (CAST(REPLACE(unit_price,',','.') AS DOUBLE)))AS Total_Amount
FROM retails_casestudy.sales.brightcoffee;

---1.3 Showing total reveue to two decimal places

   SELECT
     SUM(transaction_qty * (CAST(REPLACE(unit_price,',','.') AS DECIMAL(10,2))))AS Total_Amount
FROM retails_casestudy.sales.brightcoffee;

---2.TOTAL REVENUE PER PRODUCT CATEGORY
   SELECT
   Product_category,
   SUM(transaction_qty * (CAST(REPLACE(unit_price,',','.') AS DECIMAL(10,2))))AS Total_Amount
FROM retails_casestudy.sales.brightcoffee
GROUP BY ALL;


---3 TOTAL REVENUE PER PRODUCT CATEGORY  AND PRODUCT DETAILS
SELECT
   Product_category,
   product_detail,
   SUM(transaction_qty * (CAST(REPLACE(unit_price,',','.') AS DECIMAL(10,2))))AS Total_Amount
FROM retails_casestudy.sales.brightcoffee
---WHERE product_category='Tea' 
---WHERE product_category = 'coffee'
GROUP BY ALL
ORDER BY product_category;

---4. TOTAL REVENUE PER PRODUCT TYPE
SELECT
   Product_type,
   SUM(transaction_qty * (CAST(REPLACE(unit_price,',','.') AS DECIMAL(10,2))))AS Total_Amount
FROM retails_casestudy.sales.brightcoffee
GROUP BY ALL;


---5.TOTAL UNITS SOLD
SELECT 
   SUM(transaction_qty) AS Total_units_sold
   FROM retails_casestudy.sales.brightcoffee;

---6.TOTAL REVENUE PER STORE LOCATION

SELECT
   store_location,
   SUM(transaction_qty * (CAST(REPLACE(unit_price,',','.') AS DECIMAL(10,2))))AS Total_Amount
FROM retails_casestudy.sales.brightcoffee
GROUP BY ALL;


---7.TOTAL REVENUE BASED ON THE TIME OF THE DAY-formeaning purpose
 --Earlist and latest transaction time

  SELECT  
    MIN(transaction_time),
    MAX(transaction_time)
   FROM  retails_casestudy.sales.brightcoffee;
   

   --- 6am - 11:59:59 > Morning
   ---12pm - 16.59:59 _Afternoon
   ---17pm - 19:59:59 _Evening
   --- After 20pm >_Night
   
   ---7 Number of transaction per time bucket
   SELECT
   CASE
     WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
     WHEN transaction_time BETWEEN '02:00:00' AND '16:59:59' THEN 'Afternoon'
     WHEN transaction_time BETWEEN '17:00:00' AND '19:59:59' THEN 'Evening'
     ELSE 'Night'
   END AS time_bucket,
    COUNT(TRANSACTION_ID) AS Total_transactions
   FROM retails_casestudy.sales.brightcoffee
   GROUP BY ALL;

   
  

 SELECT
  --- transaction_time,
   ---product_category,
   CASE
     WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
     WHEN transaction_time BETWEEN '02:00:00' AND '16:59:59' THEN 'Afternoon'
     WHEN transaction_time BETWEEN '17:00:00' AND '19:59:59' THEN 'Evening'
     ELSE 'Night'
   END AS time_bucket,
   SUM(transaction_qty * (CAST(REPLACE(unit_price,',','.') AS DECIMAL(10,2))))AS Total_Amount
   FROM retails_casestudy.sales.brightcoffee
   GROUP BY ALL;


--- 8. Date extraction (Month name,month id,day name )

SELECT  
  transaction_date,
  MONTHNAME(transaction_date) AS month_name,
  MONTH(transaction_date) AS month_number,
  DATE_FORMAT(transaction_date, 'yyyy-MM') AS month,
  DAYNAME(transaction_date),
  DAYOFWEEK(transaction_date)
FROM retails_casestudy.sales.brightcoffee;

------------------------------------------------------------------------------------------------------------------------


--- COMBINE ALL THE CODES:

 SELECT
  transaction_id,
  transaction_date,
  YEAR(transaction_date) AS year,
  MONTHNAME(transaction_date) AS month_name,
  MONTH(transaction_date) AS month_number,
  DATE_FORMAT(transaction_date, 'yyyy-MM') AS month,
  DAYNAME(transaction_date),
  DAYOFWEEK(transaction_date),
  product_category,
   product_type,
   product_detail,
   store_location,
   CASE
     WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
     WHEN transaction_time BETWEEN '02:00:00' AND '16:59:59' THEN 'Afternoon'
     WHEN transaction_time BETWEEN '17:00:00' AND '19:59:59' THEN 'Evening'
     ELSE 'Night'
   END AS time_bucket,
    COUNT(TRANSACTION_ID) AS Total_transactions,
    SUM(transaction_qty) AS Total_units_sold,
    SUM(transaction_qty * (CAST(REPLACE(unit_price,',','.') AS DECIMAL(10,2))))AS Total_Amount
   FROM retails_casestudy.sales.brightcoffee
   GROUP BY ALL;
