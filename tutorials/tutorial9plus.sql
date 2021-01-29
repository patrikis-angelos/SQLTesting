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
