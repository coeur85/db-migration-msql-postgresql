# Setting Up the PostgreSQL Northwind Database

This guide provides step-by-step instructions for setting up the Northwind database in PostgreSQL.

## Prerequisites

1. PostgreSQL (version 12 or higher) installed
2. psql command-line tool or a PostgreSQL client like PgAdmin

## Setup Instructions

### Using psql

1. Connect to PostgreSQL server
   ```bash
   psql -U postgres
   ```

2. Create the Northwind database
   ```sql
   CREATE DATABASE northwind WITH ENCODING = 'UTF8';
   ```

3. Connect to the new database
   ```
   \c northwind
   ```

4. Run the main setup script
   ```
   \i /path/to/00_create_northwind_database.sql
   ```

### Using PgAdmin

1. Connect to your PostgreSQL server
2. Right-click on "Databases" and select "Create" > "Database..."
3. Enter "northwind" as the name and click "Save"
4. Right-click on the new database and select "Query Tool"
5. Open `00_create_northwind_database.sql` file
6. Click "Execute" to run the script

## Data Import (Optional)

If you have data to import from SQL Server:

1. Export data from SQL Server tables (CSV format recommended)
2. Import each file into the corresponding PostgreSQL table:

   Using psql:
   ```
   \copy public.tablename FROM '/path/to/data.csv' WITH (FORMAT csv, HEADER);
   ```
   
   Or using PgAdmin's import tool from the table's context menu

## Verification

Run some queries to verify the setup:

```sql
SELECT COUNT(*) FROM public.Products;
SELECT COUNT(*) FROM public.Customers;
SELECT * FROM public.Alphabetical_list_of_products LIMIT 10;
SELECT * FROM public.Ten_Most_Expensive_Products();
```

## Common Issues

- **Permission denied**: Make sure your PostgreSQL user has the necessary permissions
- **File not found**: Check file paths in the scripts
- **Syntax errors**: PostgreSQL version might affect some syntax; adjust as needed
- **Encoding issues**: Ensure text files use UTF-8 encoding

## Additional Resources

- PostgreSQL Documentation: https://www.postgresql.org/docs/
- Data Type Mapping Reference: See `SQL_to_PostgreSQL_Data_Type_Mapping.md`
- Migration Summary: See `Migration_Summary.md`
