# SQL Server to PostgreSQL Data Type Mapping

This document outlines the data type mappings used in the migration from SQL Server to PostgreSQL for the Northwind database.

## Simple Data Type Mappings

| SQL Server Data Type | PostgreSQL Data Type | Notes |
|---------------------|---------------------|-------|
| `bit` | `boolean` | `0` becomes `FALSE`, `1` becomes `TRUE` |
| `tinyint` | `smallint` | PostgreSQL doesn't have an unsigned 1-byte integer |
| `smallint` | `smallint` | 2-byte integer |
| `int` | `integer` | 4-byte integer |
| `bigint` | `bigint` | 8-byte integer |
| `decimal(p,s)` | `numeric(p,s)` | Exact numeric with precision and scale |
| `numeric(p,s)` | `numeric(p,s)` | Exact numeric with precision and scale |
| `money` | `numeric(19,4)` | PostgreSQL has no direct money type with currency symbols |
| `smallmoney` | `numeric(10,4)` | Smaller precision monetary values |
| `float(n)` | `double precision` | 8-byte floating-point number |
| `real` | `real` | 4-byte floating-point number |
| `datetime` | `timestamp` | Date and time without time zone |
| `datetime2` | `timestamp` | More precise date and time |
| `smalldatetime` | `timestamp` | Less precise date and time |
| `date` | `date` | Date only |
| `time` | `time` | Time only |
| `datetimeoffset` | `timestamp with time zone` | Date and time with time zone |
| `char(n)` | `char(n)` | Fixed-length character string |
| `varchar(n)` | `varchar(n)` | Variable-length character string |
| `nchar(n)` | `char(n)` | In PostgreSQL, all character types are Unicode |
| `nvarchar(n)` | `varchar(n)` | In PostgreSQL, all character types are Unicode |
| `text` | `text` | Variable unlimited length |
| `ntext` | `text` | In PostgreSQL, all text types are Unicode |
| `binary(n)` | `bytea` | Fixed-length binary data |
| `varbinary(n)` | `bytea` | Variable-length binary data |
| `image` | `bytea` | Variable unlimited length binary data |
| `uniqueidentifier` | `uuid` | Universally unique identifier |
| `xml` | `xml` | XML data type |

## Special Cases

### Identity Columns
SQL Server `IDENTITY` columns have been replaced with PostgreSQL `SERIAL` data type, which automatically creates a sequence and sets it as the default value for the column.

```sql
-- SQL Server
[ID] [int] IDENTITY(1,1) NOT NULL

-- PostgreSQL
ID SERIAL NOT NULL
```

### Default Values
Default constraints have been directly incorporated into column definitions:

```sql
-- SQL Server
[Discontinued] [bit] NOT NULL
ALTER TABLE [dbo].[Products] ADD CONSTRAINT [DF_Products_Discontinued] DEFAULT ((0)) FOR [Discontinued]

-- PostgreSQL
Discontinued BOOLEAN NOT NULL DEFAULT FALSE
```

### Check Constraints
Check constraints have been directly converted:

```sql
-- SQL Server
ALTER TABLE [dbo].[Products] WITH NOCHECK ADD CONSTRAINT [CK_Products_UnitPrice] CHECK (([UnitPrice]>=(0)))

-- PostgreSQL
ALTER TABLE public.Products ADD CONSTRAINT CK_Products_UnitPrice CHECK (UnitPrice >= 0)
```

### String Concatenation
String concatenation operator has been changed from `+` to `||`:

```sql
-- SQL Server
(FirstName + ' ' + LastName) AS FullName

-- PostgreSQL
(FirstName || ' ' || LastName) AS FullName
```

### Stored Procedures
SQL Server stored procedures have been converted to PostgreSQL functions that return either a scalar value or a table:

```sql
-- SQL Server stored procedure
CREATE PROCEDURE [dbo].[CustOrderHist] @CustomerID nchar(5)
AS
SELECT ProductName, Total=SUM(Quantity)
FROM Products P, [Order Details] OD, Orders O, Customers C
WHERE C.CustomerID = @CustomerID
AND C.CustomerID = O.CustomerID AND O.OrderID = OD.OrderID AND OD.ProductID = P.ProductID
GROUP BY ProductName

-- PostgreSQL function
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
```
