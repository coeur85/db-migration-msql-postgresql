-- Object: View public."Summary_of_Sales_by_Year"    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE VIEW public."Summary_of_Sales_by_Year" AS
SELECT Orders.ShippedDate, 
       Orders.OrderID, 
       "Order_Subtotals".Subtotal
FROM public.Orders 
INNER JOIN public."Order_Subtotals" ON Orders.OrderID = "Order_Subtotals".OrderID
WHERE Orders.ShippedDate IS NOT NULL;

-- Note: In PostgreSQL, ORDER BY in views is not supported directly
-- If ordering is needed, it should be done in the query using this view

-- Add view comment
COMMENT ON VIEW public."Summary_of_Sales_by_Year" IS 'Order subtotals grouped by year based on shipped date';
