# Database Migration Project
## From SQL Server to PostgreSQL

This project involves migrating the Northwind database from Microsoft SQL Server to PostgreSQL.

### Migration Overview

1. **Schema Migration**: All SQL Server schemas and their objects have been converted to their PostgreSQL equivalents.
   - The `dbo` schema has been mapped to the PostgreSQL `public` schema
   - The `logging` schema has been preserved as is

2. **Object Types Migrated**:
   - Tables with primary keys, foreign keys, check constraints, and default values
   - Views
   - Stored procedures (converted to PostgreSQL functions)
   - User-defined functions
   - Triggers

3. **Data Types Mapping**:
   - See [SQL_to_PostgreSQL_Data_Type_Mapping.md](./SQL_to_PostgreSQL_Data_Type_Mapping.md) for detailed mapping

4. **Deployment**:
   - Run `00_create_northwind_database.sql` to create all schemas and objects
   - Data migration scripts to be created as needed


### Northwind schemas
| TABLE_CATALOG | TABLE_SCHEMA |
|---------------|--------------|
| northwind     | logging      |
| northwind     | dbo          |
```sql
select 
	distinct TABLE_CATALOG,TABLE_SCHEMA 
from
	INFORMATION_SCHEMA.TABLES
```


### Northwind Database Tables Information

| TABLE_CATALOG | TABLE_SCHEMA | TABLE_TYPE | TABLE_NAME                       | CONSTRAINT_NAME                          | CONSTRAINT_TYPE |
|---------------|--------------|------------|----------------------------------|------------------------------------------|------------------|
| northwind     | dbo          | BASE TABLE | Categories                       | PK_Categories                             | PRIMARY KEY      |
| northwind     | dbo          | BASE TABLE | CustomerCustomerDemo             | FK_CustomerCustomerDemo                   | FOREIGN KEY      |
| northwind     | dbo          | BASE TABLE | CustomerCustomerDemo             | FK_CustomerCustomerDemo_Customers        | FOREIGN KEY      |
| northwind     | dbo          | BASE TABLE | CustomerCustomerDemo             | PK_CustomerCustomerDemo                   | PRIMARY KEY      |
| northwind     | dbo          | BASE TABLE | CustomerDemographics             | PK_CustomerDemographics                   | PRIMARY KEY      |
| northwind     | dbo          | BASE TABLE | Customers                        | PK_Customers                              | PRIMARY KEY      |
| northwind     | dbo          | BASE TABLE | Employees                        | CK_Birthdate                              | CHECK            |
| northwind     | dbo          | BASE TABLE | Employees                        | FK_Employees_Employees                    | FOREIGN KEY      |
| northwind     | dbo          | BASE TABLE | Employees                        | PK_Employees                              | PRIMARY KEY      |
| northwind     | dbo          | BASE TABLE | EmployeeTerritories              | FK_EmployeeTerritories_Employees          | FOREIGN KEY      |
| northwind     | dbo          | BASE TABLE | EmployeeTerritories              | FK_EmployeeTerritories_Territories        | FOREIGN KEY      |
| northwind     | dbo          | BASE TABLE | EmployeeTerritories              | PK_EmployeeTerritories                    | PRIMARY KEY      |
| northwind     | dbo          | BASE TABLE | Order Details                    | CK_Discount                               | CHECK            |
| northwind     | dbo          | BASE TABLE | Order Details                    | CK_Quantity                               | CHECK            |
| northwind     | dbo          | BASE TABLE | Order Details                    | CK_UnitPrice                              | CHECK            |
| northwind     | dbo          | BASE TABLE | Order Details                    | FK_Order_Details_Orders                   | FOREIGN KEY      |
| northwind     | dbo          | BASE TABLE | Order Details                    | FK_Order_Details_Products                 | FOREIGN KEY      |
| northwind     | dbo          | BASE TABLE | Order Details                    | PK_Order_Details                          | PRIMARY KEY      |
| northwind     | dbo          | BASE TABLE | Orders                           | FK_Orders_Customers                       | FOREIGN KEY      |
| northwind     | dbo          | BASE TABLE | Orders                           | FK_Orders_Employees                       | FOREIGN KEY      |
| northwind     | dbo          | BASE TABLE | Orders                           | FK_Orders_Shippers                        | FOREIGN KEY      |
| northwind     | dbo          | BASE TABLE | Orders                           | PK_Orders                                 | PRIMARY KEY      |
| northwind     | dbo          | BASE TABLE | Products                         | CK_Products_UnitPrice                     | CHECK            |
| northwind     | dbo          | BASE TABLE | Products                         | CK_ReorderLevel                           | CHECK            |
| northwind     | dbo          | BASE TABLE | Products                         | CK_UnitsInStock                           | CHECK            |
| northwind     | dbo          | BASE TABLE | Products                         | CK_UnitsOnOrder                           | CHECK            |
| northwind     | dbo          | BASE TABLE | Products                         | FK_Products_Categories                    | FOREIGN KEY      |
| northwind     | dbo          | BASE TABLE | Products                         | FK_Products_Suppliers                     | FOREIGN KEY      |
| northwind     | dbo          | BASE TABLE | Products                         | PK_Products                               | PRIMARY KEY      |
| northwind     | dbo          | BASE TABLE | Region                           | PK_Region                                 | PRIMARY KEY      |
| northwind     | dbo          | BASE TABLE | Shippers                         | PK_Shippers                               | PRIMARY KEY      |
| northwind     | dbo          | BASE TABLE | Suppliers                        | PK_Suppliers                              | PRIMARY KEY      |
| northwind     | dbo          | BASE TABLE | Territories                      | FK_Territories_Region                     | FOREIGN KEY      |
| northwind     | dbo          | BASE TABLE | Territories                      | PK_Territories                            | PRIMARY KEY      |
| northwind     | logging      | BASE TABLE | TablesTriggers (cutome)    | PK__TablesTr                              | PRIMARY KEY      |
| northwind     | dbo          | VIEW       | Alphabetical list of products    | NULL                                      | NULL             |
| northwind     | dbo          | VIEW       | Category Sales for 1997          | NULL                                      | NULL             |
| northwind     | dbo          | VIEW       | Current Product List             | NULL                                      | NULL             |
| northwind     | dbo          | VIEW       | Customer and Suppliers by City   | NULL                                      | NULL             |
| northwind     | dbo          | VIEW       | Invoices                         | NULL                                      | NULL             |
| northwind     | dbo          | VIEW       | Order Details Extended           | NULL                                      | NULL             |
| northwind     | dbo          | VIEW       | Order Subtotals                  | NULL                                      | NULL             |
| northwind     | dbo          | VIEW       | Orders Qry                       | NULL                                      | NULL             |
| northwind     | dbo          | VIEW       | Product Sales for 1997           | NULL                                      | NULL             |
| northwind     | dbo          | VIEW       | Products Above Average Price     | NULL                                      | NULL             |
| northwind     | dbo          | VIEW       | Products by Category             | NULL                                      | NULL             |
| northwind     | dbo          | VIEW       | Quarterly Orders                 | NULL                                      | NULL             |
| northwind     | dbo          | VIEW       | Sales by Category                | NULL                                      | NULL             |
| northwind     | dbo          | VIEW       | Sales Totals by Amount           | NULL                                      | NULL             |
| northwind     | dbo          | VIEW       | Summary of Sales by Quarter      | NULL                                      | NULL             |
| northwind     | dbo          | VIEW       | Summary of Sales by Year         | NULL                                      | NULL             |


#### script used

```sql
select 
	t.TABLE_CATALOG,
	t.TABLE_SCHEMA,
	t.TABLE_TYPE,
	t.TABLE_NAME,
	tc.CONSTRAINT_NAME,
	tc.CONSTRAINT_TYPE
from 
	INFORMATION_SCHEMA.TABLES t 
full outer join
	INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
on
	tc.TABLE_NAME	=	t.TABLE_NAME
where
	t.TABLE_CATALOG =	DB_NAME()
order by
	t.TABLE_CATALOG,
	t.TABLE_SCHEMA,
	t.TABLE_TYPE,
	t.TABLE_NAME,
	tc.CONSTRAINT_NAME,
	tc.CONSTRAINT_TYPE
```

### tables triggers (custome)

| object_id | name              | type | type_desc | parent_table_name |
|-----------|-------------------|------|-----------|-------------------|
| 50099219  | trg_Region_insert | 1    | INSERT    | Region            |
| 66099276  | trg_Region_update | 2    | UPDATE    | Region            |
| 82099333  | trg_Region_delete | 3    | DELETE    | Region            |

#### script used

```sql
select
	t.object_id,
	t.name,
	e.type,
	e.type_desc,
	ta.name as [parent_table_name]
from
	sys.triggers t
inner join
	sys.trigger_events e
on
	t.object_id	=	e.object_id
inner join
	sys.tables ta
on
	ta.object_id	=	t.parent_id
```

#### stored proc and functions
| ObjectType | SchemaName | ObjectName                    |
|------------|------------|-------------------------------|
| FUNCTION   | dbo        | GetOrderTotalValue (custome)  |
| PROCEDURE  | dbo        | CustOrderHist                 |
| PROCEDURE  | dbo        | CustOrdersDetail              |
| PROCEDURE  | dbo        | CustOrdersOrders              |
| PROCEDURE  | dbo        | Employee Sales by Country     |
| PROCEDURE  | dbo        | Sales by Year                 |
| PROCEDURE  | dbo        | SalesByCategory               |
| PROCEDURE  | dbo        | Ten Most Expensive Products   |

```sql
SELECT 
    ROUTINE_TYPE AS ObjectType,
    ROUTINE_SCHEMA AS SchemaName,
    ROUTINE_NAME AS ObjectName
FROM INFORMATION_SCHEMA.ROUTINES
--WHERE ROUTINE_TYPE IN ('PROCEDURE', 'FUNCTION')
ORDER BY ObjectType, SchemaName, ObjectName;
```

### users, logins and permissions
| DatabaseUser       | LoginName        | UserType  | Privilege | PermissionState | PermissionClass | ObjectType  | ObjectName           |
|--------------------|------------------|-----------|-----------|------------------|------------------|-------------|-----------------------|
| exceluser          | exceluser        | SQL_USER  | CONNECT   | GRANT           | 0                | DATABASE    | northwind             |
| exceluser          | exceluser        | SQL_USER  | SELECT    | GRANT           | 1                | USER_TABLE  | dbo.Customers         |
| exceluser          | exceluser        | SQL_USER  | SELECT    | GRANT           | 1                | USER_TABLE  | dbo.Orders            |
| exceluser          | exceluser        | SQL_USER  | SELECT    | GRANT           | 1                | USER_TABLE  | dbo.Order Details     |
| northwinddevuser   | northwinddevuser | SQL_USER  | ALTER     | GRANT           | 0                | DATABASE    | northwind             |
| northwinddevuser   | northwinddevuser | SQL_USER  | CONNECT   | GRANT           | 0                | DATABASE    | northwind             |
| northwinddevuser   | northwinddevuser | SQL_USER  | EXECUTE   | GRANT           | 0                | DATABASE    | northwind             |
| northwinddevuser   | northwinddevuser | SQL_USER  | INSERT    | GRANT           | 0                | DATABASE    | northwind             |
| northwinddevuser   | northwinddevuser | SQL_USER  | SELECT    | GRANT           | 0                | DATABASE    | northwind             |
| northwinddevuser   | northwinddevuser | SQL_USER  | UPDATE    | GRANT           | 0                | DATABASE    | northwind             |
| northwindwebapp    | northwindwebapp  | SQL_USER  | CONNECT   | GRANT           | 0                | DATABASE    | northwind             |
| northwindwebapp    | northwindwebapp  | SQL_USER  | EXECUTE   | GRANT           | 0                | DATABASE    | northwind             |
| northwindwebapp    | northwindwebapp  | SQL_USER  | INSERT    | GRANT           | 0                | DATABASE    | northwind             |
| northwindwebapp    | northwindwebapp  | SQL_USER  | SELECT    | GRANT           | 0                | DATABASE    | northwind             |
| northwindwebapp    | northwindwebapp  | SQL_USER  | UPDATE    | GRANT           | 0                | DATABASE    | northwind             |
| northwindwebapp    | northwindwebapp  | SQL_USER  | CONNECT   | GRANT           | 0                | DATABASE    | northwind             |
| northwindwebapp    | northwindwebapp  | SQL_USER  | EXECUTE   | GRANT           | 0                | DATABASE    | northwind             |
| northwindwebapp    | northwindwebapp  | SQL_USER  | INSERT    | GRANT           | 0                | DATABASE    | northwind             |
| northwindwebapp    | northwindwebapp  | SQL_USER  | SELECT    | GRANT           | 0                | DATABASE    | northwind             |
| northwindwebapp    | northwindwebapp  | SQL_USER  | UPDATE    | GRANT           | 0                | DATABASE    | northwind             |

```sql
SELECT 
    dp.name AS DatabaseUser,
    sp.name AS LoginName,
    dp.type_desc AS UserType,
    perm.permission_name AS Privilege,
    perm.state_desc AS PermissionState,
    perm.class AS PermissionClass,
    CASE 
        WHEN perm.class = 0 THEN 'DATABASE'
        WHEN perm.class = 1 THEN o.type_desc
        WHEN perm.class = 3 THEN 'SCHEMA'
        ELSE 'OTHER'
    END AS ObjectType,
    CASE 
        WHEN perm.class = 0 THEN DB_NAME()
        WHEN perm.class = 1 THEN SCHEMA_NAME(o.schema_id) + '.' + o.name
        WHEN perm.class = 3 THEN s.name
        ELSE NULL
    END AS ObjectName
FROM 
    sys.database_principals dp
LEFT JOIN 
    sys.server_principals sp ON dp.sid = sp.sid
LEFT JOIN 
    sys.database_role_members drm ON dp.principal_id = drm.member_principal_id
LEFT JOIN 
    sys.database_principals dr ON drm.role_principal_id = dr.principal_id
LEFT JOIN 
    sys.database_permissions perm ON dp.principal_id = perm.grantee_principal_id
LEFT JOIN 
    sys.objects o ON perm.major_id = o.object_id AND perm.class = 1
LEFT JOIN 
    sys.schemas s ON perm.major_id = s.schema_id AND perm.class = 3
WHERE 
    dp.type IN ('S') -- SQL users only, exclude Windows users etc.
    AND dp.name NOT IN ('guest', 'INFORMATION_SCHEMA', 'sys')
ORDER BY 
    dp.name, dr.name, perm.permission_name;

```

### users rols
|  DatabaseUser    | UserType  |      RoleName      |
|------------------|-----------|--------------------|
| exceluser        | SQL_USER  | db_denydatawriter  |
| northwindwebapp  | SQL_USER  | db_datareader      |
| northwindwebapp  | SQL_USER  | db_datawriter      |
```sql
SELECT 
    dp.name AS DatabaseUser,
    dp.type_desc AS UserType,
    dr.name AS RoleName
FROM 
    sys.database_principals dp
INNER JOIN 
    sys.database_role_members drm ON dp.principal_id = drm.member_principal_id
INNER JOIN 
    sys.database_principals dr ON drm.role_principal_id = dr.principal_id
WHERE 
    dp.type IN ('S', 'U', 'G') -- SQL users, Windows users, Windows groups
    AND dp.name NOT IN ('guest', 'INFORMATION_SCHEMA', 'sys', 'dbo') -- exclude system users
ORDER BY 
    dp.name, dr.name;
```






### SQL Server to PostgreSQLschema mapping
| TABLE_CATALOG | TABLE_SCHEMA | TABLE_SCHEMA 	|
|---------------|--------------|---------------	|
| northwind     | logging      | logging		|
| northwind     | dbo          | public		|

### SQL Server to PostgreSQL Data Type Mapping
| SQL Server Data Type        | PostgreSQL Equivalent  | Notes                                                         |
|-----------------------------|------------------------|---------------------------------------------------------------|
| bit                         | boolean                | SQL Server 1/0 maps to PostgreSQL TRUE/FALSE                  |
| smallint                    | smallint               | 2-byte integer                                                |
| int                         | integer                | 4-byte integer                                                |
| bigint                      | bigint                 | 8-byte integer                                                |
| decimal/numeric             | decimal/numeric        | Exact numeric with specified precision and scale              |
| real                        | real                   | Single precision floating-point                               |
| float                       | double precision       | Double precision floating-point                               |
| int IDENTITY                | serial                 | Auto-incrementing integer                                     |
| bigint IDENTITY             | bigserial              | Auto-incrementing bigint                                      |
| varchar(n)                  | varchar(n)             | Variable-length string with limit                             |
| char(n)                     | char(n)                | Fixed-length string                                           |
| varchar(max)                | text                   | Unlimited length string                                       |
| nvarchar/nchar              | text                   | Unicode string data                                           |
| datetime2                   | timestamp              | Timestamp without timezone                                    |
| datetimeoffset              | timestamptz            | Timestamp with timezone                                       |
| date                        | date                   | Calendar date                                                 |
| time                        | time                   | Time of day                                                   |
| varbinary(max)              | bytea                  | Binary data                                                   |
| nvarchar(max) with JSON     | json/jsonb             | JSON data                                                     |
| uniqueidentifier            | uuid                   | Universally unique identifier                                 |
| table type                  | No direct equivalent   | Can use temporary tables or functions                         |
| hierarchyid                 | No direct equivalent   | Can be implemented via ltree extension                        |
| XML                         | xml                    | XML data type                                                 |





### Migration Progress Tracking
- [ ] Schema migration completed
- [ ] Data migration completed
- [ ] Validation tests passed
