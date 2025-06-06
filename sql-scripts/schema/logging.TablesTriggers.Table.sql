/****** Object:  Table [logging].[TablesTriggers]    Script Date: 5/29/2025 2:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [logging].[TablesTriggers](
	[ActionID] [int] IDENTITY(1,1) NOT NULL,
	[EventName] [char](20) NOT NULL,
	[EventTime] [smalldatetime] NOT NULL,
 CONSTRAINT [PK__TablesTr] PRIMARY KEY CLUSTERED 
(
	[ActionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
