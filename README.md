# Movies Management System
The goal of this project is to transform business rules into a well-structured database system using Postgres.
This includes designing conceptual, logical, and physical models, implementing the database, and populating it
with sample data, and generating reports
## Phase 1: Database Design 
**1. Conceptual Model**
  - Develop an initial draft based on the business requirements
  - Assumptions to clarify missing or ambiguous requirements

**2. Logical Model**
  - Add entities, attributes, PKs, and FKs
  - Connect entities with M:M relationship

**3. Physical Model**
- Define Datatypes and Constraints
- Check Constraints
## Phase 2: Data Implementation
- Using PostgreSQL
- SQL files which use CREATE TABLE to make tables following the Physical model
- Generated sample data (.csv) using ChatGPT (150 actors, 100 directors, 300 movies, 400 wishlists, 500 rentals, 200 customers), Categories and Advisories based on https://www.alberta.ca/how-alberta-classifies-films.aspx
- Implemented a Python file that pulls the sample data and populates existing tables
## Phase 3: SQL Queries and Reporting
- Created 6 SQL files that manipulate existing tables into reports
  
**SQL Concepts:**
- Joins – Combining data from multiple tables
- Single-row functions – Applying functions to individual rows
- Restricting and sorting data – Filtering and ordering results
- Group functions – Aggregating data (e.g., COUNT, AVG)
- OLAP – Analytical queries
- Subqueries – Using queries within queries
**4. Presentation**
  DEMO:
