/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [northwinddevuser]    Script Date: 5/29/2025 2:00:45 AM ******/
CREATE LOGIN [northwinddevuser] WITH PASSWORD=N'yK2164dHr9/MqPtHWFzDqBPPHD7giyt0by2A2QJgNC0=', DEFAULT_DATABASE=[northwind], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
ALTER LOGIN [northwinddevuser] DISABLE
GO
