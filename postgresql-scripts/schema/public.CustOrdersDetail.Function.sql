-- Object: Function public.CustOrdersDetail    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE FUNCTION public.CustOrdersDetail(order_id INTEGER)
RETURNS TABLE (
    ProductName VARCHAR(40),
    UnitPrice NUMERIC(19,2),
    Quantity SMALLINT,
    Discount INTEGER,
    ExtendedPrice NUMERIC(19,2)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT P.ProductName,
           ROUND(Od.UnitPrice::numeric, 2) AS UnitPrice,
           Od.Quantity,
           (Od.Discount * 100)::integer AS Discount,
           ROUND((Od.Quantity * (1 - Od.Discount) * Od.UnitPrice)::numeric, 2) AS ExtendedPrice
    FROM public.Products P, public."Order_Details" Od
    WHERE Od.ProductID = P.ProductID AND Od.OrderID = order_id;
END;
$$ LANGUAGE plpgsql;

-- Add function comment
COMMENT ON FUNCTION public.CustOrdersDetail(INTEGER) IS 'Returns detailed product information for a specific order';
