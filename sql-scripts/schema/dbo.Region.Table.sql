/****** Object:  Table [dbo].[Region]    Script Date: 5/29/2025 2:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Region](
	[RegionID] [int] NOT NULL,
	[RegionDescription] [nchar](50) NOT NULL,
 CONSTRAINT [PK_Region] PRIMARY KEY NONCLUSTERED 
(
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Trigger [dbo].[trg_Region_delete]    Script Date: 5/29/2025 2:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create   trigger [dbo].[trg_Region_delete]
on [dbo].[Region]
after delete
as
insert into [logging].[TablesTriggers]
values ('delete  region table',GETDATE());
GO
ALTER TABLE [dbo].[Region] ENABLE TRIGGER [trg_Region_delete]
GO
/****** Object:  Trigger [dbo].[trg_Region_insert]    Script Date: 5/29/2025 2:00:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   trigger [dbo].[trg_Region_insert]
on [dbo].[Region]
after insert
as
insert into [logging].[TablesTriggers]
values ('insert into region table',GETDATE());
GO
ALTER TABLE [dbo].[Region] ENABLE TRIGGER [trg_Region_insert]
GO
/****** Object:  Trigger [dbo].[trg_Region_update]    Script Date: 5/29/2025 2:00:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create   trigger [dbo].[trg_Region_update]
on [dbo].[Region]
after update
as
insert into [logging].[TablesTriggers]
values ('update into region table',GETDATE());
GO
ALTER TABLE [dbo].[Region] ENABLE TRIGGER [trg_Region_update]
GO
