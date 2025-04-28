
/*===============================================================*/
     Checking [silver].[crm_cust_info]  
/*===============================================================*/


-- 1. silver.crm_cust_info
-- Quality Check 
-- A Primary Key must be unique and not null
-- Checking for NULLs or Duplicates in Primary Key

    SELECT cst_id, count(*) 
    FROM silver.crm_cust_info
    GROUP BY cst_id
    HAVING count(*) > 1 -- OR cst_id IS NULL 

-- Check for unwanted spaces in string values

SELECT cst_firstname 
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)  -- if condition is TRUE, then we have an issue

SELECT cst_gndr 
FROM silver.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr)   -- here we dont have any result, which means data quality is good !

-- Checking consistency of values in low cardinality columns 

SELECT 
DISTINCT --cst_marital_status,  
        cst_gndr
FROM silver.crm_cust_info 

select * FROM silver.crm_cust_info  


/*===============================================================*/
     Checking [silver].[crm_prd_info]  
/*===============================================================*/


--Check for nulls or Duplicates for Primary key

SELECT
    prd_id,  
    count(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING count(*) > 1

--Check for unwanted spaces

SELECT prd_nm
FROM silver.crm_prd_info
WHERE  prd_nm != TRIM(prd_nm)

--Check for NULLs or negative values for cost column

SELECT prd_cost
FROM silver.crm_prd_info
WHERE  prd_cost < 0 OR prd_cost IS NULL

-- Data Standardization & Consistency

SELECT DISTINCT prd_line
FROM silver.crm_prd_info

--Checkign dates and order in dates

SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

SELECT * FROM silver.crm_prd_info


/*===============================================================*/
     Checking [silver].[crm_sales_details]  
/*===============================================================*/

-- performing the Quality Check

-- CHecking invalid Date orders 

SELECT * 
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

 
 SELECT
sls_sales, 
sls_quantity, 
sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY 1,2,3 -- runnign this script we wanna check if we have any issue (0 rows retrived, no issue)
-- gde dolazimo do zakljukada data is following the buidnes rules, we are no having bad data 

--Last check 
select * FROM silver.crm_sales_details


/*===============================================================*/
     Checking [silver].[erp_cust_az12]  
/*===============================================================*/

-- Checking Data Quality
 --Identify Out of Range Dates 

SELECT DISTINCT
bdate
FROM silver.erp_cust_az12 
WHERE bdate < '1924-01-01' OR bdate > getdate()

-- Data Standardization & Consistency
SELECT DISTINCT gen
FROM silver.erp_cust_az12


/*===============================================================*/
     Checking [silver].[erp_loc_a101]  
/*===============================================================*/


-- Quality Check 

-- Data Standardization & Consistency

SELECT DISTINCT cntry
FROM silver.erp_loc_a101
ORDER BY cntry 

SELECT * FROM silver.erp_loc_a101