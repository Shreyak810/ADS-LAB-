use assign3;
-- select * from student;
-- drop table student;


INSERT INTO student (s_id, password, name, dept_name, totCred) 
VALUES 
('21510025', '21510025', 'Shreya Khambe', 'CSE', 150),
('21510024', '21510024', 'Neha Kharat', 'Computer Science', 120),
('S002', 'qwerty', 'Jane Smith', 'Mathematics', 90),
('S003', 'abc123', 'Alice Johnson', 'Physics', 110);

INSERT INTO instructor (id, password, name, dept_name, salary) 
VALUES 
('I001', 'password123', 'John Smith', 'Computer Science', 50000.00),
('I002', 'securepass', 'Alice Johnson', 'Mathematics', 55000.00),
('I003', 'strongpassword', 'Bob Jones', 'Physics', 60000.00);
select * from student;