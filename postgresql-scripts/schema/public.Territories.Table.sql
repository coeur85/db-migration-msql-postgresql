-- Convert [dbo].[Territories] to public."Territories"
CREATE TABLE public."Territories"(
    "TerritoryID" VARCHAR(20) NOT NULL,
    "TerritoryDescription" VARCHAR(50) NOT NULL, -- Changed from nchar(50)
    "RegionID" INTEGER NOT NULL,
    CONSTRAINT "PK_Territories" PRIMARY KEY ("TerritoryID") -- Removed NONCLUSTERED
);

-- Add Foreign Key Constraint
ALTER TABLE public."Territories" ADD CONSTRAINT "FK_Territories_Region" FOREIGN KEY ("RegionID")
REFERENCES public."Region" ("RegionID");

