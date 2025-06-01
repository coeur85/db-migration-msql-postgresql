-- Object: Function public.SalesByCategory    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

CREATE OR REPLACE FUNCTION public.SalesByCategory(
    category_name VARCHAR(15),
    ord_year VARCHAR(4) DEFAULT '1998'
)
RETURNS TABLE (
    ProductName VARCHAR(40),
    TotalPurchase NUMERIC
) 
AS $$
BEGIN
    -- Validate the year parameter
    IF ord_year NOT IN ('1996', '1997', '1998') THEN
        ord_year := '1998';
    END IF;

    RETURN QUERY
    SELECT P.ProductName,
        ROUND(SUM(OD.Quantity * (1-OD.Discount) * OD.UnitPrice), 0) AS TotalPurchase
    FROM public."Order_Details" OD
    JOIN public.Orders O ON OD.OrderID = O.OrderID
    JOIN public.Products P ON OD.ProductID = P.ProductID
    JOIN public.Categories C ON P.CategoryID = C.CategoryID
    WHERE C.CategoryName = category_name
        AND TO_CHAR(O.OrderDate, 'YYYY') = ord_year
    GROUP BY P.ProductName
    ORDER BY P.ProductName;
END;
$$ LANGUAGE plpgsql;

-- Add function comment
COMMENT ON FUNCTION public.SalesByCategory(VARCHAR, VARCHAR) IS 'Returns sales totals by product for a specified category and year';
