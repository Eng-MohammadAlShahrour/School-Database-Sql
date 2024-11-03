# School Database Management System

## Overview
This project implements a comprehensive database management system for a school. It includes tables for storing information about students, employees, courses, classes, and various related entities.

## Database Structure
The database is structured as follows:

1. **Information Table**: 
   - Stores personal details of individuals, including full name, national ID, phone number, email, address, and date of birth.

2. **Jobs Table**: 
   - Contains job roles, minimum and maximum salary levels, and required skills.

3. **Employees Table**: 
   - Maintains employee records, including their job ID, personal information ID, hire date, salary, and employment status.

4. **Students Table**: 
   - Keeps track of student information, including class enrollment and registration date.

5. **Courses Table**: 
   - Lists available courses along with credit hours and associated classes.

6. **Classes Table**: 
   - Represents different classes, their names, and the associated academic year and level.

7. **Levels Table**: 
   - Defines the various educational levels (e.g., primary, secondary).

8. **Sections Table**: 
   - Details different sections within classes, including room numbers and maximum student capacity.

9. **Grades Table**: 
   - Records student grades for courses, including classifications.

10. **Schedule Table**: 
    - Manages class schedules, linking sections, courses, employees, and timing.

11. **Terms Table**: 
    - Defines academic terms, their start and end dates, and associated academic years.

12. **Years Table**: 
    - Stores the academic years for reference.

13. **Teacher Notes Table**: 
    - Allows teachers to record notes about students, including feedback on performance.

14. **Grade Classification Table**: 
    - Classifies grades into categories (e.g., Excellent, Very Good).

15. **Student Courses Table**: 
    - Manages the many-to-many relationship between students and courses.

16. **Employees Sections Table**: 
    - Manages the relationship between employees and sections.

## Features
- Comprehensive data model covering various aspects of school management.
- Use of constraints and foreign keys to ensure data integrity.
- Support for multiple entities and relationships to provide a robust educational database.
- Ability to track grades, schedules, and teacher notes effectively.

## Installation
To set up this database:
1. Ensure you have a compatible SQL server (e.g., MySQL, SQL Server).
2. Copy and execute the SQL scripts provided in the project to create the database and tables.
3. Populate the tables with initial data using the provided INSERT statements.

## Usage
Once the database is set up, you can perform operations such as:
- Adding new students or employees.
- Updating records as needed.
- Retrieving information about classes, grades, and schedules.

## Contribution
Feel free to contribute to this project by submitting issues or pull requests.
