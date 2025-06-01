-- Object: Table public.CustomerDemographics    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

-- Create the table with primary key
CREATE TABLE public.CustomerDemographics (
    CustomerTypeID CHAR(10) NOT NULL,
    CustomerDesc TEXT NULL,
    CONSTRAINT PK_CustomerDemographics PRIMARY KEY (CustomerTypeID)
);

COMMENT ON TABLE public.CustomerDemographics IS 'Contains demographic categories for customer segmentation';
