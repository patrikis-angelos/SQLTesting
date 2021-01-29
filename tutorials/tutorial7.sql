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
