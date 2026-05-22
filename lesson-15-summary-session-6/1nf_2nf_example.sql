CREATE DATABASE university_281125_teacher;

USE university_281125_teacher;

CREATE TABLE student_courses (
	student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    courses VARCHAR(255) NOT NULL,
    teachers VARCHAR(100) NOT NULL
);

TRUNCATE student_courses;

INSERT INTO student_courses
(student_id, student_name, courses, teachers)
VALUES
(1, "Bohdan Liamzin", "SQL, Python", "Donald Knut, Linux Torvalds"),
(2, "Kirill M", "SQL, Java", "Donald Knut, James Gosling");


CREATE TABLE student_courses_1nf (
	student_id INT,
    student_name VARCHAR(30) NOT NULL,
    student_last_name VARCHAR(30) NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    teachers_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (student_id, course_name)
);

INSERT INTO student_courses_1nf
(student_id, student_name, student_last_name, course_name, teachers_name)
VALUES
(1, "Bohdan", "Liamzin", "SQL", "Donald Knut"),
(1, "Bohdan", "Liamzin", "Python", "Linux Torvalds"),
(2, "Kirill", "M", "SQL", "Donald Knut"),
(2, "Kirill", "M", "Java", "James Gosling");

CREATE TABLE students (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL
);

CREATE TABLE courses_2nf (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
    teacher VARCHAR(100) NOT NULL
);

CREATE TABLE enrollments (
	student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    
    PRIMARY KEY (student_id, course_id),
    
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses_2nf(id)
);

INSERT INTO students
(name, last_name)
VALUES
("Bohdan", "Liamzin"),
("Kirill", "M");

TRUNCATE courses_2nf;

INSERT INTO courses_2nf
(name, teacher)
VALUES
("SQL", "Donald Knut"),
("Python", "Linux Torvalds"),
("Java", "James Gosling");

TRUNCATE enrollments;

INSERT INTO enrollments
(student_id, course_id, enrollment_date)
VALUES
(1, 1, "2026-01-01"),
(1, 2, "2026-02-01"),
(2, 1, "2026-01-01"),
(2, 3, "2026-04-01");

SELECT students.id, students.name, students.last_name, courses_2nf.name  FROM
students
JOIN enrollments ON enrollments.student_id = students.id
-- id, name, last_name, student_id, course_id, enrollment_date
JOIN courses_2nf ON enrollments.course_id = courses_2nf.id
-- id, name, last_name, student_id, course_id, enrollment_date, id, name, teacher
WHERE courses_2nf.name = "SQL";