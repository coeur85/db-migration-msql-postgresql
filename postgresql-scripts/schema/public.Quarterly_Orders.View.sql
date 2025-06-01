-- Object: View public."Quarterly_Orders"    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE VIEW public."Quarterly_Orders" AS
SELECT DISTINCT Customers.CustomerID, Customers.CompanyName, Customers.City, Customers.Country
FROM public.Customers 
RIGHT JOIN public.Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderDate BETWEEN '1997-01-01' AND '1997-12-31';

-- Add view comment
COMMENT ON VIEW public."Quarterly_Orders" IS 'Customer orders for 1997 with company and location information';
