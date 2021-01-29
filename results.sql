-- number 1
SELECT population FROM world
WHERE name = 'Germany';

-- number 2
SELECT name, population FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');