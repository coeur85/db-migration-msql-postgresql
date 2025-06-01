-- Object: View public."Alphabetical_list_of_products"    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE VIEW public."Alphabetical_list_of_products" AS
SELECT Products.ProductID,
       Products.ProductName,
       Products.SupplierID,
       Products.CategoryID,
       Products.QuantityPerUnit,
       Products.UnitPrice,
       Products.UnitsInStock,
       Products.UnitsOnOrder,
       Products.ReorderLevel,
       Products.Discontinued,
       Categories.CategoryName
FROM public.Categories 
INNER JOIN public.Products ON Categories.CategoryID = Products.CategoryID
WHERE Products.Discontinued = FALSE;

-- Add view comment
COMMENT ON VIEW public."Alphabetical_list_of_products" IS 'List of all active products with their category names';
