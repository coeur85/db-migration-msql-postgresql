-- Object: Roles and Users configuration    Script Date: 6/2/2025 
-- Converted from SQL Server to PostgreSQL

-- Create roles
CREATE ROLE readonly;
GRANT CONNECT ON DATABASE northwind TO readonly;
GRANT USAGE ON SCHEMA public TO readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly;

CREATE ROLE readwrite;
GRANT CONNECT ON DATABASE northwind TO readwrite;
GRANT USAGE ON SCHEMA public TO readwrite;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO readwrite;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO readwrite;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO readwrite;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE ON SEQUENCES TO readwrite;

-- Excel user (read-only)
CREATE ROLE exceluser LOGIN PASSWORD 'StrongPassword123!';
GRANT readonly TO exceluser;
COMMENT ON ROLE exceluser IS 'User for Excel connections - read only access';

-- Web app user (read/write)
CREATE ROLE northwindwebapp LOGIN PASSWORD 'StrongPassword123!';
GRANT readwrite TO northwindwebapp;
COMMENT ON ROLE northwindwebapp IS 'User for web application - read/write access';

-- Developer user (admin)
CREATE ROLE northwinddevuser LOGIN PASSWORD 'StrongPassword123!' CREATEDB CREATEROLE;
GRANT ALL PRIVILEGES ON DATABASE northwind TO northwinddevuser;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO northwinddevuser;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO northwinddevuser;
GRANT ALL PRIVILEGES ON SCHEMA public TO northwinddevuser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO northwinddevuser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON SEQUENCES TO northwinddevuser;
COMMENT ON ROLE northwinddevuser IS 'Developer user with administrative privileges';

-- Note: In a production environment, use stronger passwords and consider using environment variables
-- for passwords rather than hardcoding them in scripts
