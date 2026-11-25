-- Confirm The Conversion Worked Cleanly
select count(*) as total_rows from dbo.RetailCombined;
select count(*) as failed_date from dbo.RetailCombined where InvoiceDate is null;
select count(*) as failed_price from dbo.RetailCombined where Price is null;