/****** Object:  UserDefinedFunction [dbo].[GetOrderTotalValue]    Script Date: 5/29/2025 2:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT TOP (1000) [OrderID]
--      ,[ProductID]
--      ,[UnitPrice]
--      ,[Quantity]
--      ,[Discount]
--  FROM [northwind].[dbo].[Order Details]


create   function [dbo].[GetOrderTotalValue](@OrderId int)
returns decimal(18,4)
as
begin
declare @output decimal(18,4);

select 
	@output = SUM((od.UnitPrice - od.Discount )* od.Quantity)
from
	[Order Details] od
where
	OrderID = @OrderId;

return @output;
end


GO
