-- Object: View public."Products_by_Category"    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE VIEW public."Products_by_Category" AS
SELECT Categories.CategoryName, 
       Products.ProductName, 
       Products.QuantityPerUnit, 
       Products.UnitsInStock, 
       Products.Discontinued
FROM public.Categories 
INNER JOIN public.Products ON Categories.CategoryID = Products.CategoryID
WHERE Products.Discontinued = FALSE;

-- Note: In PostgreSQL, ORDER BY in views is not supported directly
-- If ordering is needed, it should be done in the query using this view

-- Add view comment
COMMENT ON VIEW public."Products_by_Category" IS 'Active products organized by category';
