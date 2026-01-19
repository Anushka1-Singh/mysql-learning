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