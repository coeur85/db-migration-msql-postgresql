/****** Object:  User [exceluser]    Script Date: 5/29/2025 2:00:45 AM ******/
CREATE USER [exceluser] FOR LOGIN [exceluser] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [exceluser]
GO
