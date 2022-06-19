--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/
select 
    Department,
    Employee,
    Salary
from
   ( select
      Department.name Department,
      Employee.name Employee,
      Salary ,
      dense_RANK ( ) OVER (partition by Department.name order by  Salary desc) rank
    from Employee 
    left join Department on Employee.departmentId = Department.id ) table1
where rank <=3
/*Результат
Accepted
Runtime: 436 ms
Your input
{"headers": {"Employee": ["id", "name", "salary", "departmentId"], "Department": ["id", "name"]}, "rows": {"Employee": [[1, "Joe", 85000, 1], [2, "Henry", 80000, 2], [3, "Sam", 60000, 2], [4, "Max", 90000, 1], [5, "Janet", 69000, 1], [6, "Randy", 85000, 1], [7, "Will", 70000, 1]], "Department": [[1, "IT"], [2, "Sales"]]}}
Output
{"headers": ["DEPARTMENT", "EMPLOYEE", "SALARY"], "values": [["IT", "Max", 90000], ["IT", "Randy", 85000], ["IT", "Joe", 85000], ["IT", "Will", 70000], ["Sales", "Henry", 80000], ["Sales", "Sam", 60000]]}
Expected
{"headers": ["Department", "Employee", "Salary"], "values": [["IT", "Joe", 85000], ["Sales", "Henry", 80000], ["Sales", "Sam", 60000], ["IT", "Max", 90000], ["IT", "Randy", 85000], ["IT", "Will", 70000]]}
*/

--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17
select 
    member_name,
    status,
    sum(amount *unit_price) as costs
from FamilyMembers
join Payments on FamilyMembers.member_id=Payments.family_member 
where YEAR ( date )  ='2005'
GROUP by  member_name, status

--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13
select name 
from (
select name, count(*) as c
from passenger 
group by name
) a 
where c > 1

--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
SELECT 
    count(first_name ) as count
from Student
where first_name='Anna'
group by first_name

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35
SELECT 
 count(*) as count
from Schedule
WHERE DATE_FORMAT(date ,'%d.%m.%Y')='02.09.2019'

--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
/*Повтор - task4 */
SELECT 
    count(first_name ) as count
from Student
where first_name='Anna'
group by first_name

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32
SELECT 
FLOOR (avg(TIMESTAMPDIFF(year,birthday,current_date))) AS age
FROM FamilyMembers

--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27
select 
    good_type_name good_type_name,
    sum(amount *unit_price) as costs
from Payments 
left join Goods on  Payments.good=Goods.good_id 
left join GoodTypes on Goods.type = GoodTypes.good_type_id 
where YEAR (date)  ='2005'
GROUP by  (good_type_name)

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37
SELECT 
 min(TIMESTAMPDIFF(year,birthday,current_date)) as year
FROM Student

--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44
SELECT 
     MAX(TIMESTAMPDIFF(year,birthday,current_date)) as max_year
FROM Student
left join Student_in_class on Student.id=Student_in_class.student
left join Class on     Student_in_class.class = class.id
where class.name like '%10%'


--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20
select 
    FamilyMembers.status,
    FamilyMembers.member_name,
    (amount *unit_price) as costs
from FamilyMembers
left join Payments on  FamilyMembers.member_id=Payments.family_member  
left join Goods on  Payments.good=Goods.good_id 
left join GoodTypes on Goods.type = GoodTypes.good_type_id 
where GoodTypes.good_type_name  ='entertainment'

--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55
delete from Company
where Company.id in(
  select company FROM Trip
  group by company
  having count(id) = (
	  select min(count) 
	  from  (
	  	select count(id) AS count 
	    from Trip 
	    group bycompany)  as min_count))

--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45
select classroom 
from Schedule 
group by (classroom) 
having count(classroom)= 
    (select count(classroom) 
	from Schedule  
	group by (classroom) 
    order by count(classroom) desc  
    limit 1) 
    

--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43
select  last_name
from Teacher
left join Schedule on Teacher.id=Schedule.teacher 
left join Subject on Schedule.subject =Subject.id 
where Subject.name='Physical Culture'
order by last_name


--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63
select 
concat (last_name, '.', LEFT(first_name, 1), '.', LEFT(middle_name, 1), '.') AS name
from Student
order by last_name, first_name,middle_name
