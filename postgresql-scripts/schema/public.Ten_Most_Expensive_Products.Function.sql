-- Object: Function public.Ten_Most_Expensive_Products    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE FUNCTION public.Ten_Most_Expensive_Products()
RETURNS TABLE (
    TenMostExpensiveProducts VARCHAR(40),
    UnitPrice NUMERIC(19,4)
) 
AS $$
BEGIN
    RETURN QUERY
    SELECT Products.ProductName AS TenMostExpensiveProducts, Products.UnitPrice
    FROM public.Products
    ORDER BY Products.UnitPrice DESC
    LIMIT 10;
END;
$$ LANGUAGE plpgsql;

-- Add function comment
COMMENT ON FUNCTION public.Ten_Most_Expensive_Products() IS 'Returns the 10 most expensive products';
