-- 1. Создание таблицы о сотрудниках
drop table if exists employees;
create table employees (
	id serial primary key,
	full_name character varying(100), -- ФИО
	birthdate date, -- дата рождения
	first_day_work date, -- дата начала работы
	position character varying(100), -- должность
	experience character varying(10), -- уровень сотрудника (junior, middle, senior, lead)
	salary integer, -- уровень зарплаты
	department_id integer, -- идентификатор отдела
	rights bool -- наличие/отсутствие прав(True/False)
);

-- 2. Создание таблицы с информацией по отделам
drop table if exists departments;
create table departments (
	id serial primary key,
	title character varying(100), -- название отдела
	name_leader character varying(100), -- ФИО руководителя
	employees_cnt integer -- количество сотрудников
);

-- 3. Создание таблицы с оценкой сотрудников за каждый квартал
drop table if exists performance;
create table performance (
	employe_id integer, -- идентификатор сотрудника
	quarter_1 character varying(1), -- оценка сотрудника за 1 квартал (A, B, C, D, E)
	quarter_2 character varying(1), -- оценка сотрудника за 2 квартал (A, B, C, D, E)
	quarter_3 character varying(1), -- оценка сотрудника за 3 квартал (A, B, C, D, E)
	quarter_4 character varying(1) -- оценка сотрудника за 4 квартал (A, B, C, D, E)
);

-- 4. Заполнение таблиц
-- добавление данных в таблицу о сотрудниках
insert into employees (full_name, birthdate, first_day_work, position, experience, salary, department_id, rights)
values
	('Гуляев Касьян Онисимович', '06.12.1988', '01.10.2015', 'Руководитель группы', 'senior', 250000, 1, True),
	('Дроздов Тимофей Арсеньевич', '25.07.1990', '10.10.2015', 'Руководитель группы', 'lead', 200000, 2, True),
	('Дементьева Сабина Адольфовна', '11.05.1992', '02.01.2016', 'Аналитик', 'middle', 140000, 2, True),
	('Гуляев Лукьян Максимович', '14.11.1995', '18.12.2018', 'Разработчик', 'middle', 120000, 1, True),
	('Якушев Терентий Иосифович', '23.06.1996', '10.01.2016', 'Разработчик', 'middle', 140000, 1, True),
	('Котов Соломон Егорович', '09.06.1997', '16.03.2020', 'Аналитик', 'junior', 100000, 1, False),
	('Беспалова Мария Тихоновна', '01.12.1996', '01.09.2017', 'Разработчик', 'middle', 110000, 1, True),
	('Логинов Ян Станиславович', '12.04.1995', '04.12.2018', 'Аналитик', 'middle', 120000, 2, True),
	('Артемьев Валерий Геннадьевич', '15.02.1997', '17.03.2020', 'Аналитик', 'junior', 100000, 1, False),
	('Якушева София Онисимовна', '29.10.1998', '20.03.2021', 'Аналитик', 'junior', 70000, 2, False)
;

-- добавление данных в таблицу с информацией по отделам
insert into departments (title, name_leader, employees_cnt)
values
	('DevOps', 'Гуляев Касьян Онисимович', 6),
	('Отчетность', 'Дроздов Тимофей Арсеньевич', 4)
;

-- добавление данных в таблицу с оценкой сотрудников за каждый квартал
insert into performance
values
	(1, 'A', 'A', 'B', 'A'),
	(2, 'A', 'B', 'A', 'B'),
	(3, 'A', 'B', 'B', 'A'),
	(4, 'B', 'C', 'B', 'C'),
	(5, 'B', 'B', 'B', 'B'),
	(6, 'B', 'D', 'C', 'B'),
	(7, 'B', 'C', 'B', 'D'),
	(8, 'B', 'E', 'B', 'C'),
	(9, 'B', 'C', 'C', 'B'),
	(10, 'C', 'C', 'D', 'B')
;


-- 5. Добавление информации о новых сотрудниках
insert into employees (full_name, birthdate, first_day_work, position, experience, salary, department_id, rights)
values
	('Бирюков Эльдар Львович', '25.07.1994', '10.09.2022', 'Руководитель группы', 'lead', 180000, 3, True),
	('Кузнецов Анатолий Никитевич', '12.04.1996', '20.09.2022', 'Разработчик', 'middle', 110000, 3, True),
	('Степанов Моисей Оскарович', '29.10.1995', '22.09.2022', 'Аналитик', 'middle', 100000, 3, True)
;
insert into departments (title, name_leader, employees_cnt)
values
	('Интеллектуальный анализ данных', 'Бирюков Эльдар Львович', 3)
;
insert into performance
values
	(11, null, null, null, null),
	(12, null, null, null, null),
	(13, null, null, null, null)
;

-- 6. Запросы

-- 6.1 Уникальный номер сотрудника, его ФИО и стаж работы – для всех сотрудников компании
select e.id as "Номер сотрудника", e.full_name as "ФИО", age(now()::date, e.first_day_work) as "Стаж работы"
from employees e;

-- 6.2 Уникальный номер сотрудника, его ФИО и стаж работы – только первых 3-х сотрудников
select e.id as "Номер сотрудника", e.full_name as "ФИО", age(now()::date, e.first_day_work) as "Стаж работы"
from employees e
order by e.first_day_work
limit 3;

-- 6.3 Уникальный номер сотрудников - водителей
select e.id as "Номер сотрудника"
from employees e
where rights;

-- 6.4 Выведите номера сотрудников, которые хотя бы за 1 квартал получили оценку D или E
select e.id as "Номер сотрудника"
from employees e
join performance p on e.id = p.employe_id
	and (p.quarter_1 in ('D', 'E') or p.quarter_2 in ('D', 'E') or p.quarter_3 in ('D', 'E') or p.quarter_4 in ('D', 'E'));

-- 6.5 Выведите самую высокую зарплату в компании
select max(e.salary) as "Максимальная заплата"
from employees e;

-- 6.6 Выведите название самого крупного отдела
select d.title as "Название отдела"
from departments d
where d.employees_cnt = (select max(employees_cnt) from departments d);

-- 6.7 Выведите номера сотрудников от самых опытных до вновь прибывших
select e.id as "Номер сотрудника"
from employees e
order by first_day_work;

-- 6.8 Рассчитайте среднюю зарплату для каждого уровня сотрудников
select e.experience as "Уровень сотрудника", round(avg(e.salary)) as "Средняя зарплата"
from employees e
group by experience
order by 2;
