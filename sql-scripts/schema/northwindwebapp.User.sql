/****** Object:  User [northwindwebapp]    Script Date: 5/29/2025 2:00:45 AM ******/
CREATE USER [northwindwebapp] FOR LOGIN [northwindwebapp] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [northwindwebapp]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [northwindwebapp]
GO
