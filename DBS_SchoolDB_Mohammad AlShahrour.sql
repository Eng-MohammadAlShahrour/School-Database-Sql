-- Create the SCHOOL_DB database
CREATE DATABASE SCHOOL_DB;

-- Select the SCHOOL_DB for use
USE SCHOOL_DB;

-- Create the Information table with constraints
CREATE TABLE Information (
    info_id INT NOT NULL PRIMARY KEY,  -- Primary key for unique identifier
    name_full VARCHAR(50) NOT NULL,    -- Full name of the individual
    national_id VARCHAR(11) NOT NULL CHECK (LEN(national_id) = 11),  -- National ID with length constraint
    number_phone VARCHAR(10) NOT NULL CHECK (LEN(number_phone) = 7 OR LEN(number_phone) = 10),  -- Phone number with length constraints
    email VARCHAR(50),                 -- Email address
    address VARCHAR(255) NOT NULL,     -- Address of the individual
    date_of_birth DATE NOT NULL        -- Date of birth
);

-- Create the Jobs table with constraints
CREATE TABLE Jobs (
    job_id INT NOT NULL PRIMARY KEY,   -- Primary key for job identification
    name_job VARCHAR(255) NOT NULL,    -- Job title
    minimum INT NOT NULL,              -- Minimum requirement/level for job
    maximum INT NOT NULL,              -- Maximum requirement/level for job
    skills VARCHAR(255) NOT NULL       -- Skills required for the job
);

-- Create the Employees table with constraints
CREATE TABLE Employees (
    employee_id INT NOT NULL PRIMARY KEY,  -- Unique identifier for employees
    job_id INT NOT NULL,                   -- Foreign key for job identifier
    info_id INT NOT NULL,                  -- Foreign key for individual info
    hire_date DATE NOT NULL,               -- Hiring date
    salary FLOAT NOT NULL,                 -- Salary of the employee
    state VARCHAR(50) NOT NULL             -- State of employment (active, resigned, etc.)
);

-- Create the Students table with constraints
CREATE TABLE Students (
    student_id INT NOT NULL PRIMARY KEY,   -- Unique identifier for students
    info_id INT NOT NULL,                  -- Foreign key for individual info
    class_id INT NOT NULL,                 -- Foreign key for class
    date_registration DATE NOT NULL        -- Registration date
);

-- Create the Courses table with constraints
CREATE TABLE Courses (
    course_id INT NOT NULL PRIMARY KEY,    -- Unique identifier for courses
    course_name VARCHAR(255) NOT NULL,     -- Course name
    credits INT NOT NULL,                  -- Credit hours
    class_id INT NOT NULL                  -- Foreign key for class
);

-- Create the Classes table with constraints
CREATE TABLE Classes (
    class_id INT NOT NULL PRIMARY KEY,     -- Unique identifier for classes
    class_name VARCHAR(255) NOT NULL,      -- Class name
    year_id INT NOT NULL,                  -- Foreign key for year
    level_id INT NOT NULL                  -- Foreign key for level
);

-- Create the Levels table with constraints
CREATE TABLE Levels (
    level_id INT NOT NULL PRIMARY KEY,     -- Unique identifier for levels
    level_name VARCHAR(255) NOT NULL       -- Level name (grade, level, etc.)
);

-- Create the Sections table with constraints
CREATE TABLE Sections (
    section_id INT NOT NULL PRIMARY KEY,   -- Unique identifier for sections
    section_name VARCHAR(255) NOT NULL,    -- Section name
    class_id INT NOT NULL,                 -- Foreign key for class
    room_number INT NOT NULL,              -- Room number
    students_max INT NOT NULL              -- Maximum number of students
);

-- Create the Grades table with constraints
CREATE TABLE Grades (
    grade_id INT NOT NULL PRIMARY KEY,     -- Unique identifier for grades
    student_id INT NOT NULL,               -- Foreign key for student
    course_id INT NOT NULL,                -- Foreign key for course
    term_id INT NOT NULL,                  -- Foreign key for term
    classification_id INT NOT NULL,        -- Foreign key for classification
    grade FLOAT NOT NULL CHECK (grade >= 0 AND grade <= 100)  -- Grade value with constraint
);

-- Create the Schedule table with constraints
CREATE TABLE Schedule (
    schedule_id INT NOT NULL PRIMARY KEY,  -- Unique identifier for schedules
    section_id INT NOT NULL,               -- Foreign key for section
    course_id INT NOT NULL,                -- Foreign key for course
    employee_id INT NOT NULL,              -- Foreign key for employee
    day_of_week VARCHAR(50) NOT NULL,      -- Day of the week
    start_time DATETIME NOT NULL,          -- Start time of class
    end_time DATETIME NOT NULL             -- End time of class
);

-- Create the Terms table with constraints
CREATE TABLE Terms (
    term_id INT NOT NULL PRIMARY KEY,      -- Unique identifier for terms
    term_name VARCHAR(255) NOT NULL,       -- Term name
    start_date DATE NOT NULL,              -- Start date of term
    end_date DATE NOT NULL,                -- End date of term
    year_id INT NOT NULL                   -- Foreign key for year
);

-- Create the Years table with constraints
CREATE TABLE Years (
    year_id INT NOT NULL PRIMARY KEY,      -- Unique identifier for years
    year_name VARCHAR(255) NOT NULL        -- Year name
);

-- Create the TeacherNotes table with constraints
CREATE TABLE TeacherNotes (
    note_id INT NOT NULL PRIMARY KEY,      -- Unique identifier for notes
    employee_id INT NOT NULL,              -- Foreign key for employee
    student_id INT NOT NULL,               -- Foreign key for student
    course_id INT NOT NULL,                -- Foreign key for course
    term_id INT NOT NULL,                  -- Foreign key for term
    note VARCHAR(255) NOT NULL,            -- Note content
    note_date DATE NOT NULL                -- Date of the note
);

-- Create the GradeClassification table with constraints
CREATE TABLE GradeClassification (
    classification_id INT NOT NULL PRIMARY KEY,  -- Unique identifier for classifications
    classification_name VARCHAR(255) NOT NULL    -- Classification name
);

-- Create many-to-many table for Students and Courses
CREATE TABLE StudentCourses (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    PRIMARY KEY (student_id, course_id)
);

-- Create many-to-many table for Employees and Sections
CREATE TABLE EmployeesSections (
    employee_id INT NOT NULL,
    section_id INT NOT NULL,
    PRIMARY KEY (employee_id, section_id)
);

-- Add foreign key constraints for Employees
ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Jobs FOREIGN KEY (job_id) REFERENCES Jobs(job_id);
ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Information FOREIGN KEY (info_id) REFERENCES Information(info_id);

-- Add foreign key constraints for Students
ALTER TABLE Students
ADD CONSTRAINT FK_Students_Information FOREIGN KEY (info_id) REFERENCES Information(info_id);
ALTER TABLE Students
ADD CONSTRAINT FK_Students_Classes FOREIGN KEY (class_id) REFERENCES Classes(class_id);

-- Add foreign key constraints for Courses
ALTER TABLE Courses
ADD CONSTRAINT FK_Courses_Classes FOREIGN KEY (class_id) REFERENCES Classes(class_id);

-- Add foreign key constraints for Classes
ALTER TABLE Classes
ADD CONSTRAINT FK_Classes_Levels FOREIGN KEY (level_id) REFERENCES Levels(level_id);

-- Add foreign key constraints for Sections
ALTER TABLE Sections
ADD CONSTRAINT FK_Sections_Classes FOREIGN KEY (class_id) REFERENCES Classes(class_id);

-- Add foreign key constraints for Grades
ALTER TABLE Grades
ADD CONSTRAINT FK_Grades_Students FOREIGN KEY (student_id) REFERENCES Students(student_id);
ALTER TABLE Grades
ADD CONSTRAINT FK_Grades_Courses FOREIGN KEY (course_id) REFERENCES Courses(course_id);
ALTER TABLE Grades
ADD CONSTRAINT FK_Grades_Terms FOREIGN KEY (term_id) REFERENCES Terms(term_id);
ALTER TABLE Grades
ADD CONSTRAINT FK_Grades_Classification FOREIGN KEY (classification_id) REFERENCES GradeClassification(classification_id);

-- Add foreign key constraints for Schedule
ALTER TABLE Schedule
ADD CONSTRAINT FK_Schedule_Sections FOREIGN KEY (section_id) REFERENCES Sections(section_id);
ALTER TABLE Schedule
ADD CONSTRAINT FK_Schedule_Courses FOREIGN KEY (course_id) REFERENCES Courses(course_id);
ALTER TABLE Schedule
ADD CONSTRAINT FK_Schedule_Employees FOREIGN KEY (employee_id) REFERENCES Employees(employee_id);

-- Add foreign key constraints for Terms
ALTER TABLE Terms
ADD CONSTRAINT FK_Terms_Years FOREIGN KEY (year_id) REFERENCES Years(year_id);

-- Add foreign key constraints for TeacherNotes
ALTER TABLE TeacherNotes
ADD CONSTRAINT FK_TeacherNotes_Employees FOREIGN KEY (employee_id) REFERENCES Employees(employee_id);
ALTER TABLE TeacherNotes
ADD CONSTRAINT FK_TeacherNotes_Students FOREIGN KEY (student_id) REFERENCES Students(student_id);
ALTER TABLE TeacherNotes
ADD CONSTRAINT FK_TeacherNotes_Courses FOREIGN KEY (course_id) REFERENCES Courses(course_id);
ALTER TABLE TeacherNotes
ADD CONSTRAINT FK_TeacherNotes_Terms FOREIGN KEY (term_id) REFERENCES Terms(term_id);

-- Add foreign key constraints for StudentCourses
ALTER TABLE StudentCourses
ADD CONSTRAINT FK_StudentCourses_Students FOREIGN KEY (student_id) REFERENCES Students(student_id);
ALTER TABLE StudentCourses
ADD CONSTRAINT FK_StudentCourses_Courses FOREIGN KEY (course_id) REFERENCES Courses(course_id);

-- Add foreign key constraints for EmployeesSections
ALTER TABLE EmployeesSections
ADD CONSTRAINT FK_EmployeesSections_Sections FOREIGN KEY (section_id) REFERENCES Sections(section_id);

-- Add indexes for efficient querying
CREATE NONCLUSTERED INDEX idx_national_id ON Information(national_id);
CREATE NONCLUSTERED INDEX idx_name_job ON Jobs(name_job);
CREATE NONCLUSTERED INDEX idx_job_id ON Employees(job_id);
CREATE NONCLUSTERED INDEX idx_info_id ON Employees(info_id);
CREATE NONCLUSTERED INDEX idx_class_id ON Students(class_id);
CREATE NONCLUSTERED INDEX idx_info_id ON Students(info_id);
CREATE NONCLUSTERED INDEX idx_class_id ON Courses(class_id);
CREATE NONCLUSTERED INDEX idx_level_id ON Classes(level_id);


-- Inserting data into the Years table
INSERT INTO Years (year_id, year_name)
VALUES 
(1, 'Academic Year 2023-2024'),
(2, 'Academic Year 2024-2025');

-- Inserting data into the Terms table
INSERT INTO Terms (term_id, term_name, start_date, end_date, year_id)
VALUES 
(1, 'First Term', '2023-09-01', '2023-12-31', 1),
(2, 'Second Term', '2023-09-01', '2023-12-31', 1);

-- Inserting data into the Levels table
INSERT INTO Levels (level_id, level_name)
VALUES 
(1, 'Primary'),
(2, 'Secondary'),
(3, 'Tertiary');

-- Inserting data into the Classes table
INSERT INTO Classes (class_id, class_name, year_id, level_id)
VALUES 
(1, 'First Class', 1, 1),
(2, 'Second Class', 1, 2),
(3, 'Third Class Advanced', 1, 3);

-- Inserting data into the Sections table
INSERT INTO Sections (section_id, section_name, class_id, room_number, students_max)
VALUES 
(1, 'Section A', 1, 14, 30),
(2, 'Section B', 2, 15, 30);

-- Inserting data into the Courses table
INSERT INTO Courses (course_id, course_name, credits, class_id)
VALUES 
(1, 'Mathematics', 30, 1),
(2, 'Arabic Language', 40, 1),
(3, 'English Language', 20, 2);

-- Inserting data into the Information table with personal details
INSERT INTO Information (info_id, name_full, national_id, number_phone, email, address, date_of_birth)
VALUES 
(1, 'Ahmed Al-Ahmad', '01234567890', '0999999999', 'ahmed@gmail.com', 'Damascus, Syria', '1985-01-15'),
(2, 'Sara Al-Halabi', '12345678901', '0988888888', 'sara@gmail.com', 'Damascus, Syria', '1990-03-22'),
(3, 'Omar Al-Saleh', '23456789012', '0933333333', 'omar@gmail.com', 'Damascus, Syria', '1988-07-10'),
(4, 'Lina Al-Khatib', '34567890123', '0955555555', 'lina@gmail.com', 'Damascus, Syria', '1995-09-17'),
(5, 'Nour Al-Hamisi', '45678901234', '0944444444', 'nour@gmail.com', 'Damascus, Syria', '2000-11-01');

-- Inserting data into the Jobs table with job roles and salary details
INSERT INTO Jobs (job_id, name_job, minimum, maximum, skills)
VALUES 
(1, 'Director', 1, 1, 'Leadership, Management'),
(2, 'Arabic Language Instructor', 5, 10, 'Arabic Language, Communication'),
(3, 'Math Instructor', 5, 10, 'Mathematics, Problem Solving'),
(4, 'English Language Instructor', 5, 10, 'English Language, Communication');

-- Inserting data into the Employees table with job and personal information
INSERT INTO Employees (employee_id, job_id, info_id, hire_date, salary, state)
VALUES 
(1, 1, 1, '2015-09-01', 30000000, 'Active'),  
(2, 2, 2, '2016-06-15', 15000000, 'Active'),  
(3, 3, 3, '2017-01-10', 15000000, 'Active'), 
(4, 4, 4, '2018-08-20', 14000000, 'Retired'); 

-- Inserting data into the Students table with student information
INSERT INTO Students (student_id, info_id, class_id, date_registration)
VALUES 
(1, 5, 1, '2023-01-15'),  
(2, 4, 2, '2022-09-10');  

-- Inserting data into the Schedule table with class scheduling information
INSERT INTO Schedule (schedule_id, section_id, course_id, employee_id, day_of_week, start_time, end_time)
VALUES 
(1, 1, 1, 1, 'Sunday', '2023-10-01 08:00:00', '2023-10-01 09:30:00'),  
(2, 2, 2, 2, 'Tuesday', '2023-10-02 10:00:00', '2023-10-02 11:30:00'); 

-- Inserting data into the GradeClassification table with grading categories
INSERT INTO GradeClassification (classification_id, classification_name)
VALUES 
(1, 'Excellent'),
(2, 'Very Good'),
(3, 'Satisfactory');

-- Inserting data into the Grades table with student grades for each course
INSERT INTO Grades (grade_id, student_id, course_id, term_id, classification_id, grade)
VALUES 
(1, 1, 1, 1, 1, 85.5),  
(2, 2, 2, 1, 1, 90.0);  

-- Inserting teacher notes into the TeacherNotes table
INSERT INTO TeacherNotes (note_id, employee_id, student_id, course_id, term_id, note, note_date)
VALUES 
(1, 1, 1, 1, 1, 'Progress noted in mathematics', '2023-11-10'),  
(2, 2, 2, 2, 1, 'Significant improvement in Arabic', '2023-11-15'); 

-- Inserting student-course relationships into the StudentCourses table
INSERT INTO StudentCourses (student_id, course_id)
VALUES 
(1, 1), 
(2, 2);  

-- Assigning teachers to sections in the EmployeesSections table
INSERT INTO EmployeesSections (employee_id, section_id)
VALUES 
(2, 1),  
(3, 2); 

-- Updating records in the Information table
UPDATE Information
SET name_full = 'Mohamad',
    national_id = '12345678901',
    number_phone = '0961134567',
    email = 'mohamad@gmail.com',
    address = 'Damascus, Syria',
    date_of_birth = '1990-01-01'
WHERE info_id = 4;

-- Updating another record in the Information table
UPDATE Information
SET name_full = 'Tamer',
    national_id = '98765432109',
    number_phone = '0961976543',
    email = 'tamer@gmail.com',
    address = 'Damascus, Syria',
    date_of_birth = '1992-02-02'
WHERE info_id = 5;

-- Complex query: selecting names of students who scored 100 in course 1 and below 50 in course 2
SELECT i.name_full
FROM Students s
JOIN Grades g1 ON s.student_id = g1.student_id AND g1.course_id = 1
JOIN Grades g2 ON s.student_id = g2.student_id AND g2.course_id = 2 
JOIN Information i ON s.info_id = i.info_id
WHERE g1.grade = 100 
AND (g2.grade < 50) 
GROUP BY i.name_full
ORDER BY i.name_full ASC;

-- Counting teachers per course and selecting courses with multiple teachers
SELECT c.course_name, COUNT(DISTINCT e.employee_id) AS num_teachers
FROM Courses c
JOIN Schedule s ON c.course_id = s.course_id
JOIN Employees e ON s.employee_id = e.employee_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(DISTINCT e.employee_id) > 1
ORDER BY num_teachers DESC;

-- Deleting a student record from the Students table
DELETE FROM Students
WHERE student_id = 4;

-- Adding and removing columns and indexes
ALTER TABLE Information
ADD descriptions VARCHAR(255);

ALTER TABLE Information
ALTER COLUMN descriptions INT;

ALTER TABLE Information
DROP COLUMN descriptions;

-- Creating non-clustered indexes on selected columns to speed up querying operations
CREATE NONCLUSTERED INDEX idx_national_id ON Information(national_id); -- Index on 'national_id' column in 'Information' table
CREATE NONCLUSTERED INDEX idx_name_job ON Jobs(name_job); -- Index on 'name_job' column in 'Jobs' table

CREATE NONCLUSTERED INDEX idx_job_id ON Employees(job_id); -- Index on 'job_id' column in 'Employees' table
CREATE NONCLUSTERED INDEX idx_info_id ON Employees(info_id); -- Index on 'info_id' column in 'Employees' table

CREATE NONCLUSTERED INDEX idx_class_id ON Students(class_id); -- Index on 'class_id' column in 'Students' table
CREATE NONCLUSTERED INDEX idx_info_id ON Students(info_id); -- Index on 'info_id' column in 'Students' table

CREATE NONCLUSTERED INDEX idx_class_id ON Courses(class_id); -- Index on 'class_id' column in 'Courses' table

CREATE NONCLUSTERED INDEX idx_level_id ON Classes(level_id); -- Index on 'level_id' column in 'Classes' table

CREATE NONCLUSTERED INDEX idx_class_id ON Sections(class_id); -- Index on 'class_id' column in 'Sections' table

CREATE NONCLUSTERED INDEX idx_student_id ON Grades(student_id); -- Index on 'student_id' column in 'Grades' table
CREATE NONCLUSTERED INDEX idx_course_id ON Grades(course_id); -- Index on 'course_id' column in 'Grades' table

CREATE NONCLUSTERED INDEX idx_section_id ON Schedule(section_id); -- Index on 'section_id' column in 'Schedule' table
CREATE NONCLUSTERED INDEX idx_course_id ON Schedule(course_id); -- Index on 'course_id' column in 'Schedule' table
CREATE NONCLUSTERED INDEX idx_employee_id ON Schedule(employee_id); -- Index on 'employee_id' column in 'Schedule' table

CREATE NONCLUSTERED INDEX idx_employee_id ON TeacherNotes(employee_id); -- Index on 'employee_id' column in 'TeacherNotes' table
CREATE NONCLUSTERED INDEX idx_student_id ON TeacherNotes(student_id); -- Index on 'student_id' column in 'TeacherNotes' table
CREATE NONCLUSTERED INDEX idx_course_id ON TeacherNotes(course_id); -- Index on 'course_id' column in 'TeacherNotes' table

-- Adding a constraint to ensure that the 'salary' in 'Employees' table is above 5,000,000
ALTER TABLE Employees
ADD CONSTRAINT chk_salary_positive CHECK (salary > 5000000);

-- Temporarily disabling the 'chk_salary_positive' constraint on 'Employees' table
ALTER TABLE Employees
NOCHECK CONSTRAINT chk_salary_positive;

-- Removing the 'chk_salary_positive' constraint from 'Employees' table
ALTER TABLE Employees
DROP CONSTRAINT chk_salary_positive;

-- Creating a view to display student information along with their courses and credits
CREATE VIEW View_Course_Student AS
SELECT 
    i.info_id,
    i.name_full,
    i.national_id,
    i.number_phone,
    i.email,
    i.address,
    i.date_of_birth,
    c.course_name,
    c.credits
FROM 
    Information i
JOIN 
    Students s ON i.info_id = s.info_id
JOIN 
    StudentCourses sc ON s.student_id = sc.student_id
JOIN 
    Courses c ON sc.course_id = c.course_id;

-- Selecting all data from 'View_Course_Student'
SELECT * FROM View_Course_Student;

-- Creating a view to display tutor information along with the courses they teach
CREATE VIEW View_Course_Tutor AS
SELECT 
    i.info_id,
    i.name_full,
    i.national_id,
    i.number_phone,
    i.email,
    i.address,
    i.date_of_birth,
    c.course_name
FROM 
    Employees e
JOIN 
    Information i ON e.info_id = i.info_id
JOIN 
    Schedule s ON e.employee_id = s.employee_id
JOIN 
    Courses c ON s.course_id = c.course_id;

-- Selecting all data from 'View_Course_Tutor'
SELECT * FROM View_Course_Tutor;

-- Selecting students from 'Information' table whose phone number starts with '096' and has '1' as the 5th digit
SELECT i.*
FROM Information i
JOIN Students s ON i.info_id = s.info_id
WHERE i.number_phone LIKE '096%25'
  AND SUBSTRING(i.number_phone, 5, 1) = '1';

-- Selecting employees from 'Information' table whose name is 'Mohammad' and phone number ends in '357'
SELECT i.*
FROM Information i
JOIN Employees e ON i.info_id = e.info_id
WHERE i.name_full = 'Mohammad' -- This represents the employee named Mohammad
  AND i.number_phone LIKE '%357';
