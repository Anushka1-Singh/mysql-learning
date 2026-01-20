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






