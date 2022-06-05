--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--Компьютерная фирма: Вывести список всех продуктов и производителя с указанием типа продукта (pc, printer, laptop). Вывести: model, maker, type
select 
	p.model, 
	p.maker, 
	p.type
from product p 
order by p.model 

--task14 (lesson3)
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, у кого цена вышей средней PC - "1", у остальных - "0"
select 
	*,
	case 
		when price >  (select avg(price) from pc)
			then 1
			else 0
		end price_l
from printer p 

--task15 (lesson3)
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)
select 
	s.name 
from ships s  
where s.class is null 

--task16 (lesson3)
--Корабли: Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.
select 
	b.name
from battles b
where EXTRACT(year from b.date) not in (select distinct(s.launched)  from ships s order by 1)

--task17 (lesson3)
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.

select 
	distinct(b.name)
from battles b
left join outcomes o on o.battle =b.name
left join ships s on o.ship =s.name
where s.class='Kongo'

--task1  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше > 300. Во view три колонки: model, price, flag

create view all_products_flag_300 as 
	select 
		p.model,  
		p.price,  
		case 
			when p.price >  300 then 1
			end flag_300
	from pc p  
	union
	select
		l.model,  
		l.price,  
		case 
			when l.price >  300 then 1
			end flag_300
	from laptop l
	union
	select
		pr.model,  
		pr.price,  
		case 
			when pr.price >  300 then 1
			end flag_300
	from printer pr

	-- проверка наличия представления 
	select * from all_products_flag_300

--task2  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше cредней . Во view три колонки: model, price, flag
	
create view all_products_flag_avg_price  as 
	with all_price as (
		select p.price from pc p  
		union
		select l.price from laptop l
		union
		select pr.price	from printer pr
		)
	select 
		p.model,  
		p.price,  
		case 
			when p.price > (select avg(price) from all_price) 
			then 1
			end flag
	from pc p  
	union
	select
		l.model,  
		l.price,  
		case 
			when l.price >  (select avg(price) from all_price) 
			then 1
			end flag_300
	from laptop l
	union
	select
		pr.model,  
		pr.price,  
		case 
			when pr.price >  (select avg(price) from all_price) 
			then 1
			end flag_300
	from printer pr	
	
	-- проверка наличия представления
	select * from all_products_flag_avg_price
	
	
--task3  (lesson4)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model
with avg_price as (
		select 
			avg(price) 
		from printer pr
		left join product p on pr.model =p.model 
		where p.maker = 'D' or  p.maker = 'C'
		)
select pr.model from printer pr
left join product p on pr.model =p.model 
where p.maker = 'A' and price> (select avg from avg_price)
	
--task4 (lesson4)
-- Компьютерная фирма: Вывести все товары производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model
with avg_price_printer as (
		select 
			avg(price) 
		from printer pr
		left join product p on pr.model =p.model 
		where p.maker = 'D' or  p.maker = 'C'
		),
	 all_product as (
		select p.model, p.price from pc p  
		union
		select l.model, l.price from laptop l
		union
		select pr.model, pr.price from printer pr
		)
select distinct (p.model) from product p 
left join all_product on p.model = all_product.model
where p.maker = 'A' and price> (select avg from avg_price_printer)

--task5 (lesson4)
-- Компьютерная фирма: Какая средняя цена среди уникальных продуктов производителя = 'A' (printer & laptop & pc)
with  all_product as (
		select p.model, p.price from pc p  
		union
		select l.model, l.price from laptop l
		union
		select pr.model, pr.price from printer pr
		)
select p.type, avg(all_product.price) from product p 
left join all_product on p.model = all_product.model
where p.maker = 'A'
group by p.type

--task6 (lesson4)
-- Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers) по каждому производителю. Во view: maker, count

create view count_products_by_makers as 
	select 
		p.maker, 
		count(p.model)  
	from product p
	group by p.maker

	-- проверка наличия представления
	select * from count_products_by_makers

--task7 (lesson4)
-- По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)
-- ссылка на решение https://colab.research.google.com/drive/1Tjdsrd_e3jeFSSqNSsNJgDrkAE_Vd4jw?usp=sharing 
--# task7 (lesson4)
--# По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)

request = """
	select 
    maker,
    count count1
  from count_products_by_makers
  order by maker

"""
df = pd.read_sql_query(request, conn)
fig = px.bar(x=df.maker.to_list(),
             y=df.count1.to_list(), 
             labels={'x':'maker', 'y':'count'})
fig.show()
	
--task8 (lesson4)
-- Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры производителя 'D'
create table printer_updated as
	select 
		pr.code,
		pr.model,
		pr.color,
		pr.type,
		pr.price 
	from printer pr 
	left join product p on pr.model = p.model
	where p.maker != 'D' 
	
	--проверяем наличие 
	select * from printer_updated

--task9 (lesson4)
-- Компьютерная фирма: Сделать на базе таблицы (printer_updated) view с дополнительной колонкой производителя (название printer_updated_with_makers)
create view printer_updated_with_makers as
	select 
		p_u.code,
		p_u.model,
		p_u.color,
		p_u.type,
		p_u.price, 
		p.maker 
	from printer_updated p_u
	left join product p on p_u.model = p.model

	--проверяем наличие 
	select * from printer_updated_with_makers


--task10 (lesson4)
-- Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes). Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)
create view sunk_ships_by_classes as 
	select 	
		count (o.result),
		case 
		when class is not null
			then s.class
			else '0'
		end class1
	from outcomes o 
	left join ships s on o.ship =s.name
	where o.result='sunk'
	group by class1
	
	-- проверка наличия представления
	select * from sunk_ships_by_classes

--task11 (lesson4)
-- Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)
-- ссылка на решение https://colab.research.google.com/drive/1Tjdsrd_e3jeFSSqNSsNJgDrkAE_Vd4jw?usp=sharing 

--# task11 (lesson4)
--# Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)
request = """
	select 	
		count count1,
		class1
	from sunk_ships_by_classes
"""
df = pd.read_sql_query(request, conn)
fig = px.bar(x=df.class1.to_list(),
             y=df.count1.to_list(), 
             labels={'x':'class', 'y':'count'})
fig.show()
		

--task12 (lesson4)
-- Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag: если количество орудий больше или равно 9 - то 1, иначе 0
create table classes_with_flag as
	select 
		*,
		case 
			when numguns >=9
				then 1
				else 0
			end flag
	from classes c 
	
	-- Проверка наличия таблицы
	select * from classes_with_flag 

--task13 (lesson4)
-- Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)
-- ссылка на решение https://colab.research.google.com/drive/1Tjdsrd_e3jeFSSqNSsNJgDrkAE_Vd4jw?usp=sharing 

--# task13 (lesson4)
--# Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count) 

request = """
select 
 	c.country,
	 count(c.class) count1
from classes c 
group by c.country
order by c.country
"""
df = pd.read_sql_query(request, conn)
fig = px.bar(x=df.country.to_list(),
             y=df.count1.to_list(), 
             labels={'x':'class', 'y':'count'})
fig.show()
	

--task14 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название начинается с буквы "O" или "M".
select 
	count(s.name) 
from ships s 
where s.name like 'O%' or s.name like 'M%'

--task15 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название состоит из двух слов.
select 
	s.name
from ships s 
where s.name like '%_ _%' and not s.name like '% % ' 
	
--task16 (lesson4)
-- Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)
-- ссылка на решение https://colab.research.google.com/drive/1Tjdsrd_e3jeFSSqNSsNJgDrkAE_Vd4jw?usp=sharing 
-- # task16 (lesson4)
-- # Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)
request = """
select 
	s.launched launched,
	count(s.name) count1
from ships s 
group by s.launched
order by s.launched
"""
df = pd.read_sql_query(request, conn)
fig = px.bar(x=df.launched.to_list(), 
             y=df.count1.to_list(), 
             labels={'x':'year', 'y':'count'})
fig.show()
	
