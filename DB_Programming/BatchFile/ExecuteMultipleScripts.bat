@echo off
@echo Executing Multiple SQL Scripts from folder in one go...
for %%G in (*.sql) do sqlcmd -S (localdb)\MSSQLLocalDB -d SampleBatchDB -E -i "%%G"
PAUSE