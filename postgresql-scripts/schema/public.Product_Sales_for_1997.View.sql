-- Object: View public."Product_Sales_for_1997"    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE VIEW public."Product_Sales_for_1997" AS
SELECT Categories.CategoryName, 
       Products.ProductName, 
       SUM("Order_Details".UnitPrice * "Order_Details".Quantity * (1 - "Order_Details".Discount)) AS ProductSales
FROM (Categories 
      INNER JOIN Products ON Categories.CategoryID = Products.CategoryID) 
INNER JOIN (Orders 
            INNER JOIN "Order_Details" ON Orders.OrderID = "Order_Details".OrderID) 
ON Products.ProductID = "Order_Details".ProductID
WHERE Orders.ShippedDate BETWEEN '1997-01-01' AND '1997-12-31'
GROUP BY Categories.CategoryName, Products.ProductName;

-- Add view comment
COMMENT ON VIEW public."Product_Sales_for_1997" IS 'Product sales totals for calendar year 1997';
