-- Object: Table public.Products    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

-- Create the table with primary key
CREATE TABLE public.Products (
    ProductID SERIAL NOT NULL,  -- SERIAL replaces IDENTITY(1,1)
    ProductName VARCHAR(40) NOT NULL,  -- VARCHAR replaces NVARCHAR
    SupplierID INT NULL,
    CategoryID INT NULL,
    QuantityPerUnit VARCHAR(20) NULL,
    UnitPrice NUMERIC(19,4) NULL DEFAULT 0,  -- NUMERIC replaces MONEY
    UnitsInStock SMALLINT NULL DEFAULT 0,
    UnitsOnOrder SMALLINT NULL DEFAULT 0,
    ReorderLevel SMALLINT NULL DEFAULT 0,
    Discontinued BOOLEAN NOT NULL DEFAULT FALSE,  -- BOOLEAN replaces BIT
    CONSTRAINT PK_Products PRIMARY KEY (ProductID)
);

-- Create indexes for better query performance
CREATE INDEX idx_products_categoriesproducts ON public.Products (CategoryID);
CREATE INDEX idx_products_categoryid ON public.Products (CategoryID);
CREATE INDEX idx_products_productname ON public.Products (ProductName);
CREATE INDEX idx_products_supplierid ON public.Products (SupplierID);
CREATE INDEX idx_products_suppliersproducts ON public.Products (SupplierID);

-- Add foreign key constraints
ALTER TABLE public.Products
    ADD CONSTRAINT FK_Products_Categories 
    FOREIGN KEY (CategoryID) REFERENCES public.Categories (CategoryID);

ALTER TABLE public.Products
    ADD CONSTRAINT FK_Products_Suppliers 
    FOREIGN KEY (SupplierID) REFERENCES public.Suppliers (SupplierID);

-- Add check constraints
ALTER TABLE public.Products
    ADD CONSTRAINT CK_Products_UnitPrice CHECK (UnitPrice >= 0);

ALTER TABLE public.Products
    ADD CONSTRAINT CK_ReorderLevel CHECK (ReorderLevel >= 0);

ALTER TABLE public.Products
    ADD CONSTRAINT CK_UnitsInStock CHECK (UnitsInStock >= 0);

ALTER TABLE public.Products
    ADD CONSTRAINT CK_UnitsOnOrder CHECK (UnitsOnOrder >= 0);

-- Add table and column comments
COMMENT ON TABLE public.Products IS 'Products information';
COMMENT ON COLUMN public.Products.ProductID IS 'Primary key for products';
COMMENT ON COLUMN public.Products.ProductName IS 'Name of product';
COMMENT ON COLUMN public.Products.SupplierID IS 'Supplier identifier, references Suppliers table';
COMMENT ON COLUMN public.Products.CategoryID IS 'Category identifier, references Categories table';
COMMENT ON COLUMN public.Products.Discontinued IS 'Flag indicating if product is discontinued';
