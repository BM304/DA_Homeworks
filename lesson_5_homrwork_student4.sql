--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- ������������ �����: ������� view (pages_all_products), � ������� ����� ������������ �������� ���� ��������� (�� ����� ���� ��������� �� ����� ��������). 
-- �����: ��� ������ �� laptop, ����� ��������, ������ ���� �������

sample:
1 1
2 1
1 2
2 2
1 3
2 3

create view pages_all_products as

select 
	*,
	case 
		when row_number() over (order by code)%2 =1 
		then 1 
		else 2
	end npos,
	case 
		when row_number() over (order by code)%2 =0  
		then row_number() over (order by code)/2 
		else  row_number() over (order by code)/2+1
	end nstr
	from laptop 
	
	-- �������� ������� �������������
	select * from pages_all_products

	
	
--task2 (lesson5)
-- ������������ �����: ������� view (distribution_by_type), � ������ �������� ����� ���������� ����������� ���� ������� �� ���� ����������. �����: �������������, ���, ������� (%)
	
create view distribution_by_type as
	
	select 
		maker,	
		type, 
		count(*) * 100.0 / (select count(*) from product) as procent
	from product 
	group by (maker,type)
	order by maker 

	-- �������� �������
	select * from distribution_by_type
	
		
--task3 (lesson5)
-- ������������ �����: ������� �� ���� ����������� view ������ - �������� ���������. ������ https://plotly.com/python/histograms/

# task3 (lesson5)
# ������������ �����: ������� �� ���� ����������� view ������ - �������� ���������. ������ https://plotly.com/python/histograms/

-- �������: https://colab.research.google.com/drive/1bYdqCA2L8MNpeu3CdV3ewP7ulGR_J1SD?usp=sharing 

request = """
	select 
	   concat (maker, ' ', type), 
	   procent
	from distribution_by_type 
"""

df = pd.read_sql_query(request, conn)
labels = df.concat.to_list() 
sizes =  df.procent.to_list()

fig1, ax1 = plt.subplots()
ax1.pie(sizes, labels=labels)
ax1.axis('equal')  
plt.show()

	
--task4 (lesson5)
-- �������: ������� ����� ������� ships (ships_two_words), �� �������� ������� ������ �������� �� ���� ����

create table ships_two_words as

select * from ships
where name like '%_ _%' 
	and name not like '%_ _% _%'
	
	-- ������� �������:
	select * from ships_two_words 


--task5 (lesson5)
-- �������: ������� ������ ��������, � ������� class ����������� (IS NULL) � �������� ���������� � ����� "S"
select  
	name 
from  ships
where class is null 
	and name like 'S%'

--task6 (lesson5)
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'C'
-- � ��� ����� ������� (����� ������� �������). ������� model

with rn_price_printer as 	
	(
	select price, row_number() over (order by price DESC) as rn 
	from printer
	) 

select '�������� ������������� �, � ����� ���� ������� ������������� �' as ������� , p.model from product p 
join printer p1 on p.model =p1.model 
where maker='A'
	and price> 
	(select avg(price) from product p 
	join printer p1 on p.model =p1.model where maker='C') 
union all 
select '��� ����� ������� ��������' as ������� , p.model from product p 
join printer p1 on p.model =p1.model 
where price in (select price from rn_price_printer where rn<=3 )
