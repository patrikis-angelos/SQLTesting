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
