-- Object: Table public.Employees    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

-- Create the table with primary key
CREATE TABLE public.Employees (
    EmployeeID SERIAL NOT NULL,  -- SERIAL replaces IDENTITY(1,1)
    LastName VARCHAR(20) NOT NULL,  -- VARCHAR replaces NVARCHAR
    FirstName VARCHAR(10) NOT NULL,
    Title VARCHAR(30) NULL,
    TitleOfCourtesy VARCHAR(25) NULL,
    BirthDate TIMESTAMP NULL,  -- TIMESTAMP replaces DATETIME
    HireDate TIMESTAMP NULL,
    Address VARCHAR(60) NULL,
    City VARCHAR(15) NULL,
    Region VARCHAR(15) NULL,
    PostalCode VARCHAR(10) NULL,
    Country VARCHAR(15) NULL,
    HomePhone VARCHAR(24) NULL,
    Extension VARCHAR(4) NULL,
    Photo BYTEA NULL,  -- BYTEA replaces IMAGE
    Notes TEXT NULL,  -- TEXT replaces NTEXT
    ReportsTo INT NULL,
    PhotoPath VARCHAR(255) NULL,
    CONSTRAINT PK_Employees PRIMARY KEY (EmployeeID)
);

-- Create indexes for better query performance
CREATE INDEX idx_employees_lastname ON public.Employees (LastName);
CREATE INDEX idx_employees_postalcode ON public.Employees (PostalCode);

-- Add self-referencing foreign key for reporting structure
ALTER TABLE public.Employees
    ADD CONSTRAINT FK_Employees_Employees 
    FOREIGN KEY (ReportsTo) REFERENCES public.Employees (EmployeeID);

-- Add check constraint for birth date
ALTER TABLE public.Employees
    ADD CONSTRAINT CK_Birthdate CHECK (BirthDate < CURRENT_TIMESTAMP);

-- Add table and column comments
COMMENT ON TABLE public.Employees IS 'Employee information including personal details';
COMMENT ON COLUMN public.Employees.EmployeeID IS 'Primary key for employees';
COMMENT ON COLUMN public.Employees.LastName IS 'Last name of employee';
COMMENT ON COLUMN public.Employees.FirstName IS 'First name of employee';
COMMENT ON COLUMN public.Employees.ReportsTo IS 'Employee ID of employee''s manager';
