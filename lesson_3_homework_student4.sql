--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. 
--Вывести: класс и число потопленных кораблей.
 
select 
case 
	when class is not null
		then class
		else 'Класс не определен'
end класс,
count (t1.result)
from 
	(SELECT 
		cl.class, 
		o.result
	FROM classes cl
	full outer join ships s on cl.class = s.class
	full outer join Outcomes o on o.ship = s.name
	where result='sunk') as t1	
group by (класс, t1.result)

--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. 
--Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. 
--Вывести: класс, год.

with s_gr as 
(
select s.class,min(s.launched) from ships s group by s.class
)
SELECT 	
distinct 
  cl.class, 
  case 
	when cl.class=s.name then s.launched 
	when cl.class=s_gr.class then min
	-- не смогла добавить текст на else, вероятно,  есть формат столбца
   end год    
FROM classes cl
left join ships s  on cl.class =  s.class
left join s_gr  on cl.class =  s_gr.class


--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, 
--вывести имя класса и число потопленных кораблей.

select 
case 
	when class is not null
		then class
		else 'Класс не определен'
end класс,
count (t1.result)
from 
	(SELECT 
		cl.class, 
		o.result
	FROM classes cl
	full outer join ships s on cl.class = s.class
	full outer join Outcomes o on o.ship = s.name
	where result='sunk' _______________________) as t1		
group by (класс, t1.result)



(select count(s.name) from ships where cl.class = s.class group by s.class )>=3

--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения 
--(учесть корабли из таблицы Outcomes).




--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК,
-- имеющих наименьший объем RAM. Вывести: Maker




