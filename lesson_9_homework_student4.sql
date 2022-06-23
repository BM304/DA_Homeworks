--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem +Решено
select 
    name, 
    case
        when  (marks between 90 and 100 ) then 10
        when  (marks between 80 and 89 ) then 9
        when  (marks between 70 and 89 ) then 8
    end Grade,
    marks
from Students
where marks>=70
union all
select 
    null, 
    case
        when  (marks between 60 and 69 ) then 7
        when  (marks between 50 and 59 ) then 6
        when  (marks between 40 and 59 ) then 5
        when  (marks between 30 and 39 ) then 4
        when  (marks between 20 and 29 ) then 3
        when  (marks between 10 and 19 ) then 2
        when  (marks between 0 and 9 ) then 1
    end Grade,
    marks
from Students
where marks<70
order by Grade desc, name, marks;


--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem - добилась только корректного положения в массиве (1 в столбце в которому относиться имя, промежуточные данне не стала удалять), не решено 

SELECT * FROM
(   select concat(name,OCCUPATION) a, name,OCCUPATION  from OCCUPATIONS 
    where OCCUPATION='Doctor'
    union all 
    select concat(name,OCCUPATION) a, name,OCCUPATION  from OCCUPATIONS 
    where OCCUPATION='Professor'
    union all 
    select concat(name,OCCUPATION) a, name,OCCUPATION  from OCCUPATIONS 
    where OCCUPATION='Singer'
    union all 
    select concat(name,OCCUPATION) a, name,OCCUPATION  from OCCUPATIONS 
    where OCCUPATION='Actor'
)
PIVOT
(
  COUNT(OCCUPATION) 
  FOR OCCUPATION IN ('Doctor', 'Professor','Singer','Actor')
)
ORDER BY name;

--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem  +Решено
SELECT DISTINCT CITY
FROM STATION
WHERE NOT (CITY LIKE 'A%' OR  CITY  LIKE 'E%' OR CITY  LIKE 'I%' OR CITY  LIKE 'O%' OR CITY  LIKE 'U%');


--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem +Решено
SELECT DISTINCT CITY
FROM STATION
WHERE NOT (CITY LIKE '%A' OR  CITY  LIKE '%E' OR CITY  LIKE '%I' OR CITY  LIKE '%O' OR CITY  LIKE '%U' 
or CITY LIKE '%a' OR  CITY  LIKE '%e' OR CITY  LIKE '%i' OR CITY  LIKE '%o' OR CITY  LIKE '%u');


--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem +Решено
SELECT DISTINCT CITY
FROM STATION
WHERE NOT (CITY LIKE '%A' OR  CITY  LIKE '%E' OR CITY  LIKE '%I' OR CITY  LIKE '%O' OR CITY  LIKE '%U' 
or CITY LIKE '%a' OR  CITY  LIKE '%e' OR CITY  LIKE '%i' OR CITY  LIKE '%o' OR CITY  LIKE '%u') 
or NOT (CITY LIKE 'A%' OR  CITY  LIKE 'E%' OR CITY  LIKE 'I%' OR CITY  LIKE 'O%' OR CITY  LIKE 'U%' 
or CITY LIKE 'a%' OR  CITY  LIKE 'e%' OR CITY  LIKE 'i%' OR CITY  LIKE 'o%' OR CITY  LIKE 'u%');


--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem + Решено
SELECT DISTINCT CITY
FROM STATION
WHERE NOT (CITY LIKE '%A' OR  CITY  LIKE '%E' OR CITY  LIKE '%I' OR CITY  LIKE '%O' OR CITY  LIKE '%U' 
or CITY LIKE '%a' OR  CITY  LIKE '%e' OR CITY  LIKE '%i' OR CITY  LIKE '%o' OR CITY  LIKE '%u') 
and NOT (CITY LIKE 'A%' OR  CITY  LIKE 'E%' OR CITY  LIKE 'I%' OR CITY  LIKE 'O%' OR CITY  LIKE 'U%' 
or CITY LIKE 'a%' OR  CITY  LIKE 'e%' OR CITY  LIKE 'i%' OR CITY  LIKE 'o%' OR CITY  LIKE 'u%');


--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem + Решено
select 
name
from Employee 
where salary>2000 and months<10
order by employee_id;


--task8  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem + Решено (повтор)
select 
    name, 
    case
        when  (marks between 90 and 100 ) then 10
        when  (marks between 80 and 89 ) then 9
        when  (marks between 70 and 89 ) then 8
    end Grade,
    marks
from Students
where marks>=70
union all
select 
    null, 
    case
        when  (marks between 60 and 69 ) then 7
        when  (marks between 50 and 59 ) then 6
        when  (marks between 40 and 59 ) then 5
        when  (marks between 30 and 39 ) then 4
        when  (marks between 20 and 29 ) then 3
        when  (marks between 10 and 19 ) then 2
        when  (marks between 0 and 9 ) then 1
    end Grade,
    marks
from Students
where marks<70
order by Grade desc, name, marks;