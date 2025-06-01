-- Object: Table public.Orders    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

-- Create the table with primary key
CREATE TABLE public.Orders (
    OrderID SERIAL NOT NULL,  -- SERIAL replaces IDENTITY(1,1)
    CustomerID CHAR(5) NULL,  -- CHAR replaces NCHAR
    EmployeeID INT NULL,
    OrderDate TIMESTAMP NULL,  -- TIMESTAMP replaces DATETIME
    RequiredDate TIMESTAMP NULL,
    ShippedDate TIMESTAMP NULL,
    ShipVia INT NULL,
    Freight NUMERIC(19,4) DEFAULT 0,  -- NUMERIC replaces MONEY
    ShipName VARCHAR(40) NULL,  -- VARCHAR replaces NVARCHAR
    ShipAddress VARCHAR(60) NULL,
    ShipCity VARCHAR(15) NULL,
    ShipRegion VARCHAR(15) NULL,
    ShipPostalCode VARCHAR(10) NULL,
    ShipCountry VARCHAR(15) NULL,
    CONSTRAINT PK_Orders PRIMARY KEY (OrderID)
);

-- Create indexes for better query performance
CREATE INDEX idx_orders_customerid ON public.Orders (CustomerID);
CREATE INDEX idx_orders_customersorders ON public.Orders (CustomerID);
CREATE INDEX idx_orders_employeeid ON public.Orders (EmployeeID);
CREATE INDEX idx_orders_employeesorders ON public.Orders (EmployeeID);
CREATE INDEX idx_orders_orderdate ON public.Orders (OrderDate);
CREATE INDEX idx_orders_shippeddate ON public.Orders (ShippedDate);
CREATE INDEX idx_orders_shippersorders ON public.Orders (ShipVia);
CREATE INDEX idx_orders_shippostalcode ON public.Orders (ShipPostalCode);

-- Add foreign key constraints
ALTER TABLE public.Orders
    ADD CONSTRAINT FK_Orders_Customers 
    FOREIGN KEY (CustomerID) REFERENCES public.Customers (CustomerID);

ALTER TABLE public.Orders
    ADD CONSTRAINT FK_Orders_Employees 
    FOREIGN KEY (EmployeeID) REFERENCES public.Employees (EmployeeID);

ALTER TABLE public.Orders
    ADD CONSTRAINT FK_Orders_Shippers 
    FOREIGN KEY (ShipVia) REFERENCES public.Shippers (ShipperID);

-- Add table and column comments
COMMENT ON TABLE public.Orders IS 'Customer orders information';
COMMENT ON COLUMN public.Orders.OrderID IS 'Primary key for orders';
COMMENT ON COLUMN public.Orders.CustomerID IS 'Customer identifier, references Customers table';
COMMENT ON COLUMN public.Orders.EmployeeID IS 'Employee identifier, references Employees table';
COMMENT ON COLUMN public.Orders.ShipVia IS 'Shipper identifier, references Shippers table';
COMMENT ON COLUMN public.Orders.Freight IS 'Shipping cost';
