SELECT * FROM blinkit_data;

SELECT COUNT(*) FROM blinkit_data; -- Counts the number of row entries

UPDATE blinkit_data                                         /*updated in Item_Fat_Content column : LF, low fat to Low Fat and
                                                              reg to Regular*/
SET Item_Fat_Content = 
CASE
WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
WHEN Item_Fat_Content = 'reg' THEN 'Regular'
ELSE Item_Fat_Content
END

SELECT DISTINCT(Item_Fat_Content) FROM blinkit_data;       -- Selecting distinct items

SELECT SUM(Sales) AS Total_Sales 
FROM blinkit_data;                  -- Calculating total sales from the 'Sales' column

SELECT CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions 
FROM blinkit_data;            -- Calculating Total Sales in Million by dividing it by 1000000.

SELECT CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales
FROM blinkit_data;

SELECT COUNT(*) AS No_of_Items FROM blinkit_data;

SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating 
FROM blinkit_data;

SELECT Item_Fat_Content, 
CONCAT(CAST(SUM(Sales)/1000 AS DECIMAL(10,2)),'k') AS Total_Sales_Thousands,
CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
COUNT(*) AS No_of_Items,
CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data 
GROUP BY Item_Fat_Content
ORDER BY Total_Sales_Thousands DESC;

SELECT Item_Type, 
CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
COUNT(*) AS No_of_Items,
CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data 
GROUP BY Item_Type
ORDER BY Total_Sales DESC;