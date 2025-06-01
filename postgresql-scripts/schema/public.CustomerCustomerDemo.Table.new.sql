-- Object:  Table public.CustomerCustomerDemo    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

-- Create the table with primary key
CREATE TABLE public.CustomerCustomerDemo (
    CustomerID CHAR(5) NOT NULL,
    CustomerTypeID CHAR(10) NOT NULL,
    CONSTRAINT PK_CustomerCustomerDemo PRIMARY KEY (CustomerID, CustomerTypeID)
);

-- Add foreign key constraints
ALTER TABLE public.CustomerCustomerDemo
    ADD CONSTRAINT FK_CustomerCustomerDemo 
    FOREIGN KEY (CustomerTypeID) REFERENCES public.CustomerDemographics (CustomerTypeID);

ALTER TABLE public.CustomerCustomerDemo
    ADD CONSTRAINT FK_CustomerCustomerDemo_Customers 
    FOREIGN KEY (CustomerID) REFERENCES public.Customers (CustomerID);

COMMENT ON TABLE public.CustomerCustomerDemo IS 'Many-to-many relationship between Customers and CustomerDemographics';
