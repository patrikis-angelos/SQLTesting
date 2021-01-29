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
