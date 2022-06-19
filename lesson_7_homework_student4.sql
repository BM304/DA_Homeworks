--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3: Сделать тестовый проект с БД (sqlite3, project name: task1_7). В таблицу table1 записать 1000 строк с случайными значениями (3 колонки, тип int) от 0 до 1000.
-- Далее построить гистаграмму распределения этих трех колонко
request = "CREATE TABLE table1(column1 int, column2 int, column3 int)"
c.execute (request)
tables = c.fetchall()
-- проерка наличия таблицы
pd.read_sql_query("select * from table1", conn)

-- заполнение - не сработало((, выдавал синт. ошибку, не разобралась 
np.WHILE (i<1001,
  i=i+1
  request="INSERT into table1 values (random.randint(0,1000),random.randint(0,1000),random.randint(0,1000))"
  c.execute (request)
  tables = c.fetchall()
 )
-- проерка содержимого таблицы
pd.read_sql_query("select * from table1", conn)
-- вывода нет(  



--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/
select  email 
from (
select  email, count( email) as c
from person 
group by  email
) a 
where c > 1
/*Результат
Accepted
Runtime: 348 ms
Your input
{"headers": {"Person": ["id", "email"]}, "rows": {"Person": [[1, "a@b.com"], [2, "c@d.com"], [3, "a@b.com"]]}}
Output
{"headers": ["EMAIL"], "values": [["a@b.com"]]}
Expected
{"headers": ["Email"], "values": [["a@b.com"]]}
*/

--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/
select
  e.name Employee 
from Employee e
where e.salary> (select em.salary from Employee em where e.managerId=em.Id)
/* Результат
Accepted
Runtime: 327 ms
Your input
{"headers": {"Employee": ["id", "name", "salary", "managerId"]}, "rows": {"Employee": [[1, "Joe", 70000, 3], [2, "Henry", 80000, 4], [3, "Sam", 60000, null], [4, "Max", 90000, null]]}}
Output
{"headers": ["EMPLOYEE"], "values": [["Joe"]]}
Expected
{"headers": ["Employee"], "values": [["Joe"]]}
*/


--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/
select
    score,
    dense_RANK ( ) OVER (order by  score desc) rank
from Scores
order by score desc  

/* Результат
Accepted
Runtime: 346 ms
Your input
{"headers": {"Scores": ["id", "score"]}, "rows": {"Scores": [[1, 3.50], [2, 3.65], [3, 4.00], [4, 3.85], [5, 4.00], [6, 3.65]]}}
Output
{"headers": ["SCORE", "RANK"], "values": [[4.0, 1], [4.0, 1], [3.85, 2], [3.65, 3], [3.65, 3], [3.5, 4]]}
Expected
{"headers": ["score", "rank"], "values": [[4.00, 1], [4.00, 1], [3.85, 2], [3.65, 3], [3.65, 3], [3.50, 4]]}
*/


--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/
select 
    firstName,
    lastName,
    city,
    state 
from person
left join address on person.personId = address.personId

/* Результат
Accepted
Runtime: 493 ms
Your input
{"headers":{"Person":["personId","lastName","firstName"],"Address":["addressId","personId","city","state"]},"rows":{"Person":[[1,"Wang","Allen"],[2,"Alice","Bob"]],"Address":[[1,2,"New York City","New York"],[2,3,"Leetcode","California"]]}}
Output
{"headers": ["FIRSTNAME", "LASTNAME", "CITY", "STATE"], "values": [["Bob", "Alice", "New York City", "New York"], ["Allen", "Wang", null, null]]}
Expected
{"headers": ["firstName", "lastName", "city", "state"], "values": [["Allen", "Wang", null, null], ["Bob", "Alice", "New York City", "New York"]]}
*/
