--Node1

create database assign8;
use assign8;
CREATE TABLE IF NOT EXISTS people (
  person_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  age INT
);

-- Insert values
INSERT INTO people (first_name, last_name, age)
VALUES 
  ('John', 'Doe', 28),
  ('Jane', 'Smith', 34),
  ('Michael', 'Johnson', 40),
  ('Emily', 'Brown', 25);
  
select * from people;

--Node2

use assign8;
select * from people;

show global variables like 'super_read_only';

SET GLOBAL super_read_only = OFF;
SET GLOBAL read_only = OFF;

insert into people (first_name,last_name,age) values ('shreya','khambe',21);

--Node 3
use assign8;
select * from people;

show global variables like 'super_read_only';

SET GLOBAL super_read_only = OFF;
SET GLOBAL read_only = OFF;

insert into people (first_name,last_name,age) values ('asmita','shinde',21);
