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

-- excusive joins (left exclusive and right exclusive join).
-- left exclusive join
select * from customers as A
left join orders as B on A.customer_id = B.customer_id
where B.customer_id is null; 
-- right exclusive join
select * from customers as A
right join orders as B on A.customer_id = B.customer_id
where A.customer_id is null; 

-- sub-queries (a sub-queery or inner-query or nested-query is a query within another sql query.
-- it invloves two select statements.
-- with where
select * from orders 
where amount>(select avg(amount) from orders);
-- with select
select name,
(select count(*) from orders o where o.customer_id=c.customer_id)as order_count from customers c;
-- with from 
select summary.customer_id, summary.avg_amount from
( select customer_id, avg(amount) as avg_amount from orders group by customer_id ) as summary;

-- views in sql (a view is a virtual table based on the result-set of an sql statement).
-- a view always shows up to data .The database engine recreates the view,every time a user queries it.
create view view1 as select customer_id , name from customers;
select * from view1;
select * from view1 where name='alice';
create view view2 as select c.customer_id, c.name, o.order_id from customers c inner join
orders o on c.customer_id = o.customer_id;
select * from view2;
drop view view1;
 
-- index in sql (indexes are special databases objects that make data retrieval faster.)
create table account(account_id int primary key, name varchar(50), balance decimal(10,2), branch varchar(50));
insert into account values 
(1,'adam', 500.00, 'mumbai'),
(2,'bob', 300.00, 'delhi'),
(3, 'charlie', 700.00, 'banglore'),
(4, 'david', 1000.00, 'noida');
select * from account;

create index idx_branch on account(branch);
show index from accounts;


-- stored procedures( predefined set of sql statements that you can save in the database 
-- and execute whenever needed) more like functions/procedures
delimiter $$
create procedure check_balance(IN acc_id int, out bal decimal(10,2))
begin 
select balance into bal from account where account_id = acc_id;
end $$
delimiter ;
call check_balance(2, @balance);
select @balance;
drop procedure if exists check_balance 
-- @balance(@variable) : used to capture output value parameter , read using select @variable
-- delimiter : normally sql ends a statement with ; semicolon but in stored procedure ,we write many 
-- sql statements insie one block - so delimiter like $$ avoids confusion , it tells sql procedure is not
-- finished yet , after procedure creation , we reset delimiter back to semicolon; 


