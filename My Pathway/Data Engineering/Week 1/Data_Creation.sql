-- =============================================
-- Week 1 of Journay / Data Engineering - SQL 

-- Database creation and synthetic data generation 

-- Create the table if not exist
	-- IF NOT EXISTS (SELECT * FROM sys.databases 
	--				WHERE name = 'DataEngineering_week1')

	-- BEGIN 
		-- CREATE DATABASE DataEngineering_week1;
	-- END 
	-- GO

	-- USE DataEngineering_week1;
	-- GO 

-- Now I'm placing the the previous code in quoates in order to avoid to run it again

-- Now I create a table called Transactions 
CREATE TABLE dbo.SalesTransactions (
	TransactionID INT IDENTITY(1,1) PRIMARY KEY, 
	CustomerID INT NOT NULL, 
	CategoryID INT NOT NULL, 
	CategoryName VARCHAR(50) NOT NULL, 
	ProductID INT NOT NULL, 
	SaleDate DATETIME NOT NULL, 
	Amount DECIMAL(10,2) NOT NULL
);
GO 
 
-- Now I generate the synthetic data
INSERT INTO dbo.SalesTransactions (CustomerID, CategoryID, CategoryName, ProductID, SaleDate, Amount)
VALUES 
-- Jan 2026
(101, 1, 'Electronics', 501, '2026-01-05 09:30:00', 1200.00), (101, 1, 'Electronics', 501, '2026-01-05 14:15:00', 1200.00),
(102, 1, 'Electronics', 501, '2026-01-06 10:00:00', 1200.00), (103, 2, 'Home &amp; Kitchen', 601, '2026-01-06 11:20:00', 250.00), (104, 2, 'Home &amp; Kitchen', 601, '2026-01-07 15:45:00', 300.00), (105, 1, 'Electronics', 502, '2026-01-08 08:00:00', 800.00), (101, 3, 'Books', 701, '2026-01-15 12:00:00', 45.00),
-- Feb 2026
(101, 1, 'Electronics', 501, '2026-02-01 10:00:00', 1350.00), (102, 1, 'Electronics', 501, '2026-02-02 11:30:00', 1400.00), (103, 2, 'Home &amp; Kitchen', 601, '2026-02-05 09:15:00', 400.00), (104, 2, 'Home &amp; Kitchen', 602, '2026-02-06 14:00:00', 150.00), (105, 3, 'Books', 701, '2026-02-10 18:20:00', 60.00),
-- Mar 2026
(101, 1, 'Electronics', 501, '2026-03-01 09:00:00', 1500.00), (102, 1, 'Electronics', 501, '2026-03-02 10:15:00', 1100.00), (103, 1, 'Electronics', 501, '2026-03-03 16:00:00', 1250.00), (104, 2, 'Home &amp; Kitchen', 601, '2026-03-05 11:00:00', 550.00), (101, 3, 'Books', 701, '2026-03-10 12:45:00', 95.00);
GO