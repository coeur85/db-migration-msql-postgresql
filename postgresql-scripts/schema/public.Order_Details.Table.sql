-- Object: Table public."Order_Details"    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

-- Create the table with primary key (using underscores instead of spaces for PostgreSQL naming)
CREATE TABLE public."Order_Details" (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    UnitPrice NUMERIC(19,4) NOT NULL DEFAULT 0,  -- NUMERIC replaces MONEY
    Quantity SMALLINT NOT NULL DEFAULT 1,
    Discount REAL NOT NULL DEFAULT 0,
    CONSTRAINT PK_Order_Details PRIMARY KEY (OrderID, ProductID)
);

-- Create indexes for better query performance
CREATE INDEX idx_order_details_orderid ON public."Order_Details" (OrderID);
CREATE INDEX idx_order_details_ordersorder ON public."Order_Details" (OrderID);
CREATE INDEX idx_order_details_productid ON public."Order_Details" (ProductID); 
CREATE INDEX idx_order_details_productsorder ON public."Order_Details" (ProductID);

-- Add foreign key constraints
ALTER TABLE public."Order_Details"
    ADD CONSTRAINT FK_Order_Details_Orders 
    FOREIGN KEY (OrderID) REFERENCES public.Orders (OrderID);

ALTER TABLE public."Order_Details"
    ADD CONSTRAINT FK_Order_Details_Products 
    FOREIGN KEY (ProductID) REFERENCES public.Products (ProductID);

-- Add check constraints
ALTER TABLE public."Order_Details"
    ADD CONSTRAINT CK_Discount CHECK (Discount >= 0 AND Discount <= 1);

ALTER TABLE public."Order_Details"
    ADD CONSTRAINT CK_Quantity CHECK (Quantity > 0);

ALTER TABLE public."Order_Details"
    ADD CONSTRAINT CK_UnitPrice CHECK (UnitPrice >= 0);

-- Add table and column comments
COMMENT ON TABLE public."Order_Details" IS 'Line items for each order';
COMMENT ON COLUMN public."Order_Details".OrderID IS 'Order identifier, references Orders table';
COMMENT ON COLUMN public."Order_Details".ProductID IS 'Product identifier, references Products table';
COMMENT ON COLUMN public."Order_Details".UnitPrice IS 'Unit price of product at time of order';
COMMENT ON COLUMN public."Order_Details".Quantity IS 'Number of units ordered';
COMMENT ON COLUMN public."Order_Details".Discount IS 'Discount applied to this line item (0-1)';
