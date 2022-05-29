-- Задание 20: Найдите средний размер hd PC каждого из тех производителей, которые выпускают и принтеры. Вывести: maker, средний размер HD.

select pr.maker, avg(pc.hd) 
from pc
join product pr  on pr.model =pc.model  
where  pr.maker in 
	(select   pr.maker from product pr
	 where pr.type='Printer')
group by pr.maker

--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

-- Задание 1: Вывести name, class по кораблям, выпущенным после 1920
select 
	s.name,
	s.class 
from Ships s 
where s.launched >1920

-- Задание 2: Вывести name, class по кораблям, выпущенным после 1920, но не позднее 1942
select 
	s.name,
	s.class
from Ships s 
where (s.launched >1920) and (s.launched <=1942) 

-- Задание 3: Какое количество кораблей в каждом классе. Вывести количество и class
select 
	s.class,
	count(s.name)
from Ships s 
group by s.class

-- Задание 4: Для классов кораблей, калибр орудий которых не менее 16, укажите класс и страну. (таблица classes)
--
select 
	cl.class,
	cl.country 
from classes cl
where cl.bore >=16

-- Задание 5: Укажите корабли, потопленные в сражениях в Северной Атлантике (таблица Outcomes, North Atlantic). Вывод: ship.
select 
	o.ship 
from Outcomes o
where o.battle='North Atlantic' and o.result='sunk' 

-- Задание 6: Вывести название (ship) последнего потопленного корабля
select 
	o.ship
from Outcomes o
join Battles b on o.battle = b.name
where o.result='sunk' and b.date=(
	select 
		max(b.date) 
	from Outcomes o join Battles b on o.battle = b.name 
	where o.result='sunk')
	
-- Задание 7: Вывести название корабля (ship) и класс (class) последнего потопленного корабля
select 
	o.ship ,
	s.class
from Outcomes o
inner join Battles b on o.battle = b.name
inner join ships s on o.ship = s.name
where o.result='sunk' and b.date=(
	select 
		max(b.date) 
	from Outcomes o 
	inner join Battles b on o.battle = b.name
	inner join ships s on o.ship = s.name
	where o.result='sunk')
-- в виду замечания "В отношение Outcomes могут входить корабли, отсутствующие в отношении Ships" выборка проведена среди только существующих в обеих таблицах данных 

-- Задание 8: Вывести все потопленные корабли, у которых калибр орудий не менее 16, и которые потоплены. Вывод: ship, class
select  
	o.ship ,
	cl.class
from outcomes o 
left join ships s on o.ship = s.name
left join classes cl on s.class=cl.class
where o.result='sunk' and cl.bore >=16
-- в виду замечания "В отношение Outcomes могут входить корабли, отсутствующие в отношении Ships" выборка проведена среди только существующих в обеих таблицах данных 


-- Задание 9: Вывести все классы кораблей, выпущенные США (таблица classes, country = 'USA'). Вывод: class
select 
	distinct (class)
from classes
where country = 'USA'

-- Задание 10: Вывести все корабли, выпущенные США (таблица classes & ships, country = 'USA'). Вывод: name, class
select 
	s.name,
	s.class
from ships s
join classes cl on s.class=cl.class
where cl.country = 'USA'


















