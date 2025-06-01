-- Object: Table public.Shippers    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

-- Create the table with primary key
CREATE TABLE public.Shippers (
    ShipperID SERIAL NOT NULL,  -- SERIAL replaces IDENTITY(1,1)
    CompanyName VARCHAR(40) NOT NULL,  -- VARCHAR replaces NVARCHAR
    Phone VARCHAR(24) NULL,
    CONSTRAINT PK_Shippers PRIMARY KEY (ShipperID)
);

-- Add table and column comments
COMMENT ON TABLE public.Shippers IS 'Companies responsible for shipping orders to customers';
COMMENT ON COLUMN public.Shippers.ShipperID IS 'Primary key for shippers';
COMMENT ON COLUMN public.Shippers.CompanyName IS 'Name of the shipping company';
COMMENT ON COLUMN public.Shippers.Phone IS 'Phone number of the shipping company';
