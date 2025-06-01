-- Object: Function public.Sales_by_Year    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE FUNCTION public.Sales_by_Year(
    beginning_date TIMESTAMP,
    ending_date TIMESTAMP
)
RETURNS TABLE (
    ShippedDate TIMESTAMP,
    OrderID INTEGER,
    Subtotal NUMERIC,
    Year VARCHAR(4)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT O.ShippedDate, 
           O.OrderID, 
           OS.Subtotal, 
           TO_CHAR(O.ShippedDate, 'YYYY') AS Year
    FROM public.Orders O 
    INNER JOIN public."Order_Subtotals" OS ON O.OrderID = OS.OrderID
    WHERE O.ShippedDate BETWEEN beginning_date AND ending_date;
END;
$$ LANGUAGE plpgsql;

-- Add function comment
COMMENT ON FUNCTION public.Sales_by_Year(TIMESTAMP, TIMESTAMP) IS 'Returns sales data grouped by year for a specific date range';
