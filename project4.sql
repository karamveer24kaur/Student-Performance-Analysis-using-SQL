-- 1. Create the database
CREATE DATABASE IF NOT EXISTS student_performance;
USE student_performance;

DROP TABLE IF EXISTS students;

-- the COMMENT clause is used to add descriptive text to a column
-- ENUM (short for enumeration) is a data type that allows a column to store values chosen from a predefined list of permitted values
-- The CHECK constraint is used to limit the value range that can be placed in a column
-- NOT NULL is a constraint used to enforce that a specific column in a table cannot contain NULL values

CREATE TABLE students_GP (
student_id INT AUTO_INCREMENT PRIMARY KEY,
sex ENUM('M', 'F') NOT NULL,
age INT NOT NULL CHECK (age BETWEEN 15 AND 22),
address ENUM('U', 'R') NOT NULL COMMENT 'U: Urban, R: Rural',
famsize ENUM('LE3', 'GT3') NOT NULL COMMENT 'LE3: ≤3 members, GT3: >3 members',
pstatus ENUM('T', 'A') NOT NULL COMMENT 'T: Living together, A: Apart',
medu INT NOT NULL CHECK (medu BETWEEN 0 AND 4) COMMENT 'Mother education (0:None, 4:Higher)',
fedu INT NOT NULL CHECK (fedu BETWEEN 0 AND 4) COMMENT 'Father education',
mjob VARCHAR(50) NOT NULL COMMENT 'Mother job',
fjob VARCHAR(50) NOT NULL COMMENT 'Father job',
reason ENUM('home', 'reputation', 'course', 'other') NOT NULL,
guardian ENUM('mother', 'father', 'other') NOT NULL,
traveltime INT NOT NULL CHECK (traveltime BETWEEN 1 AND 4) COMMENT '1: <15min, 4: >1h',
studytime INT NOT NULL CHECK (studytime BETWEEN 1 AND 4) COMMENT '1: <2h, 4: >10h',
failures INT NOT NULL COMMENT 'Past class failures',
schoolsup ENUM('yes', 'no') NOT NULL COMMENT 'Extra school support',
famsup ENUM('yes', 'no') NOT NULL COMMENT 'Family educational support',
paid ENUM('yes', 'no') NOT NULL COMMENT 'Extra paid classes',
activities ENUM('yes', 'no') NOT NULL COMMENT 'Extra-curricular activities',
nursery ENUM('yes', 'no') NOT NULL COMMENT 'Attended nursery school',
higher ENUM('yes', 'no') NOT NULL COMMENT 'Wants higher education',
internet ENUM('yes', 'no') NOT NULL COMMENT 'Internet access at home',
famrel INT NOT NULL CHECK (famrel BETWEEN 1 AND 5) COMMENT 'Family relationship quality (1:Bad, 5:Excellent)',
freetime INT NOT NULL CHECK (freetime BETWEEN 1 AND 5) COMMENT 'Free time after school',
goout INT NOT NULL CHECK (goout BETWEEN 1 AND 5) COMMENT 'Going out with friends',
dalc INT NOT NULL CHECK (dalc BETWEEN 1 AND 5) COMMENT 'Workday alcohol consumption',
walc INT NOT NULL CHECK (walc BETWEEN 1 AND 5) COMMENT 'Weekend alcohol consumption',
health INT NOT NULL CHECK (health BETWEEN 1 AND 5) COMMENT 'Health status (1:Bad, 5:Excellent)',
absences INT NOT NULL COMMENT 'Number of school absences',
G1 INT NOT NULL COMMENT 'First period grade (0-20)',
G2 INT NOT NULL COMMENT 'Second period grade',
G3 INT NOT NULL COMMENT 'Final grade'
);

CREATE TABLE students_MS (
student_id INT AUTO_INCREMENT PRIMARY KEY,
sex ENUM('M', 'F') NOT NULL,
age INT NOT NULL CHECK (age BETWEEN 15 AND 22),
address ENUM('U', 'R') NOT NULL COMMENT 'U: Urban, R: Rural',
famsize ENUM('LE3', 'GT3') NOT NULL COMMENT 'LE3: ≤3 members, GT3: >3 members',
pstatus ENUM('T', 'A') NOT NULL COMMENT 'T: Living together, A: Apart',
medu INT NOT NULL CHECK (medu BETWEEN 0 AND 4) COMMENT 'Mother education (0:None, 4:Higher)',
fedu INT NOT NULL CHECK (fedu BETWEEN 0 AND 4) COMMENT 'Father education',
mjob VARCHAR(50) NOT NULL COMMENT 'Mother job',
fjob VARCHAR(50) NOT NULL COMMENT 'Father job',
reason ENUM('home', 'reputation', 'course', 'other') NOT NULL,
guardian ENUM('mother', 'father', 'other') NOT NULL,
traveltime INT NOT NULL CHECK (traveltime BETWEEN 1 AND 4) COMMENT '1: <15min, 4: >1h',
studytime INT NOT NULL CHECK (studytime BETWEEN 1 AND 4) COMMENT '1: <2h, 4: >10h',
failures INT NOT NULL COMMENT 'Past class failures',
schoolsup ENUM('yes', 'no') NOT NULL COMMENT 'Extra school support',
famsup ENUM('yes', 'no') NOT NULL COMMENT 'Family educational support',
paid ENUM('yes', 'no') NOT NULL COMMENT 'Extra paid classes',
activities ENUM('yes', 'no') NOT NULL COMMENT 'Extra-curricular activities',
nursery ENUM('yes', 'no') NOT NULL COMMENT 'Attended nursery school',
higher ENUM('yes', 'no') NOT NULL COMMENT 'Wants higher education',
internet ENUM('yes', 'no') NOT NULL COMMENT 'Internet access at home',
famrel INT NOT NULL CHECK (famrel BETWEEN 1 AND 5) COMMENT 'Family relationship quality (1:Bad, 5:Excellent)',
freetime INT NOT NULL CHECK (freetime BETWEEN 1 AND 5) COMMENT 'Free time after school',
goout INT NOT NULL CHECK (goout BETWEEN 1 AND 5) COMMENT 'Going out with friends',
dalc INT NOT NULL CHECK (dalc BETWEEN 1 AND 5) COMMENT 'Workday alcohol consumption',
walc INT NOT NULL CHECK (walc BETWEEN 1 AND 5) COMMENT 'Weekend alcohol consumption',
health INT NOT NULL CHECK (health BETWEEN 1 AND 5) COMMENT 'Health status (1:Bad, 5:Excellent)',
absences INT NOT NULL COMMENT 'Number of school absences',
G1 INT NOT NULL COMMENT 'First period grade (0-20)',
G2 INT NOT NULL COMMENT 'Second period grade',
G3 INT NOT NULL COMMENT 'Final grade'
);

-- Count records in each table (should match CSV rows)
SELECT 'GP' AS school, COUNT(*) FROM students_GP
UNION ALL
SELECT 'MS' AS school, COUNT(*) FROM students_MS;

-- Sample data check
SELECT * FROM students_GP LIMIT 5;
SELECT * FROM students_MS LIMIT 5;

-- add school columns to each table 
ALTER TABLE students_GP
ADD COLUMN school VARCHAR(2) NOT NULL DEFAULT 'GP';

ALTER TABLE students_MS
ADD COLUMN school VARCHAR(2) NOT NULL DEFAULT 'MS';

SELECT school, COUNT(*) FROM students_GP GROUP BY school;  -- Should show all 'GP'
SELECT school, COUNT(*) FROM students_MS GROUP BY school;  -- Should show all 'MS'

-- UNION
-- the UNION operator is a set operator used to combine the result sets of two or more SELECT statements into a single result set

-- 1.) COMPARING ACADEMIC PERFORMANCE

-- Question: Which school has higher average final grades (G3)?
-- query
SELECT 'GP' AS school, ROUND(AVG(G3),1) AS avg_final_grade
FROM students_GP
UNION ALL
SELECT 'MS' AS school, ROUND(AVG(G3),1) 
FROM students_MS;

-- ANS: Students from the GP school seem to have a higher final grade, hence, better overall performance

-- 2.) ALCOHOL CONSUMPTION IMPACT

-- Question: Do students with higher alcohol consumption (DALC + WALC) have lower grades in either school?
-- query
SELECT school,
CASE 
WHEN dalc + walc <= 4 THEN 'Low'
WHEN dalc + walc <= 8 THEN 'Medium'
ELSE 'High'
END AS alcohol_consumption, ROUND(AVG(G3),1) AS avg_grade
FROM (SELECT 'GP' AS school, dalc, walc, G3 FROM students_GP
UNION ALL
SELECT 'MS' AS school, dalc, walc, G3 FROM students_MS) 
combined -- merging data from different sources, to present a unified view
GROUP BY school, alcohol_consumption
ORDER BY school, alcohol_consumption;

-- ANS: by comparing the low, medium and high of both scools and avg grades, the GS students have higher grades in all situations

-- 3.) STUDY-TIME EFFECTIVENESS

-- Question: How does study time correlate with grades in each school?
-- query
SELECT school, studytime, ROUND(AVG(G3),1) AS avg_grade
FROM (SELECT 'GP' AS school, studytime, G3 FROM students_GP
UNION ALL
SELECT 'MS' AS school, studytime, G3 FROM students_MS) 
combined
GROUP BY school, studytime
ORDER BY school, studytime;
-- ANS: as the study time increased, the grades also increase for both the schools

-- 4.) FAMILY SUPPORT IMPACT

-- Question: Does family support (famsup) improve grades differently across schools?
-- query
SELECT school, famsup, ROUND(AVG(G3),1) AS avg_grade, COUNT(*) AS students
FROM (
SELECT 'GP' AS school, famsup, G3 FROM students_GP
UNION ALL
SELECT 'MS' AS school, famsup, G3 FROM students_MS
) 
combined
GROUP BY school, famsup;

-- ANS: grades do not seem to get affected drastically with or without family support accross schools

-- JOINS
-- used to combine rows from two or more tables based on a related column between them

-- 5.) ABSENTEEISM PATTERNS

-- Question: Which school has higher absenteeism, and does it affect grades?
-- query
SELECT school, ROUND(AVG(combined.absences),1) AS avg_absences, ROUND(AVG(combined.G3),1) AS avg_grade
FROM (
SELECT 'GP' AS school, students_GP.absences, students_GP.G3 FROM students_GP
LEFT JOIN students_MS ON students_GP.student_id = students_MS.student_id
UNION ALL
SELECT 'MS' AS school, students_MS.absences, students_MS.G3 FROM students_MS
) 
combined
GROUP BY school;

-- ANS: GS school has more average absences but a higher average grade too

-- 6.) URBAN VS RURAL PERFORMANCE (CROSS JOIN + CASE) 

-- Question: Compare urban/rural performance 
-- query

-- use cross join to display the result horizontally
SELECT gp.school AS gp_school, ms.school AS ms_school, gp.address, ms.address,
CASE 
	WHEN gp.address = 'U' THEN 'Urban'
	ELSE 'Rural'
END AS gp_area,
CASE 
	WHEN ms.address = 'U' THEN 'Urban'
	ELSE 'Rural'
END AS ms_area,
AVG(gp.G3) AS gp_avg_grade,
AVG(ms.G3) AS ms_avg_grade
FROM students_GP gp
CROSS JOIN students_MS ms
WHERE gp.address = ms.address  -- Compare same address types
GROUP BY gp.address, ms.address, gp.school, ms.school;

-- use union to display the result vertically
SELECT 'GP' AS school,
CASE 
	WHEN gp.address = 'U' THEN 'Urban'
	ELSE 'Rural'
END AS area, AVG(gp.G3) AS avg_grade
FROM students_GP gp
GROUP BY area
UNION ALL
SELECT 'MS' AS school,
CASE 
	WHEN ms.address = 'U' THEN 'Urban'
	ELSE 'Rural'
END AS area, AVG(ms.G3) AS avg_grade
FROM students_MS ms
GROUP BY area;

-- ANS: there is not much difference in the average grade for both type of region

-- 7.) EXTRACURRICULAR ACTIVITIES (SELF JOIN)

-- Question: Do students with activities outperform lonely ones?
-- query
SELECT 'GP' AS school, a.student_id AS active_student, n.student_id AS non_active_student, a.G3 AS active_grade,
n.G3 AS non_active_grade
FROM students_GP a
JOIN students_GP n ON a.student_id != n.student_id AND a.activities = 'yes' AND n.activities = 'no'
LIMIT 10;  -- Show sample comparisons

-- ANS: this shows that students who are active have higher grades


-- to retrieve comments for columns
SELECT COLUMN_NAME, COLUMN_TYPE, COLUMN_COMMENT 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = 'student_performance' AND TABLE_NAME = 'students_MS';