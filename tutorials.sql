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
SELECT name, population, area
FROM world
WHERE population > 250000000 XOR area > 3000000; 
--9
SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2)
FROM world
WHERE continent = 'South America';
--10
SELECT name, ROUND(gdp/population, -3)
FROM world
WHERE gdp > 1000000000000;
--11
SELECT name, capital
FROM world
WHERE LENGTH(name) = LENGTH(capital);
--12
SELECT name, capital
FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1)
AND name <> capital;
--13
SELECT name
FROM world
WHERE name LIKE('%a%')
AND name LIKE('%e%')
AND name LIKE('%i%')
AND name LIKE('%o%')
AND name LIKE('%u%')
AND name NOT LIKE('% %');

--TUTORIALS 3: SELECT from Nobel
--1
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950;
--2
SELECT winner
FROM nobel
WHERE yr = 1962
AND subject = 'Literature';
--3
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein';
--4
SELECT winner
FROM nobel
WHERE subject = 'Peace'
AND yr >= 2000;
--5
SELECT * FROM nobel
WHERE subject = 'Literature'
AND yr BETWEEN 1980 AND 1989;
--6
SELECT * FROM nobel
WHERE winner IN ('Theodore Roosevelt','Woodrow Wilson','Jimmy Carter','Barack Obama');
--7
SELECT winner
FROM nobel
WHERE winner LIKE('John%');
--8
SELECT * FROM nobel
WHERE subject = 'Physics'
AND yr = 1980
OR subject = 'Chemistry'
AND yr = 1984;
--9
SELECT * FROM nobel
WHERE yr = 1980
AND subject NOT IN ('Chemistry', 'Medicine');
--10
SELECT * FROM nobel
WHERE subject = 'Medicine'
AND yr < 1910
OR subject = 'Literature'
AND yr >= 2004;
--11
SELECT * FROM nobel
WHERE winner = 'PETER GRÜNBERG';
--12
SELECT * FROM nobel
WHERE winner = 'EUGENE O\'NEILL';
--'
--13
SELECT winner, yr, subject FROM nobel
WHERE winner LIKE('Sir%')
ORDER BY yr DESC, winner;
--14
SELECT winner, subject
FROM nobel
WHERE yr=1984
ORDER BY subject IN ('Physics','Chemistry'),subject,winner;

--TUTORIAL 4: Select in Select
--1
SELECT name FROM world
WHERE population > (SELECT population FROM world
                    WHERE name='Russia');
--2
SELECT name FROM world
WHERE continent = 'Europe'
AND (gdp/population) > (SELECT (gdp/population) FROM world
                        WHERE name = 'United Kingdom');
--3
SELECT name, continent FROM world
WHERE continent IN (SELECT continent FROM world
                    WHERE name IN ('Argentina', 'Australia'))
ORDER BY name;
--4
SELECT name, population FROM world
WHERE population > (SELECT population FROM world
                    WHERE name = 'Canada')
AND population < (SELECT population FROM world
                  WHERE name = 'Poland');
--5
SELECT name, CONCAT(ROUND(population/(SELECT population FROM world
                               WHERE name = 'Germany')*100), '%') AS percentage
FROM world
WHERE continent = 'Europe';
--6
SELECT name FROM world
WHERE gdp > ALL(SELECT gdp
                FROM world
                WHERE continent = 'Europe'
                AND gdp > 0);
--7
SELECT continent, name, area FROM world AS x
WHERE area >= ALL (SELECT area FROM world AS y
                   WHERE y.continent=x.continent
                   AND population>0);
--8
SELECT continent, name FROM world AS x
WHERE name <= ALL (SELECT name FROM world AS y
                   WHERE x.continent = y.continent);
--9
SELECT name, continent, population FROM world AS x
WHERE 25000000 > ALL(SELECT population FROM world AS y
                     WHERE x.continent = y.continent);

--10
SELECT name, continent FROM world AS x
WHERE population > ALL(SELECT population*3 FROM world AS y
                       WHERE x.continent = y.continent
                       AND x.name != y.name);

-- SELECT name, continent FROM world AS x
-- WHERE population/3 > ALL(SELECT population FROM world AS y
--                           WHERE x.continent = y.continent
--                           AND population < (SELECT population FROM world AS z
--                                             WHERE y.continent = z.continent
--                                             AND population >= ALL(SELECT population FROM world AS w
--                                                                   WHERE z.continent = w.continent
--                                                                   AND population > 0)));

--TUTORIAL 5: SUM and COUND
--1
SELECT SUM(population)
FROM world;
--2
SELECT continent FROM world
GROUP BY continent;
--3
SELECT SUM(gdp) FROM world
WHERE continent = 'Africa';
--4
SELECT COUNT(name) FROM world
WHERE area >= 1000000;
--5
SELECT SUM(population) FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');
--6
SELECT continent, COUNT(name) FROM world
GROUP BY continent;
--7
SELECT continent, COUNT(name) FROM world
WHERE population >= 10000000
GROUP BY continent;
--8
SELECT continent FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000;

--TUTORIAL 6: JOIN
--1
SELECT matchid, player FROM goal 
WHERE teamid = 'GER';
--2
SELECT id,stadium,team1,team2
FROM game
WHERE id = 1012;
--3
SELECT player,teamid,stadium, mdate
FROM game 
JOIN goal 
ON (id=matchid)
WHERE teamid = 'GER';
--4
SELECT team1, team2, player FROM game
JOIN goal
ON id = matchid
WHERE player LIKE ('Mario%');
--5
SELECT player, teamid, coach, gtime FROM goal
JOIN eteam
ON goal.teamid = eteam.id
WHERE gtime<=10;
--6
SELECT game.mdate, eteam.teamname FROM game
JOIN eteam
ON game.team1 = eteam.id
WHERE coach = 'Fernando Santos';
--7
SELECT player FROM goal
JOIN game
ON goal.matchid = game.id
WHERE stadium = 'National Stadium, Warsaw';
--8
SELECT DISTINCT player FROM game
JOIN goal
ON matchid = id
WHERE teamid != 'GER'
AND (team1 = 'GER' OR team2 = 'GER');
--9
SELECT teamname, COUNT(player)
FROM eteam JOIN goal ON id=teamid
GROUP BY teamname
ORDER BY teamname;
--10
SELECT stadium, COUNT(player) FROM game
JOIN goal
ON id = matchid
GROUP BY stadium;
--11
SELECT matchid,mdate, COUNT(player)
FROM game JOIN goal ON matchid = id 
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate;
--12
SELECT matchid, mdate, COUNT(player)
FROM game JOIN goal ON id = matchid
WHERE teamid = 'GER'
GROUP BY matchid, mdate;
--13
SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
  team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
FROM game LEFT JOIN goal ON matchid = id
GROUP BY mdate, matchid, team1, team2;

-- TUTORIAL 7: MORE JOIN
--1
SELECT id, title
FROM movie
WHERE yr=1962;
--2
SELECT yr from movie
WHERE title = 'Citizen Kane';
--3
SELECT id, title, yr FROM movie
WHERE title LIKE ('%Star Trek%')
ORDER BY yr;
--4
SELECT id FROM actor
WHERE name = 'Glenn Close';
--5
SELECT id FROM movie
WHERE title = 'Casablanca';
--6
SELECT name FROM actor
JOIN casting
ON id = actorid
WHERE movieid = 11768;
--7
SELECT name FROM movie
JOIN casting ON movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE title = 'Alien';
--8
SELECT title FROM actor
JOIN casting ON actor.id = actorid
JOIN movie ON movie.id = movieid
WHERE actor.name = 'Harrison Ford';
--9
SELECT title FROM movie
JOIN casting ON movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE actor.name = 'Harrison Ford'
AND casting.ord != 1;
--10
SELECT title, name FROM movie
JOIN casting ON movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE yr = 1962
AND ord = 1;
--11
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;
--12
SELECT title, name FROM movie
JOIN casting ON movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE movie.id IN (SELECT movieid FROM casting
                   WHERE actorid = (SELECT id FROM actor
                                    WHERE name = 'Julie Andrews'))
AND casting.ord = 1;
--13
SELECT name FROM actor
JOIN casting ON id = actorid
WHERE ord = 1
GROUP BY name
HAVING COUNT(*) >= 15;
--14
SELECT title, COUNT(name) FROM movie
JOIN casting ON movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(name) DESC, title;
--15
SELECT name FROM actor
WHERE id IN (SELECT actorid FROM casting
             WHERE movieid IN (SELECT movieid FROM casting
                               WHERE actorid IN (SELECT id FROM actor
                                                 WHERE name = 'Art Garfunkel')))
AND name != 'Art Garfunkel';

--TUTORIAL 8: Using NULL
--1
SELECT teacher.name FROM teacher
LEFT JOIN dept ON teacher.dept = dept.id
WHERE dept.name IS NULL;
--2
SELECT teacher.name, dept.name
FROM teacher INNER JOIN dept
ON (teacher.dept=dept.id);
--3
SELECT teacher.name, dept.name FROM teacher
LEFT JOIN dept ON teacher.dept = dept.id;
--4
SELECT teacher.name, dept.name FROM teacher
RIGHT JOIN dept ON teacher.dept = dept.id;
--5
SELECT teacher.name, COALESCE(teacher.mobile, '07986 444 2266') FROM teacher;
--6
SELECT teacher.name, COALESCE(dept.name, 'None') FROM teacher
LEFT JOIN dept ON teacher.dept = dept.id;
--7
SELECT COUNT(name), COUNT(mobile) FROM teacher;
--8
SELECT dept.name, COUNT(teacher.name) FROM teacher
RIGHT JOIN dept ON teacher.dept = dept.id
GROUP BY dept.name;
--9
SELECT name,
       CASE WHEN dept IN (1, 2) THEN 'Sci' ELSE 'Art' END
FROM teacher;
--10
SELECT name,
       CASE WHEN dept IN (1, 2) THEN 'Sci'
            WHEN dept = 3 THEN 'Art'
            ELSE 'None' END
FROM teacher;

--TUTORIAL 9: Self JOIN
--1
SELECT COUNT(*) FROM stops;
--2
SELECT id FROM stops
WHERE name = 'Craiglockhart';
--3
SELECT stops.id, stops.name FROM stops
JOIN route ON stops.id = route.stop
WHERE num = 4
AND company = 'LRT'
ORDER BY pos;
--4
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) > 1;
--5
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE b.stop = (SELECT id FROM stops
                WHERE name = 'London Road')
AND a.stop = (SELECT id FROM stops
              WHERE name = 'Craiglockhart');
--6
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
AND stopb.name = 'London Road';
--7
SELECT DISTINCT a.company, a.num FROM route a
JOIN route b ON (a.company = b.company AND a.num = b.num)
WHERE a.stop = 115
AND b.stop = 137;
--8
SELECT DISTINCT a.company, a.num FROM route a
JOIN route b ON (a.company = b.company AND a.num = b.num)
JOIN stops stopa ON a.stop = stopa.id
JOIN stops stopb ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart'
AND stopb.name = 'Tollcross';
--9
SELECT DISTINCT stopb.name, a.company, a.num FROM route a
JOIN route b ON (a.company = b.company AND a.num = b.num)
JOIN stops stopa ON a.stop = stopa.id
JOIN stops stopb ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart'
AND a.company = 'LRT';
--10
SELECT DISTINCT a.num, a.company, stopc.name, c.num, c.company FROM route a
JOIN route b ON (a.company = b.company AND a.num = b.num)
JOIN route c ON (b.stop = c.stop)
JOIN route d ON (c.company = d.company AND c.num = d.num)
JOIN stops stopa ON a.stop = stopa.id
JOIN stops stopb ON b.stop = stopb.id
JOIN stops stopc ON c.stop = stopc.id
JOIN stops stopd ON d.stop = stopd.id
WHERE stopa.name = 'Craiglockhart'
AND stopd.name = 'Lochend'
ORDER BY a.num, b.num, stopc.id, c.num, d.num;


--BONUSE ???
--TUTORIAL 8+
--1
SELECT A_STRONGLY_AGREE
FROM nss
WHERE question='Q01'
AND institution='Edinburgh Napier University'
AND subject='(8) Computer Science';
--2
SELECT institution, subject
FROM nss
WHERE question='Q15'
AND score >= 100;
--3
SELECT institution,score
FROM nss
WHERE question='Q15'
AND subject='(8) Computer Science'
AND score < 50;
--4
SELECT subject, SUM(response)
FROM nss
WHERE question='Q22'
AND (subject='(8) Computer Science' OR subject ='(H) Creative Arts and Design')
GROUP BY subject;
--5
SELECT subject,SUM(response*A_STRONGLY_AGREE/100)
FROM nss
WHERE question='Q22'
AND (subject='(8) Computer Science' OR subject ='(H) Creative Arts and Design')
GROUP BY subject;
--6
SELECT subject, ROUND(SUM(response*A_STRONGLY_AGREE)/SUM(response))
FROM nss
WHERE question='Q22'
AND (subject='(8) Computer Science' OR subject ='(H) Creative Arts and Design')
GROUP BY subject;
--7
SELECT institution, ROUND(SUM(response*score)/SUM(response))
FROM nss
WHERE question='Q22'
AND (institution LIKE '%Manchester%')
GROUP BY institution;
--8
SELECT institution,SUM(sample), SUM(CASE WHEN subject = '(8) Computer Science' THEN sample ELSE 0 END) AS comp
FROM nss
WHERE question='Q01'
AND (institution LIKE '%Manchester%')
GROUP BY institution;

--TUTORIAL: 9-
--1
SELECT lastName, party, votes
FROM ge
WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY votes DESC
--2
SELECT party, votes,
       RANK() OVER (ORDER BY votes DESC) as posn
FROM ge
WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY party;
--3
SELECT yr,party, votes,
      RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as posn
FROM ge
WHERE constituency = 'S14000021'
ORDER BY party,yr;
--4
SELECT constituency,party, votes,
       RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) as posn
FROM ge
WHERE yr  = 2017
ORDER BY posn, constituency;
--5
SELECT constituency,party
FROM ge AS x
WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
AND yr  = 2017
AND votes >= ALL(SELECT votes FROM ge AS y
                 WHERE x.constituency = y.constituency
                 AND yr = 2017
                 AND votes > 0)
ORDER BY constituency;
--6
SELECT party, COUNT(*)
FROM ge AS x
WHERE constituency LIKE 'S%'
AND yr  = 2017
AND votes >= ALL(SELECT votes FROM ge AS y
                 WHERE x.constituency = y.constituency
                 AND yr = 2017
                 AND votes > 0)
GROUP BY party;

--TUTORIAL 9+
--1
SELECT name, DAY(whn),
confirmed, deaths, recovered
FROM covid
WHERE name = 'Spain'
AND MONTH(whn) = 3
ORDER BY whn;
--2
SELECT name, DAY(whn), confirmed,
       LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)
FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3
ORDER BY whn;
--3
SELECT name, DAY(whn),
      (confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)) AS new
FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3
ORDER BY whn;
--4
SELECT name, DATE_FORMAT(whn,'%Y-%m-%d'), 
       (confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)) AS new
FROM covid
WHERE name = 'Italy'
AND WEEKDAY(whn) = 0
ORDER BY whn;
--5
SELECT tw.name, DATE_FORMAT(tw.whn,'%Y-%m-%d'), tw.confirmed - lw.confirmed
FROM covid tw 
LEFT JOIN covid lw 
ON DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn AND tw.name=lw.name
WHERE tw.name = 'Italy'
AND WEEKDAY(tw.whn) = 0;
--6
SELECT 
   name,
   confirmed,
   RANK() OVER (ORDER BY confirmed DESC) rc,
   deaths,
   RANK() OVER (ORDER BY deaths DESC) rc
FROM covid
WHERE whn = '2020-04-20'
ORDER BY confirmed DESC;
--7
SELECT 
   world.name,
   ROUND(100000*confirmed/population,0),
   RANK() OVER (ORDER BY (confirmed/population) ASC)
FROM covid JOIN world ON covid.name=world.name
WHERE whn = '2020-04-20' AND population > 10000000
ORDER BY population DESC;
--8 In this one the data are corerct but the ordering seems off, I tried different ways od ordering my data but none worked
SELECT x.name, DATE_FORMAT(y.whn,'%Y-%m-%d'), y.confirmed - x.confirmed AS peakNewCases FROM covid AS x
JOIN covid AS y
ON x.name = y.name AND DATE_ADD(x.whn, INTERVAL 1 DAY) = y.whn
WHERE y.confirmed - x.confirmed >= 1000
AND y.confirmed - x.confirmed >= ALL(SELECT z.confirmed - w.confirmed FROM covid AS w
                                     JOIN covid AS z
                                     ON z.name = w.name AND DATE_ADD(w.whn, INTERVAL 1 DAY) = z.whn
                                     WHERE y.name = z.name)
ORDER BY DATE_FORMAT(y.whn,'%Y-%m-%d');