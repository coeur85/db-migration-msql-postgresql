-- Object: Table public.EmployeeTerritories    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

-- Create the table with primary key
CREATE TABLE public.EmployeeTerritories (
    EmployeeID INT NOT NULL,
    TerritoryID VARCHAR(20) NOT NULL,  -- VARCHAR replaces NVARCHAR
    CONSTRAINT PK_EmployeeTerritories PRIMARY KEY (EmployeeID, TerritoryID)
);

-- Add foreign key constraints
ALTER TABLE public.EmployeeTerritories
    ADD CONSTRAINT FK_EmployeeTerritories_Employees 
    FOREIGN KEY (EmployeeID) REFERENCES public.Employees (EmployeeID);

ALTER TABLE public.EmployeeTerritories
    ADD CONSTRAINT FK_EmployeeTerritories_Territories 
    FOREIGN KEY (TerritoryID) REFERENCES public.Territories (TerritoryID);

-- Add table comments
COMMENT ON TABLE public.EmployeeTerritories IS 'Junction table linking employees to their assigned territories';
COMMENT ON COLUMN public.EmployeeTerritories.EmployeeID IS 'Employee identifier, references Employees table';
COMMENT ON COLUMN public.EmployeeTerritories.TerritoryID IS 'Territory identifier, references Territories table';
