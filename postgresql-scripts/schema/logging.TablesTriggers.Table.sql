-- Object: Table logging.TablesTriggers    Script Date: 5/29/2025 2:00:45 AM
-- Converted from SQL Server to PostgreSQL

-- Create the table with primary key
CREATE TABLE logging.TablesTriggers (
    ActionID SERIAL NOT NULL,  -- SERIAL replaces IDENTITY(1,1)
    EventName CHAR(20) NOT NULL,
    EventTime TIMESTAMP NOT NULL,  -- TIMESTAMP replaces SMALLDATETIME
    CONSTRAINT PK_TablesTriggers PRIMARY KEY (ActionID)
);

-- Add table and column comments
COMMENT ON TABLE logging.TablesTriggers IS 'Audit log for table trigger events';
COMMENT ON COLUMN logging.TablesTriggers.ActionID IS 'Primary key for trigger logs';
COMMENT ON COLUMN logging.TablesTriggers.EventName IS 'Name of the triggered event';
COMMENT ON COLUMN logging.TablesTriggers.EventTime IS 'Timestamp when the event occurred';
