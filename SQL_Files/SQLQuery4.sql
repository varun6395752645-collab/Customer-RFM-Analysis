-- Deduplicate And Produce The Final Cleaned Table 
with deduped as (
	select *,
	ROW_NUMBER() over (partition by Invoice, StockCode, Description, Quantity, InvoiceDate, Price, Customer_ID,Country
	order by(select null) 
	) as RowNum
	from dbo.RetailCombined
)
select Invoice, StockCode, Description, Quantity, InvoiceDate, Price, Customer_ID,Country
into dbo.RetailCleaned
from deduped
Where RowNum = 1;

select *
from dbo.RetailCleaned;