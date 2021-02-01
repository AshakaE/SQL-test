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