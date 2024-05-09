@echo off
@echo Executing my T-SQL Table Creation Scripts
SQLCMD -S (localdb)\MSSQLLocalDB -d SampleBatchDB -E -i "C:\Users\My Laptop\Desktop\CFP_Projects\DB_Programming\BatchFile\CreateTable.sql"
PAUSE