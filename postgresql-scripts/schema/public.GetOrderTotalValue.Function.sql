-- Object: Function public.GetOrderTotalValue    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE FUNCTION public.GetOrderTotalValue(order_id INTEGER)
RETURNS NUMERIC(18,4)
AS $$
DECLARE
    output_value NUMERIC(18,4);
BEGIN
    SELECT 
        SUM((od.UnitPrice - od.Discount) * od.Quantity) INTO output_value
    FROM
        public."Order_Details" od
    WHERE
        OrderID = order_id;

    RETURN COALESCE(output_value, 0);
END;
$$ LANGUAGE plpgsql;

-- Add function comment
COMMENT ON FUNCTION public.GetOrderTotalValue(INTEGER) IS 'Calculates the total value of a specific order';
