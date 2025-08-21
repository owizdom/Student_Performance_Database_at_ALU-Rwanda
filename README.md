# Student Performance Database – ALU Rwanda  

## Project Overview  
This project is a **pre-class activity** for ALU Rwanda students, designed to practice **MySQL database design and querying skills**.  

The goal is to build a **Student Performance Database** that tracks and analyzes grades of students enrolled in **Linux** and **Python** courses. It demonstrates how to:  
- Create normalized relational database tables.  
- Insert sample data.  
- Use SQL queries (`JOIN`, `UNION`, subqueries, aggregations) to extract meaningful insights.  
- Identify weak and strong performers, course participation, and compute averages.  

The project will be orally defended (viva) with coaches after submission.  

---

##  Database Schema  

The database consists of **three tables**:  

1. **`students`** – Stores student personal info.  
   ```sql
   students(student_id, student_name, intake_year)
   ```
2. linux_grades – Stores grades for Linux course.
```
  linux_grades(course_id, course_name, student_id, grade_obtained)
```
3. python_grades – Stores grades for Python course.
```sql
python_grades(course_id, course_name, student_id, grade_obtained)
```
--

```
## Entity Relationship Diagram (ERD):

   students
   +-------------+
   | student_id  |<-------------------+
   | name        |                    |
   | intake_year |                    |
   +-------------+                    |
                                      |
   linux_grades                       |   python_grades
   +-------------+                    |   +-------------+
   | course_id   |                    |   | course_id   |
   | course_name |                    |   | course_name |
   | student_id  |--------------------+   | student_id  |
   | grade       |                        | grade       |
   +-------------+                        +-------------+
````
--

## Setup Instructions

1️. Clone the repository
```sql
git clone https://github.com/<your-username>/alu-student-performance-db.git
cd alu-student-performance-db
```

2. Load the SQL file in MySQL
   ```sql
  mysql -u root -p < student_performance.sql
  `

## Queries Implemented

The .sql file contains queries with comments for each task.

 1. Insert sample data
```
Populates 15 students with a mix of those who:

Took Linux only

Took Python only

Took both courses
```

2. Find students who scored <50% in Linux
```
SELECT s.student_name, l.grade_obtained
FROM students s
JOIN linux_grades l ON s.student_id = l.student_id
WHERE l.grade_obtained < 50;
```

3. Find students who took only one course

Uses ``UNION`` to combine results.

4. Find students who took both courses

Checks presence in both grade tables.

Calculate average grade per course

Uses ``AVG()`` to find mean performance for Linux and Python separately.

6. Identify top-performing student across both courses
```sql
SELECT s.student_name, AVG(g.grade_obtained) AS overall_avg
FROM students s
JOIN (
    SELECT student_id, grade_obtained FROM linux_grades
    UNION ALL
    SELECT student_id, grade_obtained FROM python_grades
) g ON s.student_id = g.student_id
GROUP BY s.student_id
ORDER BY overall_avg DESC
```


---

Author

```
Okechukwu Wisdom Ikechukwu
```
