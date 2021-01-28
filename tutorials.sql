-- Tutorial 0: Select Basics
-- 1
SELECT population FROM world
WHERE name = 'Germany';
--2
SELECT name, population FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');
--3
SELECT name, area FROM world
WHERE area BETWEEN 200000 AND 250000;

-- Tutorial 1: Select Names
--1
SELECT name FROM world
WHERE name LIKE 'Y%';
--2
SELECT name FROM world
WHERE name LIKE '%y';
--3
SELECT name FROM world
WHERE name LIKE '%x%';
--4
SELECT name FROM world
WHERE name LIKE '%land';
--5
SELECT name FROM world
WHERE name LIKE 'c%ia';
--6
SELECT name FROM world
WHERE name LIKE '%oo%';
--7
SELECT name FROM world
WHERE name LIKE '%a%a%a%';
--8
SELECT name FROM world
WHERE name LIKE '_t%'
ORDER BY name;
--9
SELECT name FROM world
WHERE name LIKE '%o__o%';
--10
SELECT name FROM world
WHERE name LIKE '____';
--11
SELECT name
FROM world
WHERE name LIKE capital;
--12
SELECT name
FROM world
WHERE capital LIKE CONCAT(name, ' city');
--13
SELECT capital, name
FROM world
WHERE capital LIKE CONCAT('%', name, '%');
--14
SELECT capital, name
FROM world
WHERE capital LIKE CONCAT(name, '_%');
--15
SELECT name, REPLACE(capital, name, '') AS extension
FROM world
WHERE capital LIKE CONCAT(name, '_%');

-- Tutorial 2: Select from world

--1
SELECT name, continent, population
FROM world;
--2
SELECT name
FROM world
WHERE population > 200000000;
--3
SELECT name, (gdp/population) AS 'per capita GDP'
FROM world
WHERE population > 200000000;
--4
SELECT name, (population/1000000) AS 'population per million'
FROM world
WHERE continent = 'South America';
--5
SELECT name, population
FROM world
WHERE name IN ('France', 'Germany', 'Italy');
--6
SELECT name
FROM world
WHERE name LIKE '%United%'
--7
SELECT name, population, area
FROM world
WHERE population > 250000000 OR area > 3000000;
--8
SELECT name, population, ares
FROM world
WHERE population > 250000000 XOR area > 3000000; 
--9
--10
--11
--12
--13