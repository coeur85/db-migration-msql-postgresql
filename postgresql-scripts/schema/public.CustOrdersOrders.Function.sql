-- Object: Function public.CustOrdersOrders    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE FUNCTION public.CustOrdersOrders(customer_id CHAR(5))
RETURNS TABLE (
    OrderID INTEGER,
    OrderDate TIMESTAMP,
    RequiredDate TIMESTAMP,
    ShippedDate TIMESTAMP
)
AS $$
BEGIN
    RETURN QUERY
    SELECT O.OrderID, 
           O.OrderDate,
           O.RequiredDate,
           O.ShippedDate
    FROM public.Orders O
    WHERE O.CustomerID = customer_id
    ORDER BY O.OrderID;
END;
$$ LANGUAGE plpgsql;

-- Add function comment
COMMENT ON FUNCTION public.CustOrdersOrders(CHAR(5)) IS 'Returns all orders for a specific customer';
