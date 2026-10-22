-- 1# Now having my data created I will proceed with my objective of getting the most resent transaction of every customer per day without duplicates

WITH RankedTransactions AS (
	SELECT 
		TransactionID, 
		CustomerID, 
		SaleDate, 
		Amount, 
		ROW_NUMBER() OVER(
			PARTITION BY CustomerID, CAST(SaleDate AS Date)
			ORDER BY SaleDate DESC, TransactionID DESC
		) AS RowNum 
	FROM dbo.SalesTransactions
)
SELECT 
	TransactionID, 
	CustomerID, 
	SaleDate, 
	Amount
FROM RankedTransactions 
WHERE RowNum = 1 
ORDER BY CustomerID, SaleDate; 

-- With this I can identify unique transactions getting the most resent ones. 