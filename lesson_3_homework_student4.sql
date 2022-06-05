--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--�������: ��� ������� ������ ���������� ����� �������� ����� ������, ����������� � ���������. 
--�������: ����� � ����� ����������� ��������.
 
select 
case 
	when class is not null
		then class
		else '����� �� ���������'
end �����,
count (t1.result)
from 
	(SELECT 
		cl.class, 
		o.result
	FROM classes cl
	full outer join ships s on cl.class = s.class
	full outer join Outcomes o on o.ship = s.name
	where result='sunk') as t1	
group by (�����, t1.result)

--task2
--�������: ��� ������� ������ ���������� ���, ����� ��� ������ �� ���� ������ ������� ����� ������. 
--���� ��� ������ �� ���� ��������� ������� ����������, ���������� ����������� ��� ������ �� ���� �������� ����� ������. 
--�������: �����, ���.

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
	-- �� ������ �������� ����� �� else, ��������,  ���� ������ �������
   end ���    
FROM classes cl
left join ships s  on cl.class =  s.class
left join s_gr  on cl.class =  s_gr.class


--task3
--�������: ��� �������, ������� ������ � ���� ����������� �������� � �� ����� 3 �������� � ���� ������, 
--������� ��� ������ � ����� ����������� ��������.

select 
case 
	when class is not null
		then class
		else '����� �� ���������'
end �����,
count (t1.result)
from 
	(SELECT 
		cl.class, 
		o.result
	FROM classes cl
	full outer join ships s on cl.class = s.class
	full outer join Outcomes o on o.ship = s.name
	where result='sunk' _______________________) as t1		
group by (�����, t1.result)



(select count(s.name) from ships where cl.class = s.class group by s.class )>=3

--task4
--�������: ������� �������� ��������, ������� ���������� ����� ������ ����� ���� �������� ������ �� ������������� 
--(������ ������� �� ������� Outcomes).




--task5
--������������ �����: ������� �������������� ���������, ������� ���������� �� � ���������� ������� RAM � � ����� ������� ����������� ����� ���� ��,
-- ������� ���������� ����� RAM. �������: Maker




