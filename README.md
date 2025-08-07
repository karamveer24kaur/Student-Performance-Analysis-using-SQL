# 📊 Student Performance Analysis using SQL

## 📌 Overview
This project explores the academic and behavioral performance of students from two different schools using SQL. 
By designing a structured relational database and running analytical queries, the project reveals insights into factors that affect student outcomes, such as study time, alcohol consumption, family support, and extracurricular activities.

## 🎯 Objectives
- Create normalized SQL tables to store student data.
- Import data from two CSV datasets (`students_GP.csv`, `students_MS.csv`).
- Perform comparative SQL queries across schools and behavioral attributes.
- Analyze academic performance and related patterns using SQL operations.

## 🛠️ Tools & Technologies
- **Database**: MySQL
- **Interface**: MySQL Workbench
- **Datasets**: `students_GP.csv`, `students_MS.csv`

## 🧱 Database Schema
Two tables were created with the same structure:
- `students_GP`
- `students_MS`

Each includes:
- Personal details (age, gender, address)
- Family information (parent education, support)
- Behavioral metrics (alcohol use, extracurriculars, absences)
- Academic grades (G1, G2, G3)
- Constraints: `ENUM`, `CHECK`, `NOT NULL`, `AUTO_INCREMENT`, and comments for clarity

## 🔍 Key SQL Queries & Insights
1. **Academic Performance Comparison**  
   ➤ GP students had slightly higher average final grades.

2. **Alcohol Consumption & Grades**  
   ➤ Higher alcohol consumption led to lower academic performance.

3. **Study Time vs. Grades**  
   ➤ More study time correlated with higher grades.

4. **Family Support**  
   ➤ No major impact on final grades across schools.

5. **Absenteeism Analysis**  
   ➤ GP students had more absences but still scored higher.

6. **Urban vs Rural Students**  
   ➤ Minimal differences in performance between urban and rural students.

7. **Extracurricular Activities**  
   ➤ Students involved in activities generally performed better.

## 🎓 Key Learnings
- SQL constraints improve data reliability.
- JOINs and UNIONs help in merging and comparing datasets.
- Behavioral and demographic data can be analyzed effectively using SQL.
- Commenting schemas enhances understanding and maintainability.

## 📁 Project Structure
├── project4.sql # All SQL queries and table definitions
├── students_GP.csv # Student data from GP school
├── students_MS.csv # Student data from MS school
├── README.md # This file
