-- Object: View public."Orders_Qry"    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE VIEW public."Orders_Qry" AS
SELECT Orders.OrderID, Orders.CustomerID, Orders.EmployeeID, Orders.OrderDate, Orders.RequiredDate, 
    Orders.ShippedDate, Orders.ShipVia, Orders.Freight, Orders.ShipName, Orders.ShipAddress, Orders.ShipCity, 
    Orders.ShipRegion, Orders.ShipPostalCode, Orders.ShipCountry, 
    Customers.CompanyName, Customers.Address, Customers.City, Customers.Region, Customers.PostalCode, Customers.Country
FROM public.Customers 
INNER JOIN public.Orders ON Customers.CustomerID = Orders.CustomerID;

-- Add view comment
COMMENT ON VIEW public."Orders_Qry" IS 'Orders joined with customer information';
