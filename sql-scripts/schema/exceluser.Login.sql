/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [exceluser]    Script Date: 5/29/2025 2:00:45 AM ******/
CREATE LOGIN [exceluser] WITH PASSWORD=N'+wPKK7H0aNyqe+1Mptetyl47q0txbzuSzwW/saPAvL0=', DEFAULT_DATABASE=[northwind], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
ALTER LOGIN [exceluser] DISABLE
GO
