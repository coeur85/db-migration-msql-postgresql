-- Script to validate the PostgreSQL Northwind database structure after migration
-- This script doesn't modify any data or structure

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

-- Table row counts (this will only work after data is imported)
SELECT 'Categories' AS table_name, COUNT(*) AS row_count FROM public."Categories"
UNION ALL
SELECT 'Customers' AS table_name, COUNT(*) AS row_count FROM public."Customers"
UNION ALL
SELECT 'Employees' AS table_name, COUNT(*) AS row_count FROM public."Employees"
UNION ALL
SELECT 'Order_Details' AS table_name, COUNT(*) AS row_count FROM public."Order_Details"
UNION ALL
SELECT 'Orders' AS table_name, COUNT(*) AS row_count FROM public."Orders"
UNION ALL
SELECT 'Products' AS table_name, COUNT(*) AS row_count FROM public."Products"
UNION ALL
SELECT 'Shippers' AS table_name, COUNT(*) AS row_count FROM public."Shippers"
UNION ALL
SELECT 'Suppliers' AS table_name, COUNT(*) AS row_count FROM public."Suppliers";

-- Validate foreign key relationships
SELECT
    tc.constraint_name,
    tc.table_schema AS schema_name,
    tc.table_name,
    kcu.column_name,
    ccu.table_schema AS foreign_schema_name,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name
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

-- Check for any errors in views or functions
SELECT 
    routine_schema,
    routine_name,
    routine_type,
    data_type,
    is_deterministic
FROM information_schema.routines
WHERE routine_schema = 'public'
ORDER BY routine_name;

-- Run a few queries to test functionality
SELECT * FROM public."Alphabetical_list_of_products" LIMIT 5;
SELECT * FROM public."Ten_Most_Expensive_Products"() LIMIT 5;
SELECT * FROM public."Customer_and_Suppliers_by_City" LIMIT 5;

-- End of validation script
