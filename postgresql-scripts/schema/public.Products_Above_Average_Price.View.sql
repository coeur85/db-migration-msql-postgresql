-- Object: View public."Products_Above_Average_Price"    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE VIEW public."Products_Above_Average_Price" AS
SELECT Products.ProductName, Products.UnitPrice
FROM public.Products
WHERE Products.UnitPrice > (SELECT AVG(UnitPrice) FROM public.Products);

-- Note: In PostgreSQL, ORDER BY in views is not supported directly
-- If ordering is needed, it should be done in the query using this view

-- Add view comment
COMMENT ON VIEW public."Products_Above_Average_Price" IS 'Products with unit price higher than the average price of all products';
