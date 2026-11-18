-- VUA-SEN307 Week 6 Practical: Lab 4 (DML)


USE sen307_<VUG/SEN/24/12291>;

-- =========================================================
-- PART 1: Departments and Courses (provided)
-- =========================================================
INSERT INTO Department (dept_name) VALUES
('Software Engineering'),
('Computer Science'),
('Artificial Intelligence'),
('Data Science'),
('Cybersecurity');

INSERT INTO Course (course_code, course_title, credit_units, description, dept_id) VALUES
('SEN307', 'Database Systems', 3,
'Relational database design, SQL queries, normalization, transactions and indexing using MySQL.',
(SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')),
('SEN301', 'Software Architecture', 3,
'Architectural styles, design patterns, microservices and how to structure large software systems.',
(SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')),
('COS301', 'Operating Systems', 3,
'Processes, threads, CPU scheduling, memory management and file systems.',
(SELECT dept_id FROM Department WHERE dept_name = 'Computer Science')),
('COS305', 'Computer Networks', 3,
'TCP/IP, routing, switching, LAN and WAN design and network protocols.',
(SELECT dept_id FROM Department WHERE dept_name = 'Computer Science')),
('AIN301', 'Introduction to Artificial Intelligence', 3,
'Intelligent agents, search algorithms, knowledge representation and reasoning.',
(SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('AIN305', 'Machine Learning', 3,
'Supervised and unsupervised learning, neural networks, deep learning and model evaluation.',
(SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('AIN307', 'Natural Language Processing', 3,
'Text processing, word embeddings, language models, sentiment analysis and chatbots.',
(SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('DTS301', 'Data Visualization and Analytics', 2,
'Exploratory data analysis, charts, dashboards and telling stories with data.',
(SELECT dept_id FROM Department WHERE dept_name = 'Data Science')),
('DTS305', 'Big Data Technologies', 3,
'Distributed storage and processing of very large datasets with Hadoop and Spark.',
(SELECT dept_id FROM Department WHERE dept_name = 'Data Science')),
('CYB301', 'Network Security', 3,
'Firewalls, cryptography, intrusion detection and protecting networks from attacks.',
(SELECT dept_id FROM Department WHERE dept_name = 'Cybersecurity'));

SELECT d.dept_name, COUNT(c.course_id) AS courses
FROM Department d LEFT JOIN Course c ON d.dept_id = c.dept_id
GROUP BY d.dept_name;

SELECT dept_id, dept_name FROM Department;
SELECT course_id, course_code FROM Course;

-- =========================================================
-- PART 2: Own data
-- dept_id: 1 Software Eng, 2 Computer Sci, 3 AI, 4 Data Sci, 5 Cybersecurity
-- =========================================================

-- Step 1: Lecturers (10)
INSERT INTO Lecturer (staff_no, full_name, email, dept_id) VALUES
('VUA/ST/101', 'Dr Amaka Okafor',       'a.okafor@vua.edu.ng',    1),
('VUA/ST/102', 'Dr Musa Bello',         'm.bello@vua.edu.ng',     1),
('VUA/ST/103', 'Prof Chinedu Eze',      'c.eze@vua.edu.ng',       2),
('VUA/ST/104', 'Dr Fatima Abdullahi',   'f.abdullahi@vua.edu.ng', 2),
('VUA/ST/105', 'Dr Olumide Adeyemi',    'o.adeyemi@vua.edu.ng',   3),
('VUA/ST/106', 'Dr Ngozi Nwosu',        'n.nwosu@vua.edu.ng',     3),
('VUA/ST/107', 'Dr Ibrahim Yusuf',      'i.yusuf@vua.edu.ng',     3),
('VUA/ST/108', 'Dr Blessing Udoh',      'b.udoh@vua.edu.ng',      4),
('VUA/ST/109', 'Dr Tunde Balogun',      't.balogun@vua.edu.ng',   4),
('VUA/ST/110', 'Dr Halima Garba',       'h.garba@vua.edu.ng',     5);

-- Step 2: Students (20). Student 1 = Ajibade Richard 12291.
INSERT INTO Student (matric_no, full_name, gender, date_of_birth, dept_id) VALUES
('12291',    'Ajibade Richard',       'M', '2005-03-14', 1),
('20231235', 'John Musa',          'M', '2004-11-02', 2),
('20231236', 'Chiamaka Nnamdi',    'F', '2005-07-21', 1),
('20231237', 'Emeka Okonkwo',      'M', '2003-09-09', 1),
('20231238', 'Aisha Mohammed',     'F', '2004-01-30', 3),
('20231239', 'Tobi Adebayo',       'M', '2006-05-17', 3),
('20231240', 'Zainab Lawal',       'F', '2005-12-05', 3),
('20231241', 'Segun Ogunleye',     'M', '2003-04-25', 4),
('20231242', 'Ifeoma Chukwu',      'F', '2006-08-11', 1),
('20231243', 'Abdul Sanni',        'M', '2004-06-28', 5),
('20231244', 'Grace Effiong',      'F', '2007-02-19', 2),
('20231245', 'Daniel Ibekwe',      'M', '2005-10-03', 2),
('20231246', 'Hauwa Usman',        'F', '2004-03-12', 4),
('20231247', 'Kelechi Anyanwu',    'M', '2006-11-23', 2),
('20231248', 'Folake Ajayi',       'F', '2003-12-31', 5),
('20231249', 'Yusuf Danjuma',      'M', '2005-09-15', 3),
('20231250', 'Peace Akpan',        'F', '2007-06-06', 5),
('20231251', 'Victor Onyeama',     'M', '2006-01-09', 3),
('20231252', 'Rukayat Salami',     'F', '2004-08-20', 4),
('20231253', 'Samuel Agu',         'M', '2005-04-01', 1);

-- Step 3: check IDs
SELECT student_id, matric_no, full_name FROM Student;
SELECT lecturer_id, full_name FROM Lecturer;

-- Enrolments (40). Students 19 and 20 are deliberately NOT enrolled.
-- Course 1 (SEN307) has 8 students.
INSERT INTO Enrolment (student_id, course_id) VALUES
(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),   -- SEN307: 8
(1,2),(3,2),(9,2),(10,2),                           -- SEN301: 4
(2,3),(11,3),(12,3),(13,3),                         -- COS301: 4
(4,4),(11,4),(14,4),(15,4),                         -- COS305: 4
(5,5),(9,5),(16,5),(17,5),                          -- AIN301: 4
(6,6),(10,6),(16,6),(18,6),                         -- AIN305: 4
(7,7),(12,7),(17,7),(18,7),                         -- AIN307: 4
(8,8),(13,8),                                       -- DTS301: 2
(15,9),(16,9),(18,9),                               -- DTS305: 3
(9,10),(12,10),(17,10);                             -- CYB301: 3

-- Course allocations (11): every course has a lecturer; course 1 has two.
INSERT INTO CourseAllocation (course_id, lecturer_id) VALUES
(1,1),(1,2),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10);

-- =========================================================
-- PART 3: UPDATE
-- =========================================================
SELECT matric_no, full_name, dept_id FROM Student WHERE matric_no = '12291';
UPDATE Student SET dept_id = 2 WHERE matric_no = '12291';
SELECT matric_no, full_name, dept_id FROM Student WHERE matric_no = '12291';

-- If Error 1175 appears:
-- SET SQL_SAFE_UPDATES = 0;
-- (run the UPDATE/DELETE)
-- SET SQL_SAFE_UPDATES = 1;

-- =========================================================
-- PART 4: Referential integrity
-- =========================================================
-- Step 1
INSERT INTO Department (dept_name) VALUES ('Library and Information Science');
INSERT INTO Student (matric_no, full_name, dept_id)
VALUES ('20239999', 'Transfer Student',
(SELECT dept_id FROM Department WHERE dept_name = 'Library and Information Science'));

-- Step 2: expected to FAIL with Error 1451 (screenshot this!)
DELETE FROM Department WHERE dept_name = 'Library and Information Science';

-- Step 3: fix correctly
UPDATE Student
SET dept_id = (SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')
WHERE matric_no = '20239999';

DELETE FROM Department WHERE dept_name = 'Library and Information Science';

SELECT * FROM Department;

-- =========================================================
-- FINAL CHECK (screenshot this!)
-- =========================================================
SELECT 'Departments' AS tbl, COUNT(*) AS total FROM Department
UNION ALL SELECT 'Lecturers', COUNT(*) FROM Lecturer
UNION ALL SELECT 'Students', COUNT(*) FROM Student
UNION ALL SELECT 'Courses', COUNT(*) FROM Course
UNION ALL SELECT 'Enrolments', COUNT(*) FROM Enrolment
UNION ALL SELECT 'Allocations', COUNT(*) FROM CourseAllocation;
