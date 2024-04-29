create database mydb;
use mydb;
SET SQL_SAFE_UPDATES = 0;
create table student( prn int , name varchar(30) , age int,mobile bigint);
insert into student (prn,name,age,mobile) values ('21510013','Bhupendra Jambhale',20,9307767356);
insert into student (prn,name,age,mobile) values ('21510045','Sourabh Patil',20,9301236666)
,('21510018','Jay Chatpalliwar',20,9001236666);

select * from student;

update  student set mobile = 9404207269 where prn='21510013';

SELECT * FROM student WHERE name LIKE 'B%';

delete  from student ;
