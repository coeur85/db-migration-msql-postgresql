-- Object: View public."Sales_Totals_by_Amount"    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE VIEW public."Sales_Totals_by_Amount" AS
SELECT "Order_Subtotals".Subtotal AS SaleAmount, 
       Orders.OrderID, 
       Customers.CompanyName, 
       Orders.ShippedDate
FROM public.Customers 
INNER JOIN (
    public.Orders 
    INNER JOIN public."Order_Subtotals" ON Orders.OrderID = "Order_Subtotals".OrderID
) ON Customers.CustomerID = Orders.CustomerID
WHERE ("Order_Subtotals".Subtotal > 2500) 
  AND (Orders.ShippedDate BETWEEN '1997-01-01' AND '1997-12-31');

-- Add view comment
COMMENT ON VIEW public."Sales_Totals_by_Amount" IS 'Large order sales totals for 1997';
