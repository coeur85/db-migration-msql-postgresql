-- Object: View public."Category_Sales_for_1997"    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE VIEW public."Category_Sales_for_1997" AS
SELECT "Product_Sales_for_1997".CategoryName, 
       SUM("Product_Sales_for_1997".ProductSales) AS CategorySales
FROM public."Product_Sales_for_1997"
GROUP BY "Product_Sales_for_1997".CategoryName;

-- Add view comment
COMMENT ON VIEW public."Category_Sales_for_1997" IS 'Sales totals by product category for 1997';
