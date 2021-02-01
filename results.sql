-- SELECT BASICS
-- 1
SELECT population
FROM world
WHERE name = 'Germany';

-- 2
SELECT name, population
FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');

--  3
SELECT name, area
FROM world
WHERE area BETWEEN 200000 and 250000;

-- SELECT NAMES
-- 1
SELECT name
FROM world
WHERE name LIKE 'Y%';

-- 2
SELECT name
FROM world
WHERE name LIKE '%y';

-- 3
SELECT name
FROM world
WHERE name LIKE '%x%';

-- 4
SELECT name
FROM world
WHERE name LIKE '%land';

-- 5
SELECT name
FROM world
WHERE name LIKE 'C%ia';

-- 6
SELECT name
FROM world
WHERE name LIKE '%oo%';

-- 7
SELECT name
FROM world
WHERE name LIKE '%a%a%a%' or name LIKE '%a%a%a%a%';

-- 8
SELECT name
FROM world
WHERE name LIKE '_t%'
ORDER BY name;

-- 9
SELECT name
FROM world
WHERE name LIKE '%o__o%';

--  10
SELECT name
FROM world
WHERE name LIKE '____';

--  11
SELECT name
FROM world
WHERE name LIKE capital;

--12
SELECT name
FROM world
WHERE capital LIKE concat(name,' City');

--  13
SELECT capital, name
FROM world
WHERE capital LIKE concat(name, '%');

-- 14
SELECT capital, name
FROM world
WHERE capital LIKE concat(name,'%') AND capital <> name

-- 15
SELECT name, REPLACE(capital,name,'')
FROM world
WHERE capital LIKE concat(name,'%') AND capital <> name

-- SELECT from world
-- 1
SELECT name, continent, population
FROM world

-- 2
SELECT name
FROM world
WHERE population > 200000000

-- 3
SELECT name, gdp/population
FROM world
WHERE population > 200000000

-- 4
SELECT name, population/1000000
FROM world
WHERE continent = 'South America'

-- 5
SELECT name, population
FROM world
WHERE name IN ( 'France', 'Germany', 'Italy')

-- 6
SELECT name
FROM world
WHERE name LIKE '%United%'

-- 7
SELECT name, population, area
FROM world
WHERE area > 3000000 OR population > 250000000

-- 8
SELECT name, population, area
FROM world
WHERE (area > 3000000 OR population > 250000000) AND NOT (area > 3000000 AND population > 250000000)

-- 9
SELECT name, ROUND(population/1000000,2), ROUND(gdp/1000000000,2)
FROM world
WHERE continent = 'South America'

-- 10
SELECT name, ROUND(gdp/population, -3)
FROM world
WHERE gdp > 1000000000000

-- 11
SELECT name, capital
FROM world
WHERE LENGTH(name) = LENGTH(capital)

-- 12
SELECT name, capital
FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1) AND name <> capital

-- 13
SELECT name
FROM world
WHERE name LIKE '%a%' AND name LIKE '%e%' AND name LIKE '%i%' AND name LIKE '%o%' AND name LIKE '%u%' AND name NOT LIKE '% %'


-- SELECT from Nobel
-- 1
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950

--  2
SELECT winner
FROM nobel
WHERE yr = 1962
  AND subject = 'Literature'

-- 3
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein'

--  4
SELECT winner
FROM nobel
WHERE subject = 'Peace' AND yr >= 2000

-- 5
SELECT yr, subject, winner
FROM nobel
WHERE subject = 'Literature' AND yr BETWEEN 1980 AND 1989

-- 6
SELECT *
FROM nobel
WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter', 'Barack Obama')

-- 7
SELECT winner
FROM nobel
WHERE winner LIKE 'John%'

-- 8
SELECT *
FROM nobel
WHERE (subject='Physics' AND yr=1980) OR (subject = 'Chemistry' AND yr=1984)

-- 9
SELECT yr, subject , winner
FROM nobel
WHERE yr = 1980 AND subject NOT IN ('Chemistry','Medicine')

-- 10
SELECT yr, subject, winner
FROM nobel
WHERE (subject = 'Medicine' AND yr < 1910) OR (subject =  'Literature' AND yr >= 2004)

-- 11
SELECT *
FROM nobel
WHERE winner = 'PETER GRÜNBERG'

-- 12
SELECT *
FROM nobel
WHERE winner = "EUGENE O\'NEILL";

-- 13
SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC;

-- 14
SELECT winner, subject
FROM nobel
WHERE yr=1984
ORDER BY subject
IN ('Physics','Chemistry'), subject , winner

-- SELECT within SELECT 
-- 1
SELECT name
FROM world
WHERE population >
     (SELECT population
FROM world
WHERE name='Russia')

-- 2
SELECT name
FROM world
WHERE gdp/population > (SELECT gdp/population
  FROM world
  WHERE name = 'United Kingdom') AND continent = 'Europe'

-- 3
SELECT name, continent
FROM world
WHERE continent IN (SELECT continent
FROM world
WHERE name IN ('Argentina','Australia'))
ORDER BY name

-- 4
SELECT name, population
FROM world
WHERE population > (SELECT population
  FROM world
  WHERE name = 'Canada') AND population < (SELECT population
  FROM world
  WHERE name = 'Poland')

-- 5
SELECT name, CONCAT(ROUND(population/(SELECT population
  FROM world
  WHERE name = 'Germany')*100, 0), '%')
FROM world
WHERE continent = 'Europe'

-- 6
SELECT name
FROM world
WHERE gdp >= ALL(SELECT gdp
  FROM world
  WHERE gdp >=0 AND continent = 'Europe') AND continent != 'Europe'

-- 7
SELECT continent, name, area
FROM world x
WHERE area >= ALL
    (SELECT area
FROM world y
WHERE y.continent=x.continent
  AND area>0)

-- 8
SELECT continent, name
FROM world x
WHERE name <= ALL
    (SELECT name
FROM world y
WHERE y.continent=x.continent)

-- 9
SELECT name, continent, population
FROM world x
WHERE 25000000  > ALL(SELECT population
FROM world y
WHERE x.continent = y.continent AND y.population > 0)

-- 10
SELECT name, continent
FROM world x
WHERE population > ALL(SELECT population*3
FROM world y
WHERE x.continent = y.continent AND population > 0 AND y.name != x.name)

-- SUM & COUNT 
-- 1
SELECT SUM(population)
FROM world

-- 2
SELECT DISTINCT continent
FROM world

-- 3
SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa'

-- 4
SELECT COUNT (name)
FROM world
WHERE area > 1000000

-- 5
SELECT SUM(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania')

-- 6
SELECT continent, COUNT(name)
FROM world
GROUP BY continent

-- 7
SELECT continent, COUNT(name)
FROM world
WHERE population > 10000000
GROUP BY continent

-- 8
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) > 100000000

-- JOIN 
-- 1
SELECT matchid, player
FROM goal
WHERE  teamid = 'GER'

-- 2
SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012

-- 3
SELECT team1, team2, player
FROM game JOIN goal ON (id=matchid AND player LIKE ('Mario%'))

-- 4
SELECT player, teamid, coach, gtime
FROM goal JOIN eteam ON (gtime <= 10 AND teamid = id)

-- 5
SELECT mdate, teamname
FROM game JOIN eteam ON (team1=eteam.id AND coach = 'Fernando Santos')

-- 6
SELECT player
FROM game JOIN goal ON (stadium = 'National Stadium, Warsaw' AND id = matchid)

-- 7
SELECT player
FROM game JOIN goal ON (stadium = 'National Stadium, Warsaw' AND id = matchid)

-- 8
SELECT DISTINCT player
FROM game JOIN goal ON matchid = id
WHERE ((team1='GER' OR team2='GER') AND teamid!='GER')

-- 9
SELECT teamname, COUNT(player)
FROM eteam JOIN goal ON id=teamid
GROUP BY teamname

-- 10
SELECT stadium, COUNT(player)
FROM game JOIN goal ON matchid=id
GROUP BY stadium

-- 11
SELECT matchid, mdate, COUNT(player)
FROM game JOIN goal ON matchid = id
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP B
Y matchid, mdate

-- 12
SELECT matchid, mdate, COUNT(player)
FROM goal JOIN game ON id=matchid
WHERE teamid = 'GER'
GROUP BY matchid,mdate

-- 13
SELECT mdate,
  team1,
  SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
  team2,
  SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2
FROM
  game LEFT JOIN goal ON (id = matchid)
GROUP BY mdate,team1,team2
ORDER BY mdate, matchid, team1, team2

-- MORE JOIN 
-- 1
SELECT id, title
FROM movie
WHERE yr=1962

-- 2
SELECT yr
FROM movie
WHERE title = 'Citizen Kane'

-- 3
SELECT id, title, yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr

-- 4
SELECT id
FROM actor
WHERE name = 'Glenn Close'

-- 5
SELECT id
FROM movie
WHERE title = 'Casablanca'

-- 6
SELECT name
FROM actor, casting
WHERE id=actorid AND movieid = 11768

-- 7
SELECT name
FROM actor, casting
WHERE id=actorid AND movieid = (SELECT id
  FROM movie
  WHERE title = 'Alien')

-- 8
SELECT title
FROM movie JOIN casting ON (id=movieid AND actorid = (SELECT id
    FROM actor
    WHERE name = 'Harrison Ford'))

-- 9
SELECT title
FROM movie JOIN casting ON (id=movieid AND actorid = (SELECT id
    FROM actor
    WHERE name = 'Harrison Ford' AND ord != 1))

-- 10
SELECT title, name
FROM movie JOIN casting ON (id=movieid)
  JOIN actor ON (actor.id = actorid)
WHERE ord=1 AND yr = 1962

-- 11
SELECT yr, COUNT(title)
FROM
  movie JOIN casting ON movie.id=movieid
  JOIN actor ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

-- 12
SELECT title, name
FROM movie
  JOIN casting x ON movie.id = movieid
  JOIN actor ON actor.id =actorid
WHERE ord=1 AND movieid IN
(SELECT movieid
  FROM casting y
    JOIN actor ON actor.id=actorid
  WHERE name='Julie Andrews')

-- 13
SELECT name
FROM actor JOIN casting ON (id=actorid AND (SELECT COUNT(ord)
    FROM casting
    WHERE actorid = actor.id AND ord=1)>=15)
GROUP BY name

-- 14
SELECT title, COUNT(actorid)
FROM movie
  JOIN casting ON movie.id = movieid
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(actorid) DESC, title

-- 15
SELECT DISTINCT name
FROM actor JOIN casting ON id=actorid
WHERE movieid IN (SELECT movieid
  FROM casting JOIN actor ON (actorid=id AND name='Art Garfunkel')) AND name != 'Art Garfunkel'

-- NULL 
-- 1
SELECT name
FROM teacher
WHERE dept IS NULL

-- 2
SELECT teacher.name,
  dept.name
FROM teacher
  INNER JOIN dept ON (teacher.dept = dept.id)

-- 3
SELECT teacher.name, dept.name
FROM teacher LEFT JOIN dept
  ON (teacher.dept=dept.id)

-- 4
SELECT teacher.name, dept.name
FROM teacher RIGHT JOIN dept
  ON (teacher.dept=dept.id)

-- 5
SELECT COALESCE(teacher.name, 'NONE'), COALESCE(dept.name, 'None')
FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id)

-- 6
SELECT COUNT(name), COUNT(mobile)
FROM teacher

-- 7
SELECT COUNT(name), COUNT(mobile)
FROM teacher

-- 8
SELECT dept.name, COUNT(teacher.name)
FROM teacher RIGHT JOIN dept ON (teacher.dept=dept.id)
GROUP BY dept.name

-- 9
SELECT teacher.name,
  CASE WHEN dept.id = 1 THEN 'Sci'
     WHEN dept.id = 2 THEN 'Sci'
     ELSE 'Art' END
FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id)

-- 10
SELECT teacher.name,
  CASE 
WHEN dept.id = 1 THEN 'Sci'
WHEN dept.id = 2 THEN 'Sci'
WHEN dept.id = 3 THEN 'Art'
ELSE 'None' END
FROM teacher LEFT JOIN dept ON (dept.id=teacher.dept)

-- SELF JOIN
-- 1
SELECT COUNT(name)
FROM stops

-- 2
SELECT id
FROM stops
WHERE name = 'Craiglockhart'

-- 3
SELECT id, name
FROM stops
  JOIN route
  ON id = stop
WHERE num = '4' AND company = 'LRT';

-- 4
SELECT company, num, COUNT(*) AS cnt
FROM route
WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING cnt=2

-- 5
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop=149

-- 6
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road'

-- 7
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company =b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Haymarket' AND stopb.name='Leith'

-- 8
SELECT DISTINCT a.company, a.num
FROM route a
  JOIN route b ON (a.num=b.num AND a.company=b.company)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross'

-- 9
SELECT DISTINCT stopb.name, a.company, a.num
FROM route a
  JOIN route b
  ON a.company = b.company AND a.num = b.num
  JOIN stops stopa ON a.stop = stopa.id
  JOIN stops stopb ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart';

-- 10
SELECT DISTINCT x.num, x.company, name, y.num, y.company
FROM(SELECT a.num, a.company, b.stop
  FROM route a
    JOIN route b
    ON a.num = b.num AND a.company = b.company
      AND a.stop != b.stop
  WHERE a.stop = (SELECT id
  from stops
  WHERE name ='Craiglockhart')) AS x
  JOIN (SELECT c.num, c.company, c.stop
  FROM route c
    JOIN route d
    ON c.num = d.num AND c.company = d.company
      AND c.stop != d.stop
  WHERE d.stop =(SELECT id
  FROM stops
  WHERE name = 'Lochend')) AS y
  ON x.stop = y.stop
  JOIN stops ON x.stop = stops.id
ORDER BY x.num,stops.name,y.num