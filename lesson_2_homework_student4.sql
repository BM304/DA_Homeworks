-- ������� 20: ������� ������� ������ hd PC ������� �� ��� ��������������, ������� ��������� � ��������. �������: maker, ������� ������ HD.

select pr.maker, avg(pc.hd) 
from pc
join product pr  on pr.model =pc.model  
where  pr.maker in 
	(select   pr.maker from product pr
	 where pr.type='Printer')
group by pr.maker

--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

-- ������� 1: ������� name, class �� ��������, ���������� ����� 1920
select 
	s.name,
	s.class 
from Ships s 
where s.launched >1920

-- ������� 2: ������� name, class �� ��������, ���������� ����� 1920, �� �� ������� 1942
select 
	s.name,
	s.class
from Ships s 
where (s.launched >1920) and (s.launched <=1942) 

-- ������� 3: ����� ���������� �������� � ������ ������. ������� ���������� � class
select 
	s.class,
	count(s.name)
from Ships s 
group by s.class

-- ������� 4: ��� ������� ��������, ������ ������ ������� �� ����� 16, ������� ����� � ������. (������� classes)
--
select 
	cl.class,
	cl.country 
from classes cl
where cl.bore >=16

-- ������� 5: ������� �������, ����������� � ��������� � �������� ��������� (������� Outcomes, North Atlantic). �����: ship.
select 
	o.ship 
from Outcomes o
where o.battle='North Atlantic' and o.result='sunk' 

-- ������� 6: ������� �������� (ship) ���������� ������������ �������
select 
	o.ship
from Outcomes o
join Battles b on o.battle = b.name
where o.result='sunk' and b.date=(
	select 
		max(b.date) 
	from Outcomes o join Battles b on o.battle = b.name 
	where o.result='sunk')
	
-- ������� 7: ������� �������� ������� (ship) � ����� (class) ���������� ������������ �������
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
-- � ���� ��������� "� ��������� Outcomes ����� ������� �������, ������������� � ��������� Ships" ������� ��������� ����� ������ ������������ � ����� �������� ������ 

-- ������� 8: ������� ��� ����������� �������, � ������� ������ ������ �� ����� 16, � ������� ���������. �����: ship, class
select  
	o.ship ,
	cl.class
from outcomes o 
left join ships s on o.ship = s.name
left join classes cl on s.class=cl.class
where o.result='sunk' and cl.bore >=16
-- � ���� ��������� "� ��������� Outcomes ����� ������� �������, ������������� � ��������� Ships" ������� ��������� ����� ������ ������������ � ����� �������� ������ 


-- ������� 9: ������� ��� ������ ��������, ���������� ��� (������� classes, country = 'USA'). �����: class
select 
	distinct (class)
from classes
where country = 'USA'

-- ������� 10: ������� ��� �������, ���������� ��� (������� classes & ships, country = 'USA'). �����: name, class
select 
	s.name,
	s.class
from ships s
join classes cl on s.class=cl.class
where cl.country = 'USA'


















