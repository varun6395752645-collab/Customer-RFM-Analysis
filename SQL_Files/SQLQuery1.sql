-- Combine Both Years And Convert Type Safely
select 
	Invoice ,StockCode , Description ,Quantity,
	coalesce(
	   TRY_CONVERT(datetime2,InvoiceDate,120),
	   TRY_CONVERT(datetime2,InvoiceDate,105)
	) as InvoiceDate,
	try_convert(decimal(10,2),price) as Price,
	customer_ID, Country, '2009-2010' as SourceSheet
into dbo.RetailCombined
from dbo.[Year 2009-2010]

union all

select 
	Invoice ,StockCode , Description ,Quantity,
	coalesce(
	   TRY_CONVERT(datetime2,InvoiceDate,120),
	   TRY_CONVERT(datetime2,InvoiceDate,105)
	) as InvoiceDate,
	try_convert(decimal(10,2),price) as Price,
	customer_ID, Country, '2010-2011' as SourceSheet
from dbo.[Year 2010-2011];