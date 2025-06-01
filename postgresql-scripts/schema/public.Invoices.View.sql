-- Object: View public.Invoices    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE VIEW public.Invoices AS
SELECT Orders.ShipName, Orders.ShipAddress, Orders.ShipCity, Orders.ShipRegion, Orders.ShipPostalCode, 
    Orders.ShipCountry, Orders.CustomerID, Customers.CompanyName AS CustomerName, Customers.Address, Customers.City, 
    Customers.Region, Customers.PostalCode, Customers.Country, 
    (Employees.FirstName || ' ' || Employees.LastName) AS Salesperson,  -- || replaces + for string concatenation
    Orders.OrderID, Orders.OrderDate, Orders.RequiredDate, Orders.ShippedDate, Shippers.CompanyName AS ShipperName, 
    "Order_Details".ProductID, Products.ProductName, "Order_Details".UnitPrice, "Order_Details".Quantity, 
    "Order_Details".Discount, 
    ("Order_Details".UnitPrice * "Order_Details".Quantity * (1 - "Order_Details".Discount)) AS ExtendedPrice, Orders.Freight
FROM Shippers 
INNER JOIN (
    Products 
    INNER JOIN (
        (
            Employees 
            INNER JOIN (
                Customers 
                INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
            ) ON Employees.EmployeeID = Orders.EmployeeID
        ) 
        INNER JOIN "Order_Details" ON Orders.OrderID = "Order_Details".OrderID
    ) ON Products.ProductID = "Order_Details".ProductID
) ON Shippers.ShipperID = Orders.ShipVia;

-- Add view comment
COMMENT ON VIEW public.Invoices IS 'Detailed invoice information including customer, product, and shipping details';
