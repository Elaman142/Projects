/*****************************************************************************************************************
NAME:    5.2 Final Project: My Communities Analysis—Create Answers
PURPOSE: To answer question made on week 4

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     02/16/2026   EULLOA     1. Built this script for EC IT440


RUNTIME: 
Xm Xs

NOTES: 
There is no notes
 
******************************************************************************************************************/



-- Q1: which accounts with high churn risk (churn_flag=1) also have the longest average time to first response when joined with support tickets? Show account name, country, and average response time by account from RavenStak_accounts and ravenstak_supporttickets.
-- A1: With this script we can see the account names, their country and their ticket responser average that have a churn flag order by response time. This might show us that the response time has afected to them.

;WITH time_response AS(
	SELECT account_id AS account_id,
			AVG(first_response_time_minutes) AS response_average
	FROM dbo.ravenstack_support_tickets
	GROUP BY account_id
),
accounts_flaged AS(
	SELECT account_name,
			account_id,
			country
		FROM dbo.ravenstack_accounts
	WHERE churn_flag = 1
)

SELECT af.account_name, 
		af.country,
		tr.response_average
FROM time_response AS tr
	RIGHT JOIN accounts_flaged AS af
		ON tr.account_id = af.account_id
ORDER BY tr.response_average DESC;


-- Q2: What type of industries are the ones with more tickets created, and what is their average satisfaction score per industry? Please also provide us the average time that it has been taking to resolve the issue by industry type. We're making an evaluation over the industries to determine what areas to improve for the ones more affected. 
-- A2: There is no relationship on this results showing that resolution time or amount of tickets provides a better satisfaction score. 

SELECT ac.industry,
		AVG(t.resolution_time_hours) AS resolution_hour_time_average,
		AVG(t.satisfaction_score) AS satisfaction_average,
		COUNT(t.ticket_id) AS amount_of_tickets_created
	FROM dbo.ravenstack_support_tickets AS t
		LEFT JOIN dbo.ravenstack_accounts AS ac
		ON t.account_id = ac.account_id
	GROUP BY ac.industry
	ORDER BY satisfaction_average DESC;

-- Q3: During the current year (2024), where have we had more increments in revenue: on upgrades or on new subscriptions? We are trying to decide which of the two to make an investment in next year, but the budget is limited, and we can afford just one of them.
-- A3: The best option is invest in actions that actracts more subscriptions. The amount of money earned in 2024 on new susbscriptions is 8 times more than the one earned on upgrades.

;WITH "2024_upgrade_revenue" AS(
	SELECT SUM(arr_amount) AS upagrade_annual_revenue,
	'2024' AS 'Year'
	FROM dbo.ravenstack_subscriptions
	WHERE upgrade_flag = 1
),
 "2024_subscription_revenue" AS(
	SELECT SUM(arr_amount) AS subscription_annual_revenue,
	'2024' AS 'Year'
	FROM dbo.ravenstack_subscriptions
	WHERE upgrade_flag = 0
)

SELECT u.upagrade_annual_revenue,
		s.subscription_annual_revenue,
		u.Year
	FROM "2024_upgrade_revenue" AS u
		INNER JOIN "2024_subscription_revenue" AS s
		ON u.Year = s.Year;

-- Q4: What is the total of subscription per account type last year (2023) and current year (2024) until today? And what is the total of churns that we had last year and until now? We are trying to get insingts about what type of accont have been having more success during these years. 
-- A4: Based on the results, we see that DevTools, FinTech and Cibersecurity are the ones with more total of subscriptions the last 2 years in total. Highlighting DevTools as the highest one making it a good place to agregate new options, tools or offers.

;WITH data_2023 AS(
SELECT a.industry AS industry,
		COUNT(s.subscription_id) AS total_subscription_2023
	FROM ravenstack_subscriptions AS s
	INNER JOIN dbo.ravenstack_accounts AS a
	ON s.account_id = a.account_id
	WHERE s.start_date >= '2023-01-09' 
	AND s.start_date < '2023-12-31'
	GROUP BY a.industry
),
data_2024 AS(
SELECT a.industry AS industry,
		COUNT(s.subscription_id) AS total_subscription_2024
	FROM ravenstack_subscriptions AS s
	INNER JOIN dbo.ravenstack_accounts AS a
	ON s.account_id = a.account_id
	WHERE s.start_date >= '2024-01-01' 
	AND s.start_date >  '2024-03-09'
	GROUP BY a.industry
)

SELECT 
    d23.industry,
    d23.total_subscription_2023,
    d24.total_subscription_2024,
	(d23.total_subscription_2023 + d24.total_subscription_2024) AS Total
FROM data_2023 AS d23
INNER JOIN data_2024 AS d24
    ON d23.industry = d24.industry
	ORDER BY Total DESC;


-- Q5: What are the 3 top reasons for churns in the last three months (July, August, and September), and what type of subscription has it been more affected? We are looking for areas of improvement in our platform services. 
-- A5: Based on the results we only got two of main churn reason between those months which are too expensice/budget and the other one reason unknown.

SELECT TOP(3) COUNT(c.churn_event_id) AS churn_amount,
		ISNULL(c.feedback_text, 'no reason provided') AS churn_reason
	FROM ravenstack_churn_events AS c
	INNER JOIN ravenstack_subscriptions AS s
		ON c.account_id = s.account_id
	WHERE s.end_date BETWEEN '2023-07-09' 
	AND '2023-10-09'
	GROUP BY feedback_text
	ORDER BY churn_amount DESC;





SELECT GETDATE() AS my_date;

