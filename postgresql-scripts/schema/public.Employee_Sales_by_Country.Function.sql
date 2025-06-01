-- Object: Function public.Employee_Sales_by_Country    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE FUNCTION public.Employee_Sales_by_Country(
    beginning_date TIMESTAMP,
    ending_date TIMESTAMP
)
RETURNS TABLE (
    Country VARCHAR(15),
    LastName VARCHAR(20),
    FirstName VARCHAR(10),
    ShippedDate TIMESTAMP,
    OrderID INTEGER,
    SaleAmount NUMERIC
)
AS $$
BEGIN
    RETURN QUERY
    SELECT E.Country, 
           E.LastName, 
           E.FirstName, 
           O.ShippedDate, 
           O.OrderID, 
           OS.Subtotal AS SaleAmount
    FROM public.Employees E 
    INNER JOIN (
        public.Orders O 
        INNER JOIN public."Order_Subtotals" OS ON O.OrderID = OS.OrderID
    ) ON E.EmployeeID = O.EmployeeID
    WHERE O.ShippedDate BETWEEN beginning_date AND ending_date;
END;
$$ LANGUAGE plpgsql;

-- Add function comment
COMMENT ON FUNCTION public.Employee_Sales_by_Country(TIMESTAMP, TIMESTAMP) IS 'Returns employee sales data for a specific date range grouped by country';
