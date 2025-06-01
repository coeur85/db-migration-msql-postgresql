-- Object: View public."Order_Subtotals"    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE VIEW public."Order_Subtotals" AS
SELECT "Order_Details".OrderID, 
       SUM(("Order_Details".UnitPrice * "Order_Details".Quantity * (1 - "Order_Details".Discount))) AS Subtotal
FROM public."Order_Details"
GROUP BY "Order_Details".OrderID;

-- Add view comment
COMMENT ON VIEW public."Order_Subtotals" IS 'Subtotals for each order based on line items';
