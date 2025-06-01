-- Object: View public."Customer_and_Suppliers_by_City"    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE VIEW public."Customer_and_Suppliers_by_City" AS
SELECT City, CompanyName, ContactName, 'Customers' AS Relationship 
FROM public.Customers
UNION 
SELECT City, CompanyName, ContactName, 'Suppliers' AS Relationship
FROM public.Suppliers;

-- Note: In PostgreSQL, ORDER BY in views is not supported directly
-- If ordering is needed, it should be done in the query using this view

-- Add view comment
COMMENT ON VIEW public."Customer_and_Suppliers_by_City" IS 'Combined list of customers and suppliers organized by city';
