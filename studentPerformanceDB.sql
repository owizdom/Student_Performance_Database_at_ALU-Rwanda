-- =========================================
-- Student Performance Database - ALU Rwanda
-- =========================================

-- Drop tables if they already exist (for re-runs)
DROP TABLE IF EXISTS python_grades;
DROP TABLE IF EXISTS linux_grades;
DROP TABLE IF EXISTS students;

-- =====================
-- Create students table
-- =====================
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    intake_year INT NOT NULL
);

-- =========================
-- Create linux_grades table
-- =========================
CREATE TABLE linux_grades (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(50) DEFAULT 'Linux',
    student_id INT,
    grade_obtained DECIMAL(5,2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- ==========================
-- Create python_grades table
-- ==========================
CREATE TABLE python_grades (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(50) DEFAULT 'Python',
    student_id INT,
    grade_obtained DECIMAL(5,2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- ==========================================
-- Insert sample students (at least 15 total)
-- ==========================================
INSERT INTO students (student_name, intake_year) VALUES
('Okechukwu Wisdom', 2025),
('Alvin Johnson', 2025),
('Cynthia David', 2025),
('David Ogo', 2025),
('Esther Dorathy', 2025),
('Frank Johnson', 2025),
('Grace Jafar', 2025),
('Henry Maduabuchi', 2025),
('Isabella Victor', 2025),
('Blessing Okechukwu', 2025),
('James John', 2025),
('Naruto John', 2025),
('Lee Chan', 2025),
('Sam Altman', 2025),
('Charles Daniel', 2025);

-- ==================================
-- Insert Linux course sample grades
-- ==================================
INSERT INTO linux_grades (student_id, grade_obtained) VALUES
(1, 64.00),
(2, 47.50),
(3, 75.00),
(4, 55.00),
(5, 35.00),
(6, 86.00),
(7, 92.00),
(8, 40.00),
(9, 60.00),
(10, 48.00),
(11, 88.00),
(12, 85.00),
(13, 68.00),
(14, 50.00),
(15, 37.00);

-- ===================================
-- Insert Python course sample grades
-- ===================================
INSERT INTO python_grades (student_id, grade_obtained) VALUES
(1, 73.00),
(3, 62.00),
(4, 58.00),
(5, 67.00),
(7, 81.00),
(8, 47.00),
(9, 53.00),
(10, 77.00),
(11, 91.00),
(12, 42.00),
(13, 83.00),
(14, 68.00),
(15, 55.00);

-- ===========================
-- QUERY 1: Students <50 in Linux
-- ===========================
-- Find students who scored less than 50% in the Linux course
SELECT s.student_name, l.grade_obtained
FROM students s
JOIN linux_grades l ON s.student_id = l.student_id
WHERE l.grade_obtained < 50;

-- ==========================================
-- QUERY 2: Students who took only one course
-- ==========================================
SELECT s.student_name
FROM students s
WHERE s.student_id IN (SELECT student_id FROM linux_grades)
  AND s.student_id NOT IN (SELECT student_id FROM python_grades)
UNION
SELECT s.student_name
FROM students s
WHERE s.student_id IN (SELECT student_id FROM python_grades)
  AND s.student_id NOT IN (SELECT student_id FROM linux_grades);

-- ================================
-- QUERY 3: Students who took both
-- ================================
SELECT s.student_name
FROM students s
WHERE s.student_id IN (SELECT student_id FROM linux_grades)
  AND s.student_id IN (SELECT student_id FROM python_grades);

-- ==========================================
-- QUERY 4: Average grade per course
-- ==========================================
SELECT 'Linux' AS course, AVG(grade_obtained) AS average_grade
FROM linux_grades
UNION
SELECT 'Python', AVG(grade_obtained)
FROM python_grades;

-- ========================================================
-- QUERY 5: Top-performing student across both courses
-- (based on average of their grades across available courses)
-- ========================================================
SELECT s.student_name,
       AVG(g.grade_obtained) AS overall_avg
FROM students s
JOIN (
    SELECT student_id, grade_obtained FROM linux_grades
    UNION ALL
    SELECT student_id, grade_obtained FROM python_grades
) g ON s.student_id = g.student_id
GROUP BY s.student_id
ORDER BY overall_avg DESC
LIMIT 1;
