-- Script to create the Northwind PostgreSQL database
-- Converted from SQL Server to PostgreSQL
-- Date: June 1, 2025

-- Create database (run this command separately if needed)
-- CREATE DATABASE northwind WITH ENCODING = 'UTF8';

-- Schema creation
\i schema/logging.Schema.sql

-- Tables (in dependency order)
\i schema/logging.TablesTriggers.Table.sql
\i schema/public.Categories.Table.sql
\i schema/public.Customers.Table.sql
\i schema/public.Employees.Table.sql
\i schema/public.Region.Table.sql
\i schema/public.Shippers.Table.sql
\i schema/public.Suppliers.Table.sql
\i schema/public.Territories.Table.sql
\i schema/public.Products.Table.sql
\i schema/public.Orders.Table.sql
\i schema/public.Order_Details.Table.sql
\i schema/public.CustomerDemographics.Table.sql
\i schema/public.CustomerCustomerDemo.Table.sql
\i schema/public.EmployeeTerritories.Table.sql

-- Views
\i schema/public.Current_Product_List.View.sql
\i schema/public.Order_Details_Extended.View.sql
\i schema/public.Order_Subtotals.View.sql
\i schema/public.Invoices.View.sql
\i schema/public.Sales_by_Category.View.sql
-- Add other views here

-- Functions (formerly stored procedures)
\i schema/public.CustOrderHist.Function.sql
\i schema/public.SalesByCategory.Function.sql
\i schema/public.GetOrderTotalValue.Function.sql
-- Add other functions here

COMMENT ON DATABASE northwind IS 'Northwind sample database converted from SQL Server to PostgreSQL';
