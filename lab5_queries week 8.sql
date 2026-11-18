-- ============================================
-- VUA-SEN307 Lab 5: SELECT, Filtering and Joins
-- Name: Ajibade Richard Matric: VUG/SEN/24/12291
-- ============================================
USE sen307_12291;

-- Task 1: Students in one department, sorted A-Z
SELECT s.student_id, s.full_name, d.dept_name
FROM Student s
INNER JOIN Department d ON s.dept_id = d.dept_id
WHERE d.dept_name = 'Software Engineering'
ORDER BY s.full_name ASC;
-- Explanation: Joins Student to Department on dept_id, keeps only
-- Software Engineering students with WHERE, and sorts them
-- alphabetically by full_name using ORDER BY ... ASC.

-- Task 2: Courses with their lecturers (INNER JOIN)
SELECT c.course_title, l.full_name AS lecturer_name
FROM Course c
INNER JOIN CourseAllocation ca ON c.course_id = ca.course_id
INNER JOIN Lecturer l ON ca.lecturer_id = l.lecturer_id
ORDER BY c.course_title;
-- Explanation: Course and Lecturer are linked only through the
-- CourseAllocation table, so two INNER JOINs are needed. INNER JOIN
-- returns only rows with a match in both tables, so a course with two
-- lecturers appears twice and a course with no lecturer is left out.

-- Task 3: Students and their courses (LEFT JOIN)
SELECT s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
ORDER BY s.full_name;
-- Explanation: LEFT JOIN keeps every student (the left table). Students
-- with no enrolment get NULL in course_title.

-- Task 3b: Only students with no enrolments
SELECT s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
WHERE c.course_title IS NULL
ORDER BY s.full_name;
-- Explanation: Adding WHERE ... IS NULL filters out matched rows, leaving
-- only the students who are not enrolled in any course (the two created
-- in Week 6).

-- Task 4: Filtering with AND / OR / IN / BETWEEN
SELECT s.student_id, s.full_name, s.gender, s.dept_id, s.date_of_birth
FROM Student s
WHERE s.gender = 'F'
  AND s.dept_id IN (1, 3)
  AND s.date_of_birth BETWEEN '2004-01-01' AND '2005-12-31'
ORDER BY s.full_name;
-- Explanation: Female students in department 1 or 3 (Software
-- Engineering or Artificial Intelligence) born between 2004-01-01 and
-- 2005-12-31 inclusive. Uses AND, IN and BETWEEN. Check that dept_id 1
-- and 3 match those departments in your Department table.

-- Task 4b: Same idea, also using OR (brackets are essential)
SELECT s.student_id, s.full_name, s.gender, s.dept_id, s.date_of_birth
FROM Student s
WHERE s.gender = 'F'
  AND (s.dept_id = 1 OR s.dept_id = 3)
  AND s.date_of_birth BETWEEN '2004-01-01' AND '2005-12-31'
ORDER BY s.full_name;
-- Explanation: Equivalent to Task 4 but with OR. The brackets make OR
-- apply only to the department check; without them AND binds tighter and
-- the result would be wrong.

-- Task 5: Paginating enrolments with LIMIT and OFFSET
-- Page 1 (rows 1-10)
SELECT * FROM Enrolment
ORDER BY enrolment_id
LIMIT 10 OFFSET 0;

-- Page 2 (rows 11-20)
SELECT * FROM Enrolment
ORDER BY enrolment_id
LIMIT 10 OFFSET 10;
-- Explanation: LIMIT 10 returns 10 rows; OFFSET skips rows already shown.
-- ORDER BY must always accompany LIMIT because without it SQL gives no
-- guaranteed row order, so pages could repeat or skip rows.

-- Challenge: Task 3 rewritten with RIGHT JOIN
SELECT s.full_name, c.course_title
FROM Course c
RIGHT JOIN Enrolment e ON c.course_id = e.course_id
RIGHT JOIN Student s ON e.student_id = s.student_id
ORDER BY s.full_name;
-- Explanation: Same result as Task 3. Student is placed last so the
-- RIGHT JOINs keep every student. The LEFT JOIN version is easier to
-- read because it starts from the table we care about (Student) and
-- reads left to right: student -> enrolment -> course.
