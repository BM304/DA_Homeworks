--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task3  (lesson6)
--������������ �����: ������� ����� ������ �������� (��, ��-�������� ��� ��������), �������� ����� ������� ����. �������: model

with all_price as (
	select p.maker, p.model, p.type, l.price from product p
	join laptop l on p.model= l.model 
	union all
	select p.maker, p.model, p.type, p2.price from product p
	join pc p2 on p.model= p2.model 
	union all
	select p.maker, p.model, p.type, p3.price from product p
	join printer p3 on p.model= p3.model 
	)
	
select model from all_price
where price = (select max (price) from  all_price)
	

--task5  (lesson6)
-- ������������ �����: ������� ������� all_products_with_index_task5 ��� ����������� ���� ������ �� ����� code (union all) � ������� ���� (flag) �� ���� > ������������ �� ��������. ����� �������� ��������� (����� ������� �������) �� ������ ��������� �������� � ������� ����������� ���� (price_index). �� ����� price_index ������� ������
	
create table all_products_with_index_task5 as
select 
	*,
	row_number() over (partition by type order by price DESC) as price_index
		
from (
 	select 
		product.type,
		code,
		price,
		case 
			when price> (select max(price) from printer) then 1		
		end
	from product  
	join laptop on product.model =laptop.model 
	union all
	select 
		product.type,
		code,
		price,		
		case 
			when price> (select max(price) from printer) then 1		
		end
	from product  
	join pc on product.model =pc.model  
	union all
	select 
		product.type,
		code,
		price,
		case 
			when price> (select max(price) from printer) then 1		
		end
	from product  
	join printer on product.model =printer.model) as t4
		
	-- �������� ������� �������:
	select * from all_products_with_index_task5
	
	-- ��������� ������
	create index price_index on all_products_with_index_task5 (price_index);
	