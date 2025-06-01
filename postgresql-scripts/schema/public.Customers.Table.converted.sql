-- Object: Table public.Customers    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

-- Create the table with primary key
CREATE TABLE public.Customers (
    CustomerID CHAR(5) NOT NULL,
    CompanyName VARCHAR(40) NOT NULL,
    ContactName VARCHAR(30) NULL,
    ContactTitle VARCHAR(30) NULL,
    Address VARCHAR(60) NULL,
    City VARCHAR(15) NULL,
    Region VARCHAR(15) NULL,
    PostalCode VARCHAR(10) NULL,
    Country VARCHAR(15) NULL,
    Phone VARCHAR(24) NULL,
    Fax VARCHAR(24) NULL,
    CONSTRAINT PK_Customers PRIMARY KEY (CustomerID)
);

-- Create indexes for better query performance
CREATE INDEX idx_customers_city ON public.Customers (City);
CREATE INDEX idx_customers_companyname ON public.Customers (CompanyName);
CREATE INDEX idx_customers_postalcode ON public.Customers (PostalCode);
CREATE INDEX idx_customers_region ON public.Customers (Region);

COMMENT ON TABLE public.Customers IS 'Company/organization details for Northwind customers';
COMMENT ON COLUMN public.Customers.CustomerID IS 'Unique 5-character customer identifier';
COMMENT ON COLUMN public.Customers.CompanyName IS 'Name of the customer company';
