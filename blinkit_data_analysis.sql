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
FROM blinkit_data;   -- Average Sales

SELECT COUNT(*) AS No_of_Items FROM blinkit_data; -- Count of sales

SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating 
FROM blinkit_data; -- Average Ratings

SELECT Item_Fat_Content,                                   -- Total Sales by Fat Content
CONCAT(CAST(SUM(Sales)/1000 AS DECIMAL(10,2)),'k') AS Total_Sales_Thousands,
CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
COUNT(*) AS No_of_Items,
CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data 
GROUP BY Item_Fat_Content
ORDER BY Total_Sales_Thousands DESC;

SELECT Item_Type,                                          -- Total Sales by Item Type
CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
COUNT(*) AS No_of_Items,
CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data 
GROUP BY Item_Type
ORDER BY Total_Sales DESC;

SELECT Outlet_Location_Type, Item_Fat_Content,             -- Fat Content by Outlet for Total Sales
CAST(SUM(Sales) AS DECIMAL (10,2)) AS Total_Sales,
CAST(AVG(Sales) AS DECIMAL (10,1)) AS Avg_Sales,
COUNT(*) AS No_of_Items,
CAST(AVG(Rating) AS DECIMAL (10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Location_Type, Item_Fat_Content
ORDER BY Total_Sales;

SELECT Outlet_Location_Type,                             -- Fat Content for Outlet by Total Sales
   ISNULL([Low Fat], 0) AS Low_Fat,
   ISNULL([Regular], 0) AS Regular
FROM
(
SELECT Outlet_Location_Type, Item_Fat_Content,
CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT
(
SUM(Total_Sales)
FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;

SELECT Outlet_Establishment_Year,                     -- Total Sales by Outlet Establishment Year
CAST(SUM(Sales) AS DECIMAL (10,2)) AS Total_Sales,
CAST(AVG(Sales) AS DECIMAL (10,1)) AS Avg_Sales,
COUNT(*) AS No_of_Items,
CAST(AVG(Rating) AS DECIMAL (10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Total_Sales DESC;

SELECT Outlet_Size,                   -- Percentage of Sales by Outlet Size
CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
CAST(SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER() AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

SELECT Outlet_Location_Type,            -- Sales by Outlet Location
CAST(SUM(Sales) AS DECIMAL (10,2)) AS Total_Sales,
CAST(SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER() AS DECIMAL (10,2)) AS Sales_Percentage,
CAST(AVG(Sales) AS DECIMAL (10,1)) AS Avg_Sales,
COUNT(*) AS No_of_Items,
CAST(AVG(Rating) AS DECIMAL (10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

SELECT Outlet_Type,                 -- All metrics by Outlet Types
CAST(SUM(Sales) AS DECIMAL (10,2)) AS Total_Sales,
CAST(SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER() AS DECIMAL (10,2)) AS Sales_Percentage,
CAST(AVG(Sales) AS DECIMAL (10,1)) AS Avg_Sales,
COUNT(*) AS No_of_Items,
CAST(AVG(Rating) AS DECIMAL (10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;

