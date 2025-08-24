-- "1.calcuate the following fields from the Year	Month (#)	Day  fields ( First Create a Date Field from Year , Month , Day fields)"

SELECT 
    `Year` AS Year,
    CAST(`Month (#)` AS UNSIGNED) AS MonthNo,
    MONTHNAME(STR_TO_DATE(CONCAT(`Year`, '-', `Month (#)`, '-', `Day`),
                    '%Y-%m-%d')) AS MonthFullName,
    CONCAT('Q',
            QUARTER(STR_TO_DATE(CONCAT(`Year`, '-', `Month (#)`, '-', `Day`),
                        '%Y-%m-%d'))) AS Quarter,
    DATE_FORMAT(STR_TO_DATE(CONCAT(`Year`, '-', `Month (#)`, '-', `Day`),
                    '%Y-%m-%d'),
            '%Y-%b') AS YearMonth,
    DAYOFWEEK(STR_TO_DATE(CONCAT(`Year`, '-', `Month (#)`, '-', `Day`),
                    '%Y-%m-%d')) AS WeekdayNo,
    DAYNAME(STR_TO_DATE(CONCAT(`Year`, '-', `Month (#)`, '-', `Day`),
                    '%Y-%m-%d')) AS WeekdayName,
    CASE
        WHEN CAST(`Month (#)` AS UNSIGNED) >= 4 THEN CAST(`Month (#)` AS UNSIGNED) - 3
        ELSE CAST(`Month (#)` AS UNSIGNED) + 9
    END AS FinancialMonth,
    CASE
        WHEN CAST(`Month (#)` AS UNSIGNED) BETWEEN 4 AND 6 THEN 'Q1'
        WHEN CAST(`Month (#)` AS UNSIGNED) BETWEEN 7 AND 9 THEN 'Q2'
        WHEN CAST(`Month (#)` AS UNSIGNED) BETWEEN 10 AND 12 THEN 'Q3'
        ELSE 'Q4'
    END AS FinancialQuarter
FROM
    `maindata`;

--  2. Find the load Factor percentage on a yearly , Quarterly , Monthly basis ( Transported passengers / Available seats)


describe maindata;

SELECT 
    Year,
    ROUND((SUM(`# Transported Passengers`) / SUM(`# Available Seats`)) * 100, 2) AS Load_Factor_Percentage
FROM 
    maindata
GROUP BY 
    Year
ORDER BY 
    Year;
    
  SELECT 
    Year,
    CASE
        WHEN `Month (#)` BETWEEN 1 AND 3 THEN 'Q1'
        WHEN `Month (#)` BETWEEN 4 AND 6 THEN 'Q2'
        WHEN `Month (#)` BETWEEN 7 AND 9 THEN 'Q3'
        WHEN `Month (#)` BETWEEN 10 AND 12 THEN 'Q4'
    END AS Quarter,
    ROUND((SUM(`# Transported Passengers`) / SUM(`# Available Seats`)) * 100, 2) AS Load_Factor_Percentage
FROM 
    maindata
GROUP BY 
    Year, Quarter
ORDER BY 
    Year, Quarter;
    
SELECT 
    Year,
    `Month (#)` AS Month,
    ROUND((SUM(`# Transported Passengers`) / SUM(`# Available Seats`)) * 100, 2) AS Load_Factor_Percentage
FROM 
    maindata
GROUP BY 
    Year, `Month (#)`
ORDER BY 
    Year, `Month (#)`;
    
    describe maindata;

-- 3. Find the load Factor percentage on a Carrier Name basis ( Transported passengers / Available seats)

SELECT 
    `Carrier Name`,
    ROUND((SUM(`# Transported Passengers`) / SUM(`# Available Seats`)) * 100, 2) AS Load_Factor_Percentage
FROM 
    maindata
GROUP BY 
    `Carrier Name`
ORDER BY 
    Load_Factor_Percentage DESC;
    
    -- 4. Identify Top 10 Carrier Names based passengers preference 
    
    SELECT 
    `Carrier Name`,
    SUM(`# Transported Passengers`) AS Total_Passengers
FROM 
    maindata
GROUP BY 
    `Carrier Name`
ORDER BY 
    Total_Passengers DESC
LIMIT 10;

-- 5. Display top Routes ( from-to City) based on Number of Flights 

SELECT 
    CONCAT(`Origin City`, ' - ', `Destination City`) AS Route,
    SUM(`# Departures Performed`) AS Total_Flights
FROM 
    maindata
GROUP BY 
    Route
ORDER BY 
    Total_Flights DESC
LIMIT 10;

-- 6. Identify the how much load factor is occupied on Weekend vs Weekdays.

SELECT 
    CASE 
        WHEN DAYOFWEEK(STR_TO_DATE(CONCAT(Year, '-', `Month (#)`, '-', Day), '%Y-%m-%d')) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS Day_Type,
    ROUND((SUM(`# Transported Passengers`) / SUM(`# Available Seats`)) * 100, 2) AS Load_Factor_Percentage
FROM 
    maindata
GROUP BY 
    Day_Type
ORDER BY 
    Day_Type;
    
    -- 7. Identify number of flights based on Distance group
    
SELECT 
    distance AS Distance_Group,
    COUNT(`# Departures Performed`) AS Number_of_Flights
FROM 
    maindata
GROUP BY 
    distance
ORDER BY 
    distance
LIMIT 0, 1000;

    
    DESCRIBE maindata;
    
    


    
    




















