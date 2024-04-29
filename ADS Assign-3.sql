-- Create Classroom table
use assign;
CREATE TABLE Classroom (
    building VARCHAR(255),
    room_number INT,
    capacity INT,
    PRIMARY KEY (building, room_number)
);

-- Create Department table
CREATE TABLE Department (
    dept_name VARCHAR(255),
    building VARCHAR(255),
    budget DECIMAL(10, 2),
    PRIMARY KEY (dept_name),
    FOREIGN KEY (building) REFERENCES Classroom(building)
);

-- Create Course table
CREATE TABLE Course (
    course_id INT,
    title VARCHAR(255),
    dept_name VARCHAR(255),
    credits INT,
    PRIMARY KEY (course_id),
    FOREIGN KEY (dept_name) REFERENCES Department(dept_name)
);

-- Create Instructor table
CREATE TABLE Instructor (
    ID INT,
    name VARCHAR(255),
    dept_name VARCHAR(255),
    salary DECIMAL(10, 2),
    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name) REFERENCES Department(dept_name)
);

-- Create Section table
CREATE TABLE Section (
    course_id INT,
    sec_id INT,
    semester VARCHAR(255),
    year INT,
    building VARCHAR(255),
    room_number INT,
    time_slot_id INT,
    PRIMARY KEY (course_id, sec_id, semester, year),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (building, room_number) REFERENCES Classroom(building, room_number),
    FOREIGN KEY (time_slot_id) REFERENCES TimeSlot(time_slot_id)
);

-- Create Teaches table
CREATE TABLE Teaches (
    ID INT,
    course_id INT,
    sec_id INT,
    semester VARCHAR(255),
    year INT,
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (ID) REFERENCES Instructor(ID),
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES Section(course_id, sec_id, semester, year)
);

-- Create Student table
CREATE TABLE Student (
    ID INT,
    name VARCHAR(255),
    dept_name VARCHAR(255),
    tot_cred INT,
    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name) REFERENCES Department(dept_name)
);

-- Create Takes table
CREATE TABLE Takes (
    ID INT,
    course_id INT,
    sec_id INT,
    semester VARCHAR(255),
    year INT,
    grade VARCHAR(2),
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (ID) REFERENCES Student(ID),
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES Section(course_id, sec_id, semester, year)
);

-- Create Advisor table
CREATE TABLE Advisor (
    s_ID INT,
    i_ID INT,
    PRIMARY KEY (s_ID),
    FOREIGN KEY (s_ID) REFERENCES Student(ID),
    FOREIGN KEY (i_ID) REFERENCES Instructor(ID)
);

-- Create TimeSlot table
CREATE TABLE TimeSlot (
    time_slot_id INT,
    day VARCHAR(255),
    start_time TIME,
    end_time TIME,
    PRIMARY KEY (time_slot_id)
);

-- Create Prereq table
CREATE TABLE Prereq (
    course_id INT,
    prereq_id INT,
    PRIMARY KEY (course_id, prereq_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (prereq_id) REFERENCES Course(course_id)
);
