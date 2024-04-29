create database assign4;
use assign4;

create table student(id numeric,password varchar(20));
create table incharge(id numeric,password varchar(20));
insert into  student values(21510025,'123');
insert into  student values(21510024,'123');
insert into  incharge values(21510015,'123');
insert into  incharge values(21510021,'123');
create table questions (que varchar(100),o1 varchar(100),o2 varchar(100),o3 varchar(100),o4 varchar(100));
insert into  questions values('what is database?','option1','option2','option3','option4');
insert into  questions values('not a components of database','option1','option2','option3','option4');
insert into  questions values('what is warehouse of database?','option1','option2','option3','option4');
insert into  questions values('what is clustering?','option1','option2','option3','option4');
insert into  questions values('what is cube?','option1','option2','option3','option4');
SELECT * FROM questions;

create table answers (id numeric,ind numeric,opt numeric);
select* from answers;
select * from teacher;
-- drop table answers;
#drop table student;