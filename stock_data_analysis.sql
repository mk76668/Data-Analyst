show databases;

use stock_analysis;

-- Get average closing price for each company--
SELECT Ticker, AVG(Close) AS Avg_Close_Price
FROM synthetic_stock_data_1
GROUP BY Ticker;

-- Highest stock price reached by each company--
SELECT Ticker, MAX(High) AS Highest_High
FROM synthetic_stock_data_1
GROUP BY Ticker;

-- Daily percentage change in price--
SELECT Date, Ticker,
       round(((Close - Open) / Open) * 100 )AS Daily_Percentage_Change
FROM synthetic_stock_data_1;

-- Latest Market Cap per company--
SELECT Ticker, Date, `Market Cap`
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Ticker ORDER BY Date DESC) AS rn
    FROM synthetic_stock_data_1
) AS ranked
WHERE rn = 1;

--  List top 5 stocks by average adjusted close price--
SELECT Ticker, AVG(`Adjusted Close`) AS Avg_Adj_Close
FROM synthetic_stock_data_1
GROUP BY Ticker
ORDER BY Avg_Adj_Close DESC
LIMIT 5;

--  Stocks that had drop >15% in a single day--
SELECT Date, Ticker, Open, Close,
       ROUND((Close - Open) / Open * 100, 2) AS Daily_Change_Percent
FROM synthetic_stock_data_1
WHERE (Close - Open) / Open * 100 <= -15;

-- Month-over-month return for each stock--
SELECT Ticker, YEAR(Date) AS Year, MONTH(Date) AS Month,
       MAX(Close) - MIN(Close) AS Monthly_Return
FROM synthetic_stock_data_1
GROUP BY Ticker, YEAR(Date), MONTH(Date)
ORDER BY Ticker, Year, Month;


-- Yearly High & Low Prices Per Stock--
SELECT Ticker, YEAR(Date) AS Year,
       MAX(High) AS Year_High,
       MIN(Low) AS Year_Low
FROM synthetic_stock_data_1
GROUP BY Ticker, YEAR(Date)
ORDER BY Ticker, Year;

drop database stock_data;















