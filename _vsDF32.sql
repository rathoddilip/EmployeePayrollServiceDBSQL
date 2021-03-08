----
--UC-1 create database and use it
----
create database payroll_service;
use payroll_service;

--Show list of databases
SELECT name, database_id, create_date FROM sys.databases ;  

--UC-2 Ability to create table 
create table employee_payroll
(
--id is not null and auto incremented
id int not null IDENTITY(1,1) PRIMARY KEY,
name varchar(100) not null,
salary float not null,
--start is a date type and not null
start date not null
);

--UC-3 insert data to employee payroll
insert into employee_payroll(name,salary,start) 
values
('Kishor',23000,'2020-02-19'),
('Krishabh',22000,'2020-03-20'),
('Ganesh',20000,'2020-04-22'),
('Ranjit',25000,'2020-05-25');
--UC-4-Retrieves employee data
select * from employee_payroll;

--UC-5 Retrieves salary data for a perticular employee 
--as well as all employees who have joined in a perticular date range
select salary from employee_payroll where name='Dilip';
select * from employee_payroll where start between cast('2020-02-22' as date) and getdate();

--update data
update employee_payroll set start='2020-03-19' where name='Sandip';

--UC-6 add the gender field to table and update row to reflect the correct employee gender
alter table employee_payroll add gender char(1);
update employee_payroll set gender='M';
insert into employee_payroll(name,salary,start,gender) 
values
('Sayali',28000,'2020-06-26','F'),
('Kavita',25000,'2020-05-18','F');

--UC-7- to find sum,average,min,max,counta and number of male and female employees
select * from employee_payroll;
select SUM(salary) as result from employee_payroll where gender='F';
select AVG(salary) as result from employee_payroll where gender='M';
select MIN(salary) as result from employee_payroll where gender='F';
select MAX(salary) as result from employee_payroll where gender='F';
select COUNT(salary) as result from employee_payroll where gender='F';

-----------------------------------------------------------------------------
select SUM(salary) as result, gender from employee_payroll group by gender;
select AVG(salary) as result, gender from employee_payroll group by gender;
select MIN(salary) as result, gender from employee_payroll group by gender;
select MAX(salary) as result, gender from employee_payroll group by gender;

select COUNT(salary), gender from employee_payroll group by gender;

--UC-8 to extend data to store employee information phone,address,department
select * from employee_payroll;

alter table employee_payroll add phone bigint;
alter table employee_payroll add address varchar(200);
alter table employee_payroll drop column address;
alter table employee_payroll add address varchar(200) not null default 'Mumbai';
alter table employee_payroll add department varchar(50) not null default 'IT';

update employee_payroll set phone=9988776655 where name='Dilip';
update employee_payroll set phone=9911223344 where name='Sandip';

---UC-9 extend table data like basic pay, Duductions, Taxable pay, income tax, net pay
select * from employee_payroll;

alter table employee_payroll add basic_pay bigint;
alter table employee_payroll add deductions int not null default 0 ;
alter table employee_payroll add taxable_pay int not null default 0 ;
alter table employee_payroll add income_tax int not null default 0 ;
alter table employee_payroll add net_pay int not null default 0 ;
update employee_payroll set basic_pay=10000 where name='Sandip' or name='Ranjit' or name='Sayali';

update employee_payroll set basic_pay=20000 where name='Dilip' or name='Kishor' or name='Kavita';

update employee_payroll set basic_pay=15000 where name='Ganesh' or name='Krishabh';


select * from employee_payroll;
alter table employee_payroll drop column basic_pay;
--renamed the column salary to basic_pay
EXEC sp_rename 'employee_payroll.salary', 'basic_pay','column';  
--UC-10 
insert into employee_payroll(name,basic_pay,start,gender,phone,department,address,deductions,taxable_pay) 
values
('Sayali',35000,'2020-06-26','F',8668336629,'Sales','Pune',1000,1000),
('Sayali',55000,'2020-10-26','F',7756994045,'Marketing','Pune',2000,1500);

select * from employee_payroll where name='Sayali';
