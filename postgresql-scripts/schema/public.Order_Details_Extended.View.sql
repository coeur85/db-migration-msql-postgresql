-- Object: View public."Order_Details_Extended"    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE VIEW public."Order_Details_Extended" AS
SELECT "Order_Details".OrderID, 
       "Order_Details".ProductID, 
       Products.ProductName, 
       "Order_Details".UnitPrice, 
       "Order_Details".Quantity, 
       "Order_Details".Discount, 
       ("Order_Details".UnitPrice * "Order_Details".Quantity * (1 - "Order_Details".Discount)) AS ExtendedPrice
FROM public.Products 
INNER JOIN public."Order_Details" ON Products.ProductID = "Order_Details".ProductID;

-- Note: In PostgreSQL, ORDER BY in views is not supported directly
-- If ordering is needed, it should be done in the query using this view

-- Add view comment
COMMENT ON VIEW public."Order_Details_Extended" IS 'Extended order details with product names and calculated prices';
