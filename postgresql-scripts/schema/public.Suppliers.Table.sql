-- Object: Table public.Suppliers    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

-- Create the table with primary key
CREATE TABLE public.Suppliers (
    SupplierID SERIAL NOT NULL,  -- SERIAL replaces IDENTITY(1,1)
    CompanyName VARCHAR(40) NOT NULL,  -- VARCHAR replaces NVARCHAR
    ContactName VARCHAR(30) NULL,
    ContactTitle VARCHAR(30) NULL,
    Address VARCHAR(60) NULL,
    City VARCHAR(15) NULL,
    Region VARCHAR(15) NULL,
    PostalCode VARCHAR(10) NULL,
    Country VARCHAR(15) NULL,
    Phone VARCHAR(24) NULL,
    Fax VARCHAR(24) NULL,
    HomePage TEXT NULL,  -- TEXT replaces NTEXT
    CONSTRAINT PK_Suppliers PRIMARY KEY (SupplierID)
);

-- Create indexes for better query performance
CREATE INDEX idx_suppliers_companyname ON public.Suppliers (CompanyName);
CREATE INDEX idx_suppliers_postalcode ON public.Suppliers (PostalCode);

-- Add table and column comments
COMMENT ON TABLE public.Suppliers IS 'Companies that supply products to Northwind';
COMMENT ON COLUMN public.Suppliers.SupplierID IS 'Primary key for suppliers';
COMMENT ON COLUMN public.Suppliers.CompanyName IS 'Name of the supplier company';
COMMENT ON COLUMN public.Suppliers.ContactName IS 'Name of the contact person';
COMMENT ON COLUMN public.Suppliers.ContactTitle IS 'Title of the contact person';
COMMENT ON COLUMN public.Suppliers.HomePage IS 'Supplier website or other text information';
