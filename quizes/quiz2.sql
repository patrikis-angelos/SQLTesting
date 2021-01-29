-- QUIZ 2
--1
SELECT name
FROM world
WHERE name LIKE 'U%';
--2
SELECT population
FROM world
WHERE name = 'United Kingdom';
--3
--'name' should be name
--4
--Nauru	990
--5
SELECT name, population
FROM world
WHERE continent IN ('Europe', 'Asia');
--6
SELECT name FROM world
WHERE name IN ('Cuba', 'Togo');
--7
--Brazil
--Colombia
