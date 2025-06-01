-- Object: View public."Sales_by_Category"    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE VIEW public."Sales_by_Category" AS
SELECT Categories.CategoryID, 
       Categories.CategoryName, 
       Products.ProductName, 
       SUM("Order_Details_Extended".ExtendedPrice) AS ProductSales
FROM Categories 
INNER JOIN (
    Products 
    INNER JOIN (
        Orders 
        INNER JOIN "Order_Details_Extended" ON Orders.OrderID = "Order_Details_Extended".OrderID
    ) ON Products.ProductID = "Order_Details_Extended".ProductID
) ON Categories.CategoryID = Products.CategoryID
WHERE Orders.OrderDate BETWEEN '1997-01-01' AND '1997-12-31'
GROUP BY Categories.CategoryID, Categories.CategoryName, Products.ProductName;

-- Note: In PostgreSQL, ORDER BY in views is not supported directly
-- If ordering is needed, it should be done in the query using this view

-- Add view comment
COMMENT ON VIEW public."Sales_by_Category" IS 'Product sales by category for 1997';
