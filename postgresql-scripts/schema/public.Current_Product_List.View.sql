-- Object: View public."Current_Product_List"    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE VIEW public."Current_Product_List" AS
SELECT Product_List.ProductID, Product_List.ProductName
FROM public.Products AS Product_List
WHERE (Product_List.Discontinued = FALSE);  -- FALSE replaces 0 for boolean values

-- Note: In PostgreSQL, ORDER BY in views is not supported directly
-- If ordering is needed, it should be done in the query using this view

-- Add view comment
COMMENT ON VIEW public."Current_Product_List" IS 'List of all products that are not discontinued';
