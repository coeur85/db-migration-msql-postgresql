/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [northwindwebapp]    Script Date: 5/29/2025 2:00:45 AM ******/
CREATE LOGIN [northwindwebapp] WITH PASSWORD=N't+Ouj/xhJTSMhf3XYm/WbgG6RKmu2q5RnM2aub+8WhM=', DEFAULT_DATABASE=[northwind], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
ALTER LOGIN [northwindwebapp] DISABLE
GO
