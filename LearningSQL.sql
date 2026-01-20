select @@autocommit;
set autocommit=0;
create database prime;
use prime;
create table accounts( id int primary key auto_increment, name varchar(50), balance decimal(10,2));
insert into accounts(name, balance) values ('adam', 500.00), ('bob', 300.00), ('charlie',100.00);

select * from accounts;

-- transactions
start transaction;
update accounts set balance = balance-50 where id =1;
update accounts set balance = balance+50 where id =2;
commit;
select * from accounts;

-- transaction and autocommit in sql
-- a transaction is a group of sql statements executed as a single unit
-- it ensures data consistency and integrity
-- by default , sql runs in autocommit mode, where each query is automatically saved.
-- when autocommit is off( set autocommit=0), changes are not saved immediately. 
-- multiple sql statements can be executed as one transaction.
-- the commit command premanently saves all changes.

-- the rollback command cancels all changes made after the last commit.

start transaction;
update accounts set balance = balance-50 where id =1;
commit;
update accounts set balance = balance+50 where id =2;
rollback;
select * from accounts;


-- (commit)
-- permanently saves all changes
-- after commit->cannot rollback
-- (savepoint)
-- creates a checkpoint inside a transaction
-- data is still temporary
-- allows rolllback up to that point only
-- (rollback)
-- erases changes :-
-- till last commit(full rollback)
-- till savepoint(partial rollback)

-- a savepoint works like a checkpoint inside a transaction . rollback removes only the changes made
-- after the savepoint, while changes before the savepoint remain. commit permanemtly saves all changes.

start transaction;
update accounts set balance = balance+1000 where id =1;
savepoint after_wallet_topup;
update accounts set balance = balance+10 where id =1;
-- error
rollback to after_wallet_topup;
commit;
select * from accounts;




-- (joins), joins are used to combine rows from two or more tables based on a related column between them.
create table customers(customer_id int primary key, name varchar(50), city varchar(50));
insert into customers values(1,'alice','mumbai'),(2,'bob','delhi'),(3,'charlie','banglore'),
(4,'david','mumbai');
create table orders(order_id int primary key, customer_id int, amount int);
insert into orders values(101, 1, 500),(102, 1, 900),(103, 2, 300),(104, 5, 700);
show tables;
select * from customers;
select * from orders;

-- inner join
select * from customers c 
inner join orders o on c.customer_id = o.customer_id;
select c.customer_id, o.order_id, c.name from customers c 
inner join orders o on c.customer_id = o.customer_id;
-- left join 
select * from customers c 
left join orders o on c.customer_id = o.customer_id;
-- right join
select * from customers c 
right join orders o on c.customer_id = o.customer_id;
-- outer join 
select * from customers c 
left join orders o on c.customer_id = o.customer_id
union
select * from customers c 
right join orders o on c.customer_id = o.customer_id;
-- cross join
select * from customers cross join orders;
-- self join ( it is a regular join but the table is jined with itself)
select * from customers as A join customers as B on A.customer_id = B.customer_id;

-- excusive joins (left exclusive and right exclusive join)

