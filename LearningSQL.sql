CREATE DATABASE college;
create database xyz_company;
drop database  xyz_company;
USE college;
create database if not exists instagram;
drop database if exists college;
show databases;
use instagram;
show tables;

create table user (id int , age int, name varchar(30) not null, email varchar(50) unique, 
followers int default 0, following int, 
constraint check (age>=13), primary key(id));

create table post ( id int primary key, content varchar(100), user_id int, 
foreign key (user_id) REFERENCES user (id));

show tables;

insert into user (id, age, name, email, followers, follwing) values 
(1, 14, 'adam', 'adam@yahoo.in', 123, 145),
(2, 15, 'bob', 'bob123@gamil.com', 200, 200),
(3,16, 'casey', 'casey@gmail.com', 300, 306),
(4,17, 'donald', 'donald@gmail.com',200,105);

insert into user ( id, age, name, email ) values (10, 20, 'random', 'bob123@gmail.com');
select id, name, email from user;
select * from user; 
select distinct age from user;

select * from user where followers >= 200;
select name, followers from user where followers >= 200;
select name, followers from user where age >= 16;
select name, age from user where age + 1 = 16;
select name, age, followers from user where age > 15 and followers>200;
select name, age, followers from user where age > 15 or followers>200;
select name, age, followers from user where age between 15 and 17;
select name, email, followers from user where email in ('donald@gmail.com', 'bob@123gmail.com', 'abc@gmail.com');

insert into user(id, age, name, email, followers, follwing) values 
(5,14, 'eve', 'eve@yahoo.in', 400, 15),
(6,16, 'farah', 'farah@gmail.com', 1000, 1000);
select name, followers, email from user where age in(14, 16);

select name, age, email from user limit 2;
select name, age, email from user where age>14 limit 2;
select name, age, followers from user order by followers asc;
select name, age, followers from user order by followers desc;
select name, age, followers from user order by followers;

#aggregate function
select max(followers) from user;
select max(age) from user;
select count(age) from user where age=14;
select min(age) from user;
select avg(age) from user;
select sum(followers) from user;

#groupby clause
select count(id) from user group by age;
select  age,count(id) from user group by age;
select  age from user group by age;
select  age, max(followers) from user group by age;

#having clause is used when we want to apply any condition after grouping (similar to where because applies conditon)
select age, max(followers) from user group by age having max(followers)>200;
select age, max(followers) from user group by age having max(followers)>200 order by age desc;

#table queries (update), to update existing rows
update user set followers = 600 where age =16;
set sql_safe_updates =0;
select * from user;

#table queries (delete), to delete existing rows
delete from user where age =14; 
select * from user;

# table queries 
# alter ( to change the schema(add column, drop column, rename table, change column(rename), modify column(modify datatype/constraint) )
alter table user add column city varchar(25) default 'delhi';
select *from user;
alter table user drop column age;
select * from user;
alter table user rename to instaUser;
select * from instaUser;
alter table instaUser rename to user;
alter table user change column followers subs int default 0;
select * from user;
insert into user (id, name, email, follwing) values (7, 'gemini', 'gem@yahoo.in', 120);
alter table user modify subs int default 15;
select * from user;

# table queries (truncate, to delete table's data)
select * from post;
drop table post;
select * from user;
truncate table user; 
select * from user;


# practise questions
create database if not exists college; 
use college;
create table teacher(id int primary key, name varchar(50), subject varchar(50), salary int);
insert into teacher (id, name, subject, salary) values 
(23, 'ajay', 'math', 50000),
(47, 'bharat', 'english', 60000),
(18, 'chetan', 'chemistry', 45000),
(9, 'divya', 'physics', 75000);

select * from teacher;
select * from teacher where salary>55000;
alter table teacher change column salary ctc int; 
update teacher set ctc = ctc * (125/100);
select * from teacher;
alter table teacher add column city varchar(50) default 'gurgaon';
select * from teacher;
alter table teacher drop column ctc; 
select * from teacher;


create table student ( rollno int primary key, name varchar(50), city varchar(50), marks int);
insert into student (rollno, name, city, marks) values
(110, 'adam', 'delhi', 76),
(108, 'bob', 'mumbai', 65),
(124, 'casey', 'pune', 94),
(112, 'duke', 'pune', 80);
select * from student;
select * from student where marks>75;
select distinct city from student;
select city from student group by city;
select city,max(marks) from student group by city;
select avg(marks) from student;
alter table student add column grade varchar(2);
select *from student;
update student set grade ='o' where marks >= 80;
update student set grade ='a' where marks >= 70 and marks<80;
update student set grade ='b' where marks >= 60 and marks<70;
select *from student;

# bye bye :( 19January,2026)












