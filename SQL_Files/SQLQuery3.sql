-- check 1 - Mising Customer Id
select count(*) as mising_customer_id 
from dbo.RetailCombined where customer_ID is null;

-- check 2 - Negative Or Zero Quentity
select count(*) as negative_qty
from dbo.RetailCombined where Quantity<=0;

-- check 3 - Missing Description 
select count(*) as missing_description 
from dbo.RetailCombined
where Description is null;

-- check 4 - Exact Duplicate Rows
select Invoice, StockCode, Description, Quantity, InvoiceDate, Price, Customer_ID,Country,
	Count(*) AS ExactDupeCount
from dbo.RetailCombined
group by Invoice, StockCode, Description, Quantity, InvoiceDate, Price, Customer_ID,Country
having count(*)>1;
