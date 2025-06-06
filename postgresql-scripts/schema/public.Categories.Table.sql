

CREATE TABLE "public"."Categories" (
    CategoryID SERIAL NOT NULL,  -- SERIAL replaces IDENTITY(1,1)
    CategoryName VARCHAR(15) NOT NULL,  -- VARCHAR replaces NVARCHAR
    Description TEXT NULL,  -- TEXT replaces NTEXT
    Picture BYTEA NULL,  -- BYTEA replaces IMAGE
    CONSTRAINT PK_Categories PRIMARY KEY (CategoryID)
);

-- Create index on CategoryName
CREATE INDEX idx_CategoryName ON "public"."Categories" (CategoryName);

-- COMMENT ON TABLE "public"."Categories" IS 'Migrated from SQL Server Northwind database';