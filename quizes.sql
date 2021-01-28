-- QUIZ 1
--1
SELECT name, population
FROM world
WHERE population BETWEEN 1000000 AND 1250000;
--2
--Table-E
--3
SELECT name FROM world
WHERE name LIKE '%a' OR name LIKE '%l';
--4
--Table C
--5
--Tbale C
--6
SELECT name, area, population
FROM world
WHERE area > 50000 AND population < 10000000;
--7
SELECT name, population/area
FROM world
WHERE name IN ('China', 'Nigeria', 'France', 'Australia');

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

--QUIZ 3
--1
SELECT winner FROM nobel
WHERE winner LIKE 'C%' AND winner LIKE '%n';
--2
SELECT COUNT(subject) FROM nobel
WHERE subject = 'Chemistry'
AND yr BETWEEN 1950 and 1960;
--3
SELECT COUNT(DISTINCT yr) FROM nobel
WHERE yr NOT IN (SELECT DISTINCT yr FROM nobel WHERE subject = 'Medicine');
--4
--Medicine	Sir John Eccles
--Medicine	Sir Frank Macfarlane Burnet
--5
SELECT yr FROM nobel
WHERE yr NOT IN(SELECT yr 
                FROM nobel
                WHERE subject IN ('Chemistry','Physics'));
--6
SELECT DISTINCT yr
FROM nobel
WHERE subject='Medicine' 
AND yr NOT IN(SELECT yr FROM nobel 
                WHERE subject='Literature')
AND yr NOT IN (SELECT yr FROM nobel
                WHERE subject='Peace');

--7
--Chemistry	 1
--Literature 1
--Medicine	 2
--Peace	     1
--Physics	 1