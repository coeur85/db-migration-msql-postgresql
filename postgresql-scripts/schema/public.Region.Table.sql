-- Object: Table public.Region    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

-- Create the table with primary key
CREATE TABLE public.Region (
    RegionID INT NOT NULL,
    RegionDescription CHAR(50) NOT NULL,  -- CHAR replaces NCHAR
    CONSTRAINT PK_Region PRIMARY KEY (RegionID)
);

-- Create triggers (PostgreSQL version)
-- Delete trigger
CREATE OR REPLACE FUNCTION public.trg_region_delete()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO logging.TablesTriggers(EventName, EventTime)
    VALUES ('delete region table', CURRENT_TIMESTAMP);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_region_delete
AFTER DELETE ON public.Region
FOR EACH ROW
EXECUTE FUNCTION public.trg_region_delete();

-- Insert trigger
CREATE OR REPLACE FUNCTION public.trg_region_insert()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO logging.TablesTriggers(EventName, EventTime)
    VALUES ('insert into region table', CURRENT_TIMESTAMP);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_region_insert
AFTER INSERT ON public.Region
FOR EACH ROW
EXECUTE FUNCTION public.trg_region_insert();

-- Update trigger
CREATE OR REPLACE FUNCTION public.trg_region_update()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO logging.TablesTriggers(EventName, EventTime)
    VALUES ('update into region table', CURRENT_TIMESTAMP);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_region_update
AFTER UPDATE ON public.Region
FOR EACH ROW
EXECUTE FUNCTION public.trg_region_update();

-- Add table and column comments
COMMENT ON TABLE public.Region IS 'Geographic regions';
COMMENT ON COLUMN public.Region.RegionID IS 'Primary key for regions';
COMMENT ON COLUMN public.Region.RegionDescription IS 'Description of the region';
