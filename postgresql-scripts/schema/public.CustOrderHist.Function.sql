-- Object: Function public.CustOrderHist    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE FUNCTION public.CustOrderHist(customer_id CHAR(5))
RETURNS TABLE (
    ProductName VARCHAR(40),
    Total BIGINT
) 
AS $$
BEGIN
    RETURN QUERY
    SELECT P.ProductName, SUM(OD.Quantity) AS Total
    FROM public.Products P, 
         public."Order_Details" OD, 
         public.Orders O, 
         public.Customers C
    WHERE C.CustomerID = customer_id
    AND C.CustomerID = O.CustomerID 
    AND O.OrderID = OD.OrderID 
    AND OD.ProductID = P.ProductID
    GROUP BY P.ProductName;
END;
$$ LANGUAGE plpgsql;

-- Add function comment
COMMENT ON FUNCTION public.CustOrderHist(CHAR(5)) IS 'Returns product order history for a specific customer';
