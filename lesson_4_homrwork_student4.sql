--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--������������ �����: ������� ������ ���� ��������� � ������������� � ��������� ���� �������� (pc, printer, laptop). �������: model, maker, type
select 
	p.model, 
	p.maker, 
	p.type
from product p 
order by p.model 

--task14 (lesson3)
--������������ �����: ��� ������ ���� �������� �� ������� printer ������������� ������� ��� ���, � ���� ���� ����� ������� PC - "1", � ��������� - "0"
select 
	*,
	case 
		when price >  (select avg(price) from pc)
			then 1
			else 0
		end price_l
from printer p 

--task15 (lesson3)
--�������: ������� ������ ��������, � ������� class ����������� (IS NULL)
select 
	s.name 
from ships s  
where s.class is null 

--task16 (lesson3)
--�������: ������� ��������, ������� ��������� � ����, �� ����������� �� � ����� �� ����� ������ �������� �� ����.
select 
	b.name
from battles b
where EXTRACT(year from b.date) not in (select distinct(s.launched)  from ships s order by 1)

--task17 (lesson3)
--�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.

select 
	distinct(b.name)
from battles b
left join outcomes o on o.battle =b.name
left join ships s on o.ship =s.name
where s.class='Kongo'

--task1  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_300) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ > 300. �� view ��� �������: model, price, flag

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

	-- �������� ������� ������������� 
	select * from all_products_flag_300

--task2  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_avg_price) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ c������ . �� view ��� �������: model, price, flag
	
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
	
	-- �������� ������� �������������
	select * from all_products_flag_avg_price
	
	
--task3  (lesson4)
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model
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
-- ������������ �����: ������� ��� ������ ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model
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
-- ������������ �����: ����� ������� ���� ����� ���������� ��������� ������������� = 'A' (printer & laptop & pc)
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
-- ������������ �����: ������� view � ����������� ������� (�������� count_products_by_makers) �� ������� �������������. �� view: maker, count

create view count_products_by_makers as 
	select 
		p.maker, 
		count(p.model)  
	from product p
	group by p.maker

	-- �������� ������� �������������
	select * from count_products_by_makers

--task7 (lesson4)
-- �� ����������� view (count_products_by_makers) ������� ������ � colab (X: maker, y: count)
-- ������ �� ������� https://colab.research.google.com/drive/1Tjdsrd_e3jeFSSqNSsNJgDrkAE_Vd4jw?usp=sharing 
--# task7 (lesson4)
--# �� ����������� view (count_products_by_makers) ������� ������ � colab (X: maker, y: count)

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
-- ������������ �����: ������� ����� ������� printer (�������� printer_updated) � ������� �� ��� ��� �������� ������������� 'D'
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
	
	--��������� ������� 
	select * from printer_updated

--task9 (lesson4)
-- ������������ �����: ������� �� ���� ������� (printer_updated) view � �������������� �������� ������������� (�������� printer_updated_with_makers)
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

	--��������� ������� 
	select * from printer_updated_with_makers


--task10 (lesson4)
-- �������: ������� view c ����������� ����������� �������� � ������� ������� (�������� sunk_ships_by_classes). �� view: count, class (���� �������� ������ ���/IS NULL, �� �������� �� 0)
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
	
	-- �������� ������� �������������
	select * from sunk_ships_by_classes

--task11 (lesson4)
-- �������: �� ����������� view (sunk_ships_by_classes) ������� ������ � colab (X: class, Y: count)
-- ������ �� ������� https://colab.research.google.com/drive/1Tjdsrd_e3jeFSSqNSsNJgDrkAE_Vd4jw?usp=sharing 

--# task11 (lesson4)
--# �������: �� ����������� view (sunk_ships_by_classes) ������� ������ � colab (X: class, Y: count)
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
-- �������: ������� ����� ������� classes (�������� classes_with_flag) � �������� � ��� flag: ���� ���������� ������ ������ ��� ����� 9 - �� 1, ����� 0
create table classes_with_flag as
	select 
		*,
		case 
			when numguns >=9
				then 1
				else 0
			end flag
	from classes c 
	
	-- �������� ������� �������
	select * from classes_with_flag 

--task13 (lesson4)
-- �������: ������� ������ � colab �� ������� classes � ����������� ������� �� ������� (X: country, Y: count)
-- ������ �� ������� https://colab.research.google.com/drive/1Tjdsrd_e3jeFSSqNSsNJgDrkAE_Vd4jw?usp=sharing 

--# task13 (lesson4)
--# �������: ������� ������ � colab �� ������� classes � ����������� ������� �� ������� (X: country, Y: count) 

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
-- �������: ������� ���������� ��������, � ������� �������� ���������� � ����� "O" ��� "M".
select 
	count(s.name) 
from ships s 
where s.name like 'O%' or s.name like 'M%'

--task15 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ������� �� ���� ����.
select 
	s.name
from ships s 
where s.name like '%_ _%' and not s.name like '% % ' 
	
--task16 (lesson4)
-- �������: ��������� ������ � ����������� ���������� �� ���� �������� � ����� ������� (X: year, Y: count)
-- ������ �� ������� https://colab.research.google.com/drive/1Tjdsrd_e3jeFSSqNSsNJgDrkAE_Vd4jw?usp=sharing 
-- # task16 (lesson4)
-- # �������: ��������� ������ � ����������� ���������� �� ���� �������� � ����� ������� (X: year, Y: count)
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
	