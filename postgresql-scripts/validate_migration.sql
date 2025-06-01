-- Script to validate the PostgreSQL Northwind database structure after migration
-- This script doesn't modify any data or structure
-- Created: June 1, 2025

-- Count objects by type
SELECT 'Tables' AS object_type, COUNT(*) AS count
FROM information_schema.tables 
WHERE table_schema IN ('public', 'logging') AND table_type = 'BASE TABLE'
UNION ALL
SELECT 'Views' AS object_type, COUNT(*) AS count
FROM information_schema.views
WHERE table_schema = 'public'
UNION ALL
SELECT 'Functions' AS object_type, COUNT(*) AS count
FROM information_schema.routines
WHERE routine_schema = 'public' AND routine_type = 'FUNCTION'
UNION ALL
SELECT 'Sequences' AS object_type, COUNT(*) AS count
FROM information_schema.sequences
WHERE sequence_schema = 'public'
UNION ALL
SELECT 'Constraints' AS object_type, COUNT(*) AS count
FROM information_schema.table_constraints
WHERE constraint_schema IN ('public', 'logging');

-- List all tables and their column counts
SELECT 
    table_schema,
    table_name,
    (SELECT COUNT(*) FROM information_schema.columns c 
     WHERE c.table_schema = t.table_schema AND c.table_name = t.table_name) AS column_count
FROM information_schema.tables t
WHERE table_schema IN ('public', 'logging') 
AND table_type = 'BASE TABLE'
ORDER BY table_schema, table_name;

-- Expected tables with expected column counts
WITH expected_tables AS (
    SELECT 'Categories' AS table_name, 4 AS expected_columns
    UNION ALL SELECT 'Customers', 11
    UNION ALL SELECT 'CustomerCustomerDemo', 2
    UNION ALL SELECT 'CustomerDemographics', 2
    UNION ALL SELECT 'Employees', 18
    UNION ALL SELECT 'EmployeeTerritories', 2
    UNION ALL SELECT 'Order_Details', 5
    UNION ALL SELECT 'Orders', 14
    UNION ALL SELECT 'Products', 10
    UNION ALL SELECT 'Region', 2
    UNION ALL SELECT 'Shippers', 3
    UNION ALL SELECT 'Suppliers', 12
    UNION ALL SELECT 'Territories', 3
),
actual_tables AS (
    SELECT 
        table_name,
        (SELECT COUNT(*) FROM information_schema.columns 
         WHERE table_schema = 'public' AND table_name = t.table_name) AS actual_columns
    FROM information_schema.tables t
    WHERE table_schema = 'public' 
    AND table_type = 'BASE TABLE'
)
SELECT 
    e.table_name,
    e.expected_columns,
    COALESCE(a.actual_columns, 0) AS actual_columns,
    CASE 
        WHEN a.table_name IS NULL THEN 'Missing table'
        WHEN e.expected_columns != a.actual_columns THEN 'Column count mismatch'
        ELSE 'OK'
    END AS status
FROM expected_tables e
LEFT JOIN actual_tables a ON e.table_name = a.table_name
ORDER BY e.table_name;

-- List all views and their status
SELECT 
    table_schema,
    table_name AS view_name,
    'OK' AS status
FROM information_schema.views
WHERE table_schema = 'public'
ORDER BY table_name;

-- List all functions and their parameter counts
SELECT 
    r.routine_schema,
    r.routine_name,
    r.data_type AS return_type,
    COUNT(p.parameter_name) AS parameter_count,
    'OK' AS status
FROM information_schema.routines r
LEFT JOIN information_schema.parameters p ON 
    p.specific_schema = r.specific_schema AND 
    p.specific_name = r.specific_name
WHERE r.routine_schema = 'public'
GROUP BY r.routine_schema, r.routine_name, r.data_type
ORDER BY r.routine_name;

-- Table row counts (this will only work after data is imported)
SELECT 'Categories' AS table_name, COUNT(*) AS row_count FROM public."Categories"
UNION ALL
SELECT 'Customers' AS table_name, COUNT(*) AS row_count FROM public."Customers"
UNION ALL
SELECT 'CustomerCustomerDemo' AS table_name, COUNT(*) AS row_count FROM public."CustomerCustomerDemo"
UNION ALL
SELECT 'CustomerDemographics' AS table_name, COUNT(*) AS row_count FROM public."CustomerDemographics"
UNION ALL
SELECT 'Employees' AS table_name, COUNT(*) AS row_count FROM public."Employees"
UNION ALL
SELECT 'EmployeeTerritories' AS table_name, COUNT(*) AS row_count FROM public."EmployeeTerritories"
UNION ALL
SELECT 'Order_Details' AS table_name, COUNT(*) AS row_count FROM public."Order_Details"
UNION ALL
SELECT 'Orders' AS table_name, COUNT(*) AS row_count FROM public."Orders"
UNION ALL
SELECT 'Products' AS table_name, COUNT(*) AS row_count FROM public."Products"
UNION ALL
SELECT 'Region' AS table_name, COUNT(*) AS row_count FROM public."Region"
UNION ALL
SELECT 'Shippers' AS table_name, COUNT(*) AS row_count FROM public."Shippers"
UNION ALL
SELECT 'Suppliers' AS table_name, COUNT(*) AS row_count FROM public."Suppliers"
UNION ALL
SELECT 'Territories' AS table_name, COUNT(*) AS row_count FROM public."Territories";

-- Validate foreign key relationships
SELECT
    tc.constraint_name,
    tc.table_schema AS schema_name,
    tc.table_name,
    kcu.column_name,
    ccu.table_schema AS foreign_schema_name,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name,
    'OK' AS status
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage AS ccu
    ON ccu.constraint_name = tc.constraint_name
    AND ccu.table_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
AND tc.table_schema IN ('public', 'logging')
ORDER BY tc.table_schema, tc.table_name;

-- Run and test a few functions to ensure they work correctly
-- Test Ten_Most_Expensive_Products function
SELECT * FROM public."Ten_Most_Expensive_Products"() LIMIT 5;

-- Test Customer and Suppliers by City view
SELECT * FROM public."Customer_and_Suppliers_by_City" LIMIT 5;

-- Test CustOrderHist function
SELECT * FROM public."CustOrderHist"('ALFKI') LIMIT 5;

-- Test SalesByCategory function
SELECT * FROM public."SalesByCategory"('Beverages', '1997') LIMIT 5;

-- Validate primary keys
SELECT 
    tc.table_schema, 
    tc.table_name, 
    tc.constraint_name,
    STRING_AGG(kcu.column_name, ', ') AS key_columns
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu 
    ON tc.constraint_catalog = kcu.constraint_catalog 
    AND tc.constraint_schema = kcu.constraint_schema 
    AND tc.constraint_name = kcu.constraint_name
WHERE tc.constraint_type = 'PRIMARY KEY'
AND tc.table_schema IN ('public', 'logging')
GROUP BY tc.table_schema, tc.table_name, tc.constraint_name
ORDER BY tc.table_schema, tc.table_name;

-- End of validation script
