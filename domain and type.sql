--In PostgreSQL, **domains** and **types** serve different purposes:

--Domain: A domain is a user-defined data type that is based on an existing 
--type but with additional constraints. It allows you to enforce rules on values across multiple 
--tables without repeating constraints. For example, you can create a domain for positive integers:
 
 CREATE DOMAIN posint AS INTEGER CHECK (VALUE > 0);
  
  This ensures that any column using `posint` only accepts positive integers.

--Type**: A type in PostgreSQL is more flexible and allows the creation of composite types, 
--enumerations, and custom structures. Unlike domains, types can have multiple attributes. 
--For example, a composite type for an address:
sql
  CREATE TYPE address_type AS (
      street VARCHAR(255),
      city VARCHAR(100),
      zip_code VARCHAR(10)
  );
  
  --This type can be used in tables to store structured data.

--Ways to Use Domains and Types in PostgreSQL:
1.Data Integrity: Domains enforce constraints across multiple tables, ensuring consistency.
2.Reusable Data Structures: Types allow complex data structures to be reused efficiently.
3.Simplified Schema Design: Using domains and types reduces redundancy in defining constraints.
4.Custom Business Rules: Domains encapsulate business rules, making validation easier.
5.Improved Readability: Using meaningful domain names enhances schema clarity.


--Domain Example: Ensuring Valid Emails
Domains allow you to define a custom data type with constraints. Here’s an example of an email domain that enforces a valid format:

CREATE DOMAIN email AS TEXT
CHECK (VALUE ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

Now, if you use `email` in a table, it ensures only correctly formatted email addresses are accepted.
--Usage in a table:

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    user_email email NOT NULL
);

Any invalid email will be rejected when inserting data.

---Type Example: Custom Data Structure for Address
Types allow you to define structured data formats. Here’s an example of a composite type for storing addresses:

CREATE TYPE address_type AS (
    street VARCHAR(255),
    city VARCHAR(100),
    zip_code VARCHAR(10)
);

--Usage in a table:**

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    home_address address_type
);

This makes it easy to store detailed address information in a single column!


--Using Domains in Applications
-- Enforcing Data Integrity
-- Example: An application tracking employee salaries can ensure that no negative salary is entered.
- Solution:
CREATE DOMAIN positive_salary AS NUMERIC CHECK (VALUE > 0);
- Used in a salaries table:
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    salary positive_salary NOT NULL
);

 --This ensures salaries always remain positive.
-- Simplifying Constraints Across Multiple Tables
-- Example: If multiple tables need to store validated phone numbers, you can define a domain rather than writing the same constraint multiple times:

CREATE DOMAIN phone_number AS TEXT CHECK (VALUE ~ '^\d{10}$');


-- Used in different tables (customers, vendors), ensuring phone numbers are correctly formatted.
Using Types in Applications
-- Creating Complex Data Structures
-- Example: An e-commerce application needs to store structured shipping address data.

CREATE TYPE address_type AS (
    street VARCHAR(255),
    city VARCHAR(100),
    zip_code VARCHAR(10)
);
-- Used in a customers table:
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    shipping_address address_type NOT NULL
);

-- This keeps address data well-organized within one column.

-- Grouping Related Data
-- Example: A medical system can define a type for storing patient vital signs:

CREATE TYPE vital_signs AS (
    temperature NUMERIC,
    heart_rate INTEGER,
    blood_pressure VARCHAR(10)
);


-- Used in a patients table:

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    vitals vital_signs
);

-- This makes querying and managing patient data more efficient.
--Advantages in Real Applications
Prevents repetitive constraints
 Improves data consistency
 Allows better data organization
 Enhances schema readability
Domains ensure valid data inputs, while types allow complex structured data. 
Together, they create a more maintainable database design. 

