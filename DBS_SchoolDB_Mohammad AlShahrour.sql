CREATE DATABASE SCHOOL_DB;

USE SCHOOL_DB;



CREATE TABLE Information (
    info_id INT NOT NULL PRIMARY KEY,
    name_full VARCHAR(50) NOT NULL,
    national_id VARCHAR(11) NOT NULL CHECK (LEN(national_id) = 11),
    number_phone VARCHAR(10) NOT NULL CHECK (LEN(number_phone) = 7 OR LEN(number_phone) = 10),
    email VARCHAR(50),
    address VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL
);

CREATE TABLE Jobs (
    job_id INT NOT NULL PRIMARY KEY,
    name_job VARCHAR(255) NOT NULL,
    minimum INT NOT NULL,
    maximum INT NOT NULL,
    skills VARCHAR(255) NOT NULL
);

CREATE TABLE Employees (
    employee_id INT NOT NULL PRIMARY KEY,
    job_id INT NOT NULL,
    info_id INT NOT NULL,
    hire_date DATE NOT NULL,
    salary FLOAT NOT NULL,
    state VARCHAR(50) NOT NULL
);

CREATE TABLE Students (
    student_id INT NOT NULL PRIMARY KEY,
    info_id INT NOT NULL,
    class_id INT NOT NULL,
	date_registration Date NOT NULL
);

CREATE TABLE Courses (

    course_id INT NOT NULL PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    credits INT NOT NULL,
    class_id INT NOT NULL
);

CREATE TABLE Classes (
    class_id INT NOT NULL PRIMARY KEY,
    class_name VARCHAR(255) NOT NULL,
    year_id INT NOT NULL,
    level_id INT NOT NULL
);

CREATE TABLE Levels (
    level_id INT NOT NULL PRIMARY KEY,
    level_name VARCHAR(255) NOT NULL
);

CREATE TABLE Sections (
    section_id INT NOT NULL PRIMARY KEY,
    section_name VARCHAR(255) NOT NULL,
    class_id INT NOT NULL,
    room_number INT NOT NULL,
    students_max INT NOT NULL
);

CREATE TABLE Grades (
    grade_id INT NOT NULL PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    term_id INT NOT NULL,
    classification_id INT NOT NULL,
    grade Float NOT NULL CHECK (grade >= 0 AND grade <= 100)
);

CREATE TABLE Schedule (
    schedule_id INT NOT NULL PRIMARY KEY,
    section_id INT NOT NULL,
    course_id INT NOT NULL,
    employee_id INT NOT NULL,
    day_of_week VARCHAR(50) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL
);

CREATE TABLE Terms (
    term_id INT NOT NULL PRIMARY KEY,
    term_name VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    year_id INT NOT NULL
);

CREATE TABLE Years (
    year_id INT NOT NULL PRIMARY KEY,
    year_name VARCHAR(255) NOT NULL
);

CREATE TABLE TeacherNotes (
    note_id INT NOT NULL PRIMARY KEY,
    employee_id INT NOT NULL,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    term_id INT NOT NULL,
    note VARCHAR(255) NOT NULL,
    note_date DATE NOT NULL
);

CREATE TABLE GradeClassification (
    classification_id INT NOT NULL PRIMARY KEY,
    classification_name VARCHAR(255) NOT NULL
);

CREATE TABLE StudentCourses (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    PRIMARY KEY (student_id, course_id)
);

CREATE TABLE EmployeesSections (
    employee_id INT NOT NULL,
    section_id INT NOT NULL,
    PRIMARY KEY (employee_id, section_id)
);



--  Employees 
ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Jobs FOREIGN KEY (job_id) REFERENCES Jobs(job_id);
ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Information FOREIGN KEY (info_id) REFERENCES Information(info_id);

--  Students
ALTER TABLE Students
ADD CONSTRAINT FK_Students_Information FOREIGN KEY (info_id) REFERENCES Information(info_id);
ALTER TABLE Students
ADD CONSTRAINT FK_Students_Classes FOREIGN KEY (class_id) REFERENCES Classes(class_id);


--  Courses 
ALTER TABLE Courses
ADD CONSTRAINT FK_Courses_Classes FOREIGN KEY (class_id) REFERENCES Classes(class_id);

--  Classes
ALTER TABLE Classes
ADD CONSTRAINT FK_Classes_Levels FOREIGN KEY (level_id) REFERENCES Levels(level_id);

--  Sections  
ALTER TABLE Sections
ADD CONSTRAINT FK_Sections_Classes FOREIGN KEY (class_id) REFERENCES Classes(class_id);

--  Grades 
ALTER TABLE Grades
ADD CONSTRAINT FK_Grades_Students FOREIGN KEY (student_id) REFERENCES Students(student_id);
ALTER TABLE Grades
ADD CONSTRAINT FK_Grades_Courses FOREIGN KEY (course_id) REFERENCES Courses(course_id);
ALTER TABLE Grades
ADD CONSTRAINT FK_Grades_Terms FOREIGN KEY (term_id) REFERENCES Terms(term_id);
ALTER TABLE Grades
ADD CONSTRAINT FK_Grades_Classification FOREIGN KEY (classification_id) REFERENCES GradeClassification(classification_id);

--  Schedule 
ALTER TABLE Schedule
ADD CONSTRAINT FK_Schedule_Sections FOREIGN KEY (section_id) REFERENCES Sections(section_id);
ALTER TABLE Schedule
ADD CONSTRAINT FK_Schedule_Courses FOREIGN KEY (course_id) REFERENCES Courses(course_id);
ALTER TABLE Schedule
ADD CONSTRAINT FK_Schedule_Employees FOREIGN KEY (employee_id) REFERENCES Employees(employee_id);

--  Terms 
ALTER TABLE Terms
ADD CONSTRAINT FK_Terms_Years FOREIGN KEY (year_id) REFERENCES Years(year_id);

--  TeacherNotes 
ALTER TABLE TeacherNotes
ADD CONSTRAINT FK_TeacherNotes_Employees FOREIGN KEY (employee_id) REFERENCES Employees(employee_id);
ALTER TABLE TeacherNotes
ADD CONSTRAINT FK_TeacherNotes_Students FOREIGN KEY (student_id) REFERENCES Students(student_id);
ALTER TABLE TeacherNotes
ADD CONSTRAINT FK_TeacherNotes_Courses FOREIGN KEY (course_id) REFERENCES Courses(course_id);
ALTER TABLE TeacherNotes
ADD CONSTRAINT FK_TeacherNotes_Terms FOREIGN KEY (term_id) REFERENCES Terms(term_id);

--  StudentCourses 
ALTER TABLE StudentCourses
ADD CONSTRAINT FK_StudentCourses_Students FOREIGN KEY (student_id) REFERENCES Students(student_id);
ALTER TABLE StudentCourses
ADD CONSTRAINT FK_StudentCourses_Courses FOREIGN KEY (course_id) REFERENCES Courses(course_id);

--  EmployeesSections 
ALTER TABLE EmployeesSections
ADD CONSTRAINT FK_EmployeesSections_Sections FOREIGN KEY (section_id) REFERENCES Sections(section_id);


INSERT INTO Years (year_id, year_name)
VALUES 
(1, '«·”‰… «·œ—«”Ì… 2023-2024'),
(2, '«·”‰… «·œ—«”Ì… 2024-2025');

INSERT INTO Terms (term_id, term_name, start_date, end_date, year_id)
VALUES 
(1, '«·›’· «·œ—«”Ì «·√Ê· ', '2023-09-01', '2023-12-31', 1),
(2, '«·›’· «·œ—«”Ì «·À«‰Ì ', '2023-09-01', '2023-12-31', 1);

INSERT INTO Levels (level_id, level_name)
VALUES 
(1, '«» œ«∆Ì'),
(2, '«⁄œ«œÌ'),
(3, 'À«‰ÊÌ');

INSERT INTO Classes (class_id, class_name, year_id, level_id)
VALUES 
(1, '«·’› «·«Ê·', 1, 1),
(2, '«·’› «·”«»⁄', 1, 2),
(3, '«·’› «·Õ«œÌ ⁄‘—', 1, 3);

INSERT INTO Sections (section_id, section_name, class_id, room_number, students_max)
VALUES 
(1, '«·‘⁄»… √', 1, 14, 30),
(2, '«·‘⁄»… »', 2, 15, 30);

INSERT INTO Courses (course_id, course_name, credits, class_id)
VALUES 
(1, '«·—Ì«÷Ì« ', 30, 1),
(2, '«··€… «·⁄—»Ì…', 40, 1),
(3, '«··€… «·≈‰ﬂ·Ì“Ì…', 20,  2);

INSERT INTO Information (info_id, name_full, national_id, number_phone, email, address, date_of_birth)
VALUES 
(1, '√Õ„œ «·√Õ„œ', '01234567890', '0999999999', 'ahmed@gmail.com', 'œ„‘ﬁ° ”Ê—Ì«', '1985-01-15'),
(2, '”«—… «·Õ·»Ì', '12345678901', '0988888888', 'sara@gmail.com', 'œ„‘ﬁ° ”Ê—Ì«', '1990-03-22'),
(3, '⁄„— «·’«·Õ', '23456789012', '0933333333', 'omar@gmail.com', 'œ„‘ﬁ° ”Ê—Ì«', '1988-07-10'),
(4, '·Ì‰« «·ŒÿÌ»', '34567890123', '0955555555', 'lina@gmail.com', 'œ„‘ﬁ° ”Ê—Ì«', '1995-09-17'),
(5, '‰Ê— «·Õ„’Ì', '45678901234', '0944444444', 'nour@gmail.com', 'œ„‘ﬁ° ”Ê—Ì«', '2000-11-01');

INSERT INTO Jobs (job_id, name_job, minimum, maximum, skills)
VALUES 
(1, '„œÌ—', 1, 1, '≈œ«—…°  ‰ŸÌ„'),
(2, '√” «– ·€… ⁄—»Ì…', 5, 10, '·€… ⁄—»Ì…°  Ê«’·'),
(3, '√” «– —Ì«÷Ì« ', 5, 10, '—Ì«÷Ì« ° Õ· «·„‘ﬂ·« '),
(4, '√” «– ·€… ≈‰ﬂ·Ì“Ì…', 5, 10, '·€… «‰ﬂ·Ì“Ì…°  Ê«’·');

INSERT INTO Employees (employee_id, job_id, info_id, hire_date, salary, state)
VALUES 
(1, 1, 1, '2015-09-01', 30000000, 'œ«∆„'),  
(2, 2, 2, '2016-06-15', 15000000, 'œ«∆„'),  
(3, 3, 3, '2017-01-10', 15000000, 'œ«∆„'), 
(4, 4, 4, '2018-08-20', 14000000, ' œ—Ì»'); 

INSERT INTO Students (student_id, info_id, class_id,  date_registration)
VALUES 
(1, 5, 1, '2023-01-15'),  
(2, 4, 2, '2022-09-10');  

INSERT INTO Schedule (schedule_id, section_id, course_id, employee_id, day_of_week, start_time, end_time)
VALUES 
(1, 1, 1, 1, '«·«Õœ', '2023-10-01 08:00:00', '2023-10-01 09:30:00'),  
(2, 2, 2, 2, '«·«À‰Ì‰', '2023-10-02 10:00:00', '2023-10-02 11:30:00'); 


INSERT INTO GradeClassification (classification_id, classification_name)
VALUES 
(1, '„–«ﬂ—… «Ê·Ï'),
(2, '„–«ﬂ—… À«‰Ì…'),
(3, '«„ Õ«‰ ‰Â«∆Ì');

INSERT INTO Grades (grade_id, student_id, course_id, term_id, classification_id, grade)
VALUES 
(1, 1, 1, 1, 1, 85.5),  
(2, 2, 2, 1, 1, 90.0);  


INSERT INTO TeacherNotes (note_id, employee_id, student_id, course_id, term_id, note, note_date)
VALUES 
(1, 1, 1, 1, 1, '„” ÊÏ ÃÌœ ›Ì «·—Ì«÷Ì« ', '2023-11-10'),  
(2, 2, 2, 2, 1, ' Õ”‰ „·ÕÊŸ ›Ì «··€… «·⁄—»Ì…', '2023-11-15'); 


INSERT INTO StudentCourses (student_id, course_id)
VALUES 
(1, 1), 
(2, 2);  

INSERT INTO EmployeesSections (employee_id, section_id)
VALUES 
(2, 1),  
(3, 2); 



UPDATE Information
SET name_full = '„Õ„œ',
    national_id = '12345678901',
    number_phone = '0961134567',
    email = 'mohamad@gmail.com',
    address = 'œ„‘ﬁ° ”Ê—Ì«',
    date_of_birth = '1990-01-01'
WHERE info_id = 4;

UPDATE Information
SET name_full = ' «„—',
    national_id = '98765432109',
    number_phone = '0961976543',
    email = 'tamer@gmail.com',
    address = 'œ„‘ﬁ° ”Ê—Ì«',
    date_of_birth = '1992-02-02'
WHERE info_id = 5;



SELECT i.name_full
FROM Students s
JOIN Grades g1 ON s.student_id = g1.student_id AND g1.course_id = 1
JOIN Grades g2 ON s.student_id = g2.student_id AND g2.course_id = 2 
JOIN Information i ON s.info_id = i.info_id
WHERE g1.grade = 100 
AND (g2.grade < 50) 
GROUP BY i.name_full
ORDER BY i.name_full ASC; 



SELECT c.course_name, COUNT(DISTINCT e.employee_id) AS num_teachers
FROM Courses c
JOIN Schedule s ON c.course_id = s.course_id
JOIN Employees e ON s.employee_id = e.employee_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(DISTINCT e.employee_id) > 1
ORDER BY num_teachers DESC;



DELETE FROM Students
WHERE student_id = 4;




ALTER TABLE Information
ADD descriptions VARCHAR(255);



ALTER TABLE Information
ALTER COLUMN descriptions INT;





ALTER TABLE Information
DROP COLUMN descriptions;



CREATE NONCLUSTERED INDEX idx_national_id ON Information(national_id);


CREATE NONCLUSTERED INDEX idx_name_job ON Jobs(name_job);


CREATE NONCLUSTERED INDEX idx_job_id ON Employees(job_id);
CREATE NONCLUSTERED INDEX idx_info_id ON Employees(info_id);


CREATE NONCLUSTERED INDEX idx_class_id ON Students(class_id);
CREATE NONCLUSTERED INDEX idx_info_id ON Students(info_id);


CREATE NONCLUSTERED INDEX idx_class_id ON Courses(class_id);


CREATE NONCLUSTERED INDEX idx_level_id ON Classes(level_id);


CREATE NONCLUSTERED INDEX idx_class_id ON Sections(class_id);


CREATE NONCLUSTERED INDEX idx_student_id ON Grades(student_id);
CREATE NONCLUSTERED INDEX idx_course_id ON Grades(course_id);


CREATE NONCLUSTERED INDEX idx_section_id ON Schedule(section_id);
CREATE NONCLUSTERED INDEX idx_course_id ON Schedule(course_id);
CREATE NONCLUSTERED INDEX idx_employee_id ON Schedule(employee_id);


CREATE NONCLUSTERED INDEX idx_employee_id ON TeacherNotes(employee_id);
CREATE NONCLUSTERED INDEX idx_student_id ON TeacherNotes(student_id);
CREATE NONCLUSTERED INDEX idx_course_id ON TeacherNotes(course_id);





ALTER TABLE Employees
ADD CONSTRAINT chk_salary_positive CHECK (salary > 5000000);
 


 ALTER TABLE Employees
NOCHECK CONSTRAINT chk_salary_positive;




 ALTER TABLE Employees
DROP CONSTRAINT chk_salary_positive;



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

	SELECT * FROM View_Course_Student;



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

	SELECT * FROM View_Course_Tutor;




SELECT i.*
FROM Information i
JOIN Students s ON i.info_id = s.info_id
WHERE i.number_phone LIKE '096%25'
  AND SUBSTRING(i.number_phone, 5, 1) = '1';



SELECT i.*
FROM Information i
JOIN Employees e ON i.info_id = e.info_id
WHERE i.name_full = '≈»—«ÂÌ„'
  AND i.number_phone LIKE '%357';


