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
