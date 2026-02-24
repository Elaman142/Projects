/*****************************************************************************************************************
NAME:    5.2 Final Project: My Communities Analysis—Create Answers
PURPOSE: To answer the questions made on week 4

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     02/16/2026   EULLOA       1. Built this script for EC IT440


RUNTIME: 
Xm Xs

NOTES: 
I needed to modify the area scope due to lack of data in the database in questions 2 & 4
 
******************************************************************************************************************/

-- Q1: For your first two tables, which country or contries have both an average monthly income over $5000 and have a high gross domestic product per capita? How do you think those numbers affect the standard of living?  If you had to guess would a high gross domestic product per capita cause more stress and a lower quality of living? Would a high monthly income result in a higher quality of living, in your opnion?
-- A1: There is a relational pattern between the monthly income and the GDP per capita making that the greater the monthly income is the greater the GDP is increasing but we see that pattern also between monthly incoem and cost index, in other words, the more we earn the more we spent. In my opinion, the quality of living and strees level is really affected by the income but if we live inside of our budget, not spending for things that are not necessary or may destabilize our economy people can have a better quality of living. 

SELECT cl.country,
		cl.monthly_income,
		cl.cost_index,
		rc.gdp_per_capita
	FROM cost_of_living AS cl
	INNER JOIN richest_countries AS rc
		ON cl.country = rc.country
	WHERE cl.monthly_income >= 5000
	AND rc.gdp_per_capita >= (SELECT AVG(gdp_per_capita) AS gdp_average
								FROM richest_countries)
	ORDER BY cl.monthly_income DESC;

-- Q2: What are the 4 top countries with the highest average tourism income and the highest corruption index in Europe? We need to know also the name of the country and what is the attandance rate because we are going to have a meeting with the Executive Committee to discuss the construction of new mega-resort in Europe and before submitting an approval we need to verify wheather would be better to make an asset-light or even if it's requiered a asset-heavy depending the political situation of the country. 
-- A2: We can see that based on the analysis in the next order Germany, France, Italy and Austria are the top 4 countries in Europe to make a assest-light

SELECT TOP(4) c.country,
		c.corruption_index,
		t.receipts_in_billions
	FROM corruption AS c
	INNER JOIN tourism AS t
		ON c.country = t.country
	WHERE c.country IN   ('Albania', 'Austria', 'Belarus', 'Belgium', 'Bulgaria', 'Croatia', 'France', 'Germany', 'Greece', 'Hungary', 'Italy', 'Luxemburgo', 'Moldova', 'Netherlands', 'Norway', 'Portugal', 'Romania', 'Russia', 'Turkey', 'Ukraine')
	ORDER BY T.receipts_in_billions DESC;
								
-- Q3: Which two countries between Germany, Portugal and Qatar have receipts per tourist equal to or over $700 and corruption index lower than the average? After discussions with some three potential Real Estate Investment Trusts, all of them have a stable property in their country of residence: one located in Qatar, another in Portugal, and the third one in Germany. Due to the stability of the countries, we've decided to make an asset-heavy, which means that we are going to use capital to build the installations. A hotel with 100 rooms each room with a construction cost of $700,000, and based on the average daily rate, each room should cost $700 per night. We can only choose 2 of these potential REITs, so we need to determine which two of these apply based on receipts per tourist.
-- A3: Because we're making a assest-heavy we need to take on consideration the corruption index due to the risk in the country is based on this, and we have that Germany is the best one, the second is Qatar due to the one point less than Portugal in the corruption index 

SELECT  c.country,
		c.corruption_index,
		t.receipts_per_tourist
	FROM corruption AS c
	INNER JOIN tourism AS t
		ON c.country = t.country
	WHERE c.corruption_index < (SELECT AVG(corruption_index) 
								FROM corruption)
	AND t.receipts_per_tourist >= 700
	AND c.country IN ('Germany', 'Portugal', 'Qatar')
	ORDER BY c.corruption_index ASC;

-- Q4: Which 3 countries are more required to receive the program based on the unemployment rate? The Grants Manager from another organization has been communicating with the Program Director to provide funds and initiate a program for resilience and employment in Central America. after carefully reviewing the execution plan and costs, the Donor is allowed to deploy the program in 3 countries in Europe and is required to know which 3 countries are more required to receive the program based on the unemployment rate. 
-- A4: Based on the unemployment rate on Europe, in the next order we have the most needed contries to deploy the program are Greece, Turkey and Italy.

SELECT TOP(3)	country, 
				unemployment_rate
	FROM unemployment
WHERE country IN ('Albania', 'Austria', 'Belarus', 'Belgium', 'Bulgaria', 'Croatia', 'France', 'Germany', 'Greece', 'Hungary', 'Italy', 'Luxemburgo', 'Moldova', 'Netherlands', 'Norway', 'Portugal', 'Romania', 'Russia', 'Turkey', 'Ukraine')
ORDER BY unemployment_rate DESC;

-- Q5: How does the corruption index affect unemployment and the cost of living? We are making the Annual Risk Assessment. That is your part in the analysis.
-- A5: Based on the results we determine that in most of the case the less corruption the more monthly income but also we can see a pattern that when there is less corruption there is more unemployment in most of the cases. 

SELECT	c.country,
		c.corruption_index,
		cl.cost_index,
		cl.monthly_income,
		umpl.unemployment_rate
FROM corruption AS c
INNER JOIN cost_of_living AS cl
	ON c.country = cl.country
INNER JOIN unemployment AS umpl
	ON c.country = umpl.country
ORDER BY c.corruption_index DESC;


SELECT GETDATE() AS my_date;