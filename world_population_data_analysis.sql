create database world_population;
use world_population;

-- table is created having the field exactly same as the fileds in the csv file

create table world_data(
	pos int(30) ,
    CCA3 varchar(10),
    Country_or_Territory varchar(50),
    capital varchar(100),
    continent varchar(100),
    2022_population bigint(255),
    2020_population bigint(255),
    2015_population bigint(255),
    2010_population bigint(255),
    2000_population bigint(255),
    1990_population bigint(255),
    1980_population bigint(255),
    1970_population bigint(255),
    area bigint(255),
    density double(10,4),
    growth_rate float(4),
    world_population_percentage float(2)
);

-- import the data from the csv file and displaying the whole data 

select * from world_data;

-- Q 1. Total current world population (2022)

SELECT sum(2022_population) as total_current_population from world_data ; 

-- Q 2. Total world population in each year

SELECT sum(2022_population) as 2022_total,
sum(2020_population) as 2020_total,
sum(2015_population) as 2015_total,
sum(2010_population) as 2010_total,
sum(2000_population) as 2000_total,
sum(1990_population) as 1990_total,
sum(1980_population) as 1980_total,
sum(1970_population) as 1970_total
from world_data;

-- Q 3. Which country has the highest population with a percentage contribution to the total population?

select Country_or_Territory,2022_population,(
(select 2022_population from world_data where pos=1)/
(select sum(2022_population) from world_data)*100) 
as percentage_of_total
from world_data where pos=1;

-- Q 4. Which country has the lowest population with a percentage contribution in total population?

select Country_or_Territory,2022_population,(
(select 2022_population from world_data order by pos desc limit 1)/
(select sum(2022_population) from world_data)*100) 
as percentage_of_total from world_data order by pos desc limit 1;

-- Q 5. Retrieve the top 10 countries by population in 2022

SELECT pos, Country_or_Territory, 2022_population
FROM world_data
ORDER BY 2022_population DESC
LIMIT 10;

-- Q 6. Show the countries with the highest and lowest population densities in 2022

-- Highest Population density
SELECT Country_or_Territory, 2022_population, area, density
FROM world_data
ORDER BY density DESC
LIMIT 1; 

-- Lowest Population density
SELECT Country_or_Territory, 2022_population, area, density
FROM world_data
ORDER BY density ASC
LIMIT 1; 

-- Q 7. Find the countries where the population has decreased from 2015 to 2022 and show the percentage decrease as well.

SELECT Country_or_Territory,
(2015_population-2022_population)/2015_population*100 as percentage_decrease 
FROM world_data
WHERE 2015_population > 2022_population order by percentage_decrease desc;

-- Q 8. Calculate the average population growth rate of countries between 2010 and 2022

SELECT Country_or_Territory,
(2022_population-2010_population)/2010_population*100 as avg_growth_rate 
FROM world_data
order by avg_growth_rate desc;

-- Q 9.Identify the countries with the highest and lowest population growth rates

-- Highest Growth rate

SELECT Country_or_Territory, growth_rate
FROM world_data
ORDER BY growth_rate DESC
LIMIT 1; 

-- Lowest Growth rate in last decade

SELECT Country_or_Territory, growth_rate
FROM world_data
ORDER BY growth_rate ASC
LIMIT 1; 

-- Q 10. Show the top 5 countries that had the highest population growth rate between 2000 and 2022

SELECT Country_or_Territory,
(2022_population-2000_population)/2000_population*100 as population_growth_rate
FROM world_data
ORDER BY population_growth_rate DESC
LIMIT 5;

-- Q 11. Determine the top 3 countries by area size and their respective population densities in 2022

SELECT Country_or_Territory, area, density
FROM world_data
ORDER BY area DESC
LIMIT 3;

-- Q 12. Calculate percentage contribution of each country to the world population in 2022

SELECT Country_or_Territory,
(2022_population / (SELECT SUM(2022_population) FROM world_data)) * 100 
AS Percentage_Contribution
FROM world_data
order by Percentage_Contribution desc;

-- Q 13. Find countries whose population in 2022 is greater than the average population of all countries in 2022

SELECT Country_or_Territory, 2022_population
FROM world_data
WHERE 2022_population > (
    SELECT AVG(2022_population)
    FROM world_data
);
 
 -- Q 14. Show countries where the population in 2022 is less than the population in 2020
 
SELECT Country_or_Territory, 2022_population
FROM world_data 
WHERE 2020_population > 2022_population;

-- Q 15. Find the country with the smaller population in 2022 compared to the average population in 2022

SELECT Country_or_Territory, 2022_population
FROM world_data
WHERE 2022_population < (
    SELECT avg(2022_population)
    FROM world_data
);
 
 -- Q 16. List countries with a population in 2022 that is higher than 
 -- the average population growth rate of all countries between 2010 and 2022.
 
SELECT Country_or_territory, 2022_population
FROM world_data
WHERE 2022_population > (
    SELECT AVG(growth_rate)
    FROM world_data
    WHERE 2022_population IS NOT NULL AND 2010_population IS NOT NULL
);

-- Q 17. Retrieve the top 5 countries by population in 2022 within Europe.

SELECT Country_or_Territory, 2022_population
FROM world_data
WHERE continent = 'Europe'
ORDER BY 2022_population DESC
LIMIT 5;

-- Q 18. Show countries where the population growth rate between 2010 and 2022 is above the global average growth rate for that period.

SELECT Country_or_Territory, growth_rate
FROM world_data w1
WHERE growth_rate > (
    SELECT AVG(growth_rate)
    FROM world_data w2
    WHERE w1.continent = w2.continent
      AND 2010_population IS NOT NULL AND 2022_population IS NOT NULL
);








