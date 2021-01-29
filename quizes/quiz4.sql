--QUIZ 4
--1
SELECT region, name, population FROM bbc x 
WHERE population <= ALL (SELECT population FROM bbc y 
                         WHERE y.region=x.region 
                         AND population>0);
--2
SELECT name,region,population FROM bbc x 
WHERE 50000 < ALL (SELECT population FROM bbc y
                   WHERE x.region=y.region
                   AND y.population>0);
--3
SELECT name, region FROM bbc x
WHERE population < ALL (SELECT population/3 FROM bbc y 
                        WHERE y.region = x.region 
                        AND y.name != x.name);
--4
--Table-D
--5
SELECT name FROM bbc
WHERE gdp > (SELECT MAX(gdp) FROM bbc WHERE region = 'Africa');
--6
SELECT name FROM bbc
WHERE population < (SELECT population FROM bbc WHERE name='Russia')
AND population > (SELECT population FROM bbc WHERE name='Denmark');
--7
--Table-B
