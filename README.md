# Pawradise-Animal-Shelter-Management-System
Relational database implementation in Oracle SQL for an animal shelter NGO featuring schema design, data integrity constraints, and multi-table analytical queries.

# Pawradise Animal Shelter Database System (Oracle SQL)

A complete relational database management system (RDBMS) built with **Oracle SQL** to digitize operations for Pawradise Animal Shelter (a Malaysian NGO). Aligned with **UN SDG 15 (Life on Land)**, the system manages animal welfare, adoptions, medical history, staff duties, volunteer scheduling, and donor tracking.

## Features & Highlights
* **Data Integrity & Constraints:** Primary/foreign keys, domain checks (age, gender, health ratings), and regex validations for Malaysian IC formats and emails.
* **Relational Architecture:** 13 interconnected tables covering core shelter workflows.
* **Advanced Querying:** Implements outer joins, multi-table joins, subqueries, aggregations (`GROUP BY`), and date/string pattern matching.

## Database Schema
Includes entities for `category`, `animal`, `animal_category`, `staff`, `task`, `staff_duty`, `adopter`, `adoption`, `veterinary`, `donor`, `donation`, `volunteer`, and `volunteer_duty`.

## How to Run
1. Open **Oracle APEX**.
2. Execute `animal_shelter_db.sql` to build the schema, insert sample records, and run analytical reports.
