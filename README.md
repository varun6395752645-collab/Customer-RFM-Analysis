# Customer Analytics & RFM Segmentation — SQL, Python & Power BI

End-to-end customer analytics project on two years of UK online-retail transactions (Dec 2009 – Dec 2011). Raw data is cleaned in **SQL Server**, customers are scored and segmented with **RFM analysis in Python (pandas)**, and the results are presented in an interactive **Power BI** dashboard.

![Overview page](images/overview.png)
![RFM page](images/rfm.png)

## Business Problem
IKEA Gifting (a UK-based online gift and home-decor retailer) had no data-driven view of which customers drive the most revenue or which are disengaging, so retention and marketing efforts were reactive. The goal: **identify the most valuable customer segments and quantify churn risk** so marketing and CRM teams can prioritise spend.

Questions answered:
1. Who are the most valuable customers, and how much revenue do they contribute?
2. Which customers have gone quiet and are at risk of churning?
3. How do customer value and retention trend over time (month, quarter, year)?
4. How do value and churn risk differ by country?
5. What actions should be taken for each segment?

## Dataset
- **Online Retail II** (UCI Machine Learning Repository, donated by Daqing Chen)
- About 1.07M raw transaction rows: Invoice, StockCode, Description, Quantity, InvoiceDate, Price, Customer ID, Country
- After cleaning and deduplication: **1,033,036 rows**, of which 797,885 have a Customer ID

## Workflow

### 1. Data cleaning — SQL Server (`sql/`)
| File | What it does |
|---|---|
| `SQLQuery1.sql` | Combines the 2009–2010 and 2010–2011 sheets with `UNION ALL`; safely converts dates (`TRY_CONVERT`, two formats) and price to `decimal(10,2)` |
| `SQLQuery2.sql` | Validates the conversion (total rows, failed dates, failed prices) |
| `SQLQuery3.sql` | Data-quality checks: missing Customer ID, zero/negative quantity, missing description, exact duplicate rows |
| `SQLQuery4.sql` | Removes exact duplicates with `ROW_NUMBER()` and creates the final `RetailCleaned` table |

### 2. RFM segmentation — Python (`notebook/RFM_Segment.ipynb`)
- **Recency:** days since last purchase, measured from a snapshot date of 2011-12-10
- **Frequency:** number of distinct invoices
- **Monetary:** sum of Quantity × Price
- Each metric is scored 1–5 using quintiles (`pd.qcut`)
- **Segments:** Champions, Loyal, At Risk, New, Needs Attention, Lost (rule-based on R, F, M scores)
- **Churn flag:** `IsChurned = Recency > 90 days`
- RFM results are merged back to the transactions and exported to Excel as the Power BI source (`EcommerceDashboardData.xlsx`)

| Segment | Rule |
|---|---|
| Champions | R ≥ 4, F ≥ 4, M ≥ 4 |
| Loyal | R ≥ 3, F ≥ 3 |
| At Risk | R ≤ 2, F ≥ 3 |
| New | R ≥ 4, F ≤ 2 |
| Needs Attention | R = 3, F ≤ 2 |
| Lost | Everyone else |

### 3. Dashboard — Power BI (`project.pbix`)
**Overview page**
- KPI cards: Total Customers, Total Revenue, Avg Customer Value, Churned %
- Revenue and customers by month, quarter and year
- Revenue by segment (column and pie), customers by segment, retention by segment
- Slicers for Country, Segment and Is Churned, plus a clear-all-slicers button

**RFM Analysis page**
- Average customer value by segment and top 5 countries
- Churned % and total customers by month, quarter and year
- Segment Performance Summary table and Country Performance Summary matrix (R/F/M scores, customers, revenue)
- Drillthrough on revenue, bookmarks, and page navigation

## Key Insights
> Add 3–5 findings from your dashboard, for example:
> - Champions are ___% of customers but ___% of revenue.
> - Overall churn rate is ___%; the largest churned group is ___.
> - Top country by average customer value: ___.
> - Recommended action for At Risk customers: ___.

## Tools Used
SQL Server (T-SQL, CTEs, window functions) · Python (pandas) · Jupyter Notebook · Excel · Power BI (DAX, bookmarks, drillthrough)

## How to Run
1. Run the four SQL files in order on the Online Retail II data to create `RetailCleaned`.
2. Export the cleaned table to `Results.csv` and run `RFM_Segment.ipynb` to produce `EcommerceDashboardData.xlsx`.
3. Open `project.pbix` in Power BI Desktop (Windows) and refresh the data source if needed.

## Repository Structure
```
├── README.md
├── project.pbix
├── sql/
│   ├── SQLQuery1.sql
│   ├── SQLQuery2.sql
│   ├── SQLQuery3.sql
│   └── SQLQuery4.sql
├── notebook/
│   └── RFM_Segment.ipynb
├── images/
│   ├── overview.png
│   └── rfm.png
└── docs/            (BRD, if you are allowed to share it)
```

## Author
**Varun Sharma** — Aspiring Data Analyst · Python | SQL | Power BI
[LinkedIn](https://www.linkedin.com/in/varun-sharma-a93927327)· [GitHub](https://github.com/varun6395752645-collab)
