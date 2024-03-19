-- Data Definition Language (DDL)

-- Create a Table Syntax:
-- CREATE TABLE table_name (col_name_1 DATATYPE, col_name_2 DATATYPE, etc)
-- table_name --> lower case and singular 

CREATE TABLE IF NOT EXISTS blog_user ( --IF this TABLE EXISTS, it will NOT be created 
	-- Column Name DataType <optional constraints>
	user_id SERIAL PRIMARY KEY, -- Primary key makes sure column is both unique and not null 
	username VARCHAR(25) NOT NULL UNIQUE,
	pw_hash VARCHAR NOT NULL, -- NOT NULL means must NOT be empty?
	first_name VARCHAR(50), -- WITHOUT specifying, can be NULL OR NOT UNIQUE 
	last_name VARCHAR(50), 
	email VARCHAR(50) NOT NULL 
);

SELECT * FROM blog_user; -- NOTHING IN the TABLE, but the TABLE now EXISTS

-- To MAKE CHANGES to a Table after its creation, we use ALTER 
-- Rename column
-- ALTER TABLE table_name RENAME COLUMN current_col_name TO new_col_name
ALTER TABLE blog_user RENAME COLUMN email TO email_address;

-- Add a column:
-- ALTER TABLE table_name ADD COLUMN new_column_name DATATYPE
ALTER TABLE blog_user ADD COLUMN IF NOT EXISTS middle_name VARCHAR;

-- Change a Column's Datatype:
-- ALTER TABLE table_name ALTER COLUMN col_name TYPE new_datatype
ALTER TABLE blog_user ALTER COLUMN email_address TYPE VARCHAR(30);

CREATE TABLE IF NOT EXISTS post (
	post_id SERIAL PRIMARY KEY,
	title VARCHAR(50) NOT NULL,
	body VARCHAR NOT NULL,
	date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	-- To create a FOREIGN KEY:
	-- 2 Steps, Step 1: create column normally
	user_id INTEGER NOT NULL,
	-- Step 1: add the foreign key
	-- Syntax: FOREIGN KEY(col_in_domestic_table) REFRENCES foreign_table_name(col_in_foreign_table)
	FOREIGN KEY(user_id) REFERENCES blog_user(user_id)
);

SELECT current_timestamp;
SELECT * FROM post;

CREATE TABLE IF NOT EXISTS post_category (
	post_id INTEGER NOT NULL,
	FOREIGN KEY(post_id) REFERENCES post(post_id),
	category_id INTEGER NOT NULL
	-- FOREIGN KEY(category_id) REFERENCES category(category_id) -- would REF a TABLE that doesn't exist 
);

SELECT * FROM post_category;


CREATE TABLE IF NOT EXISTS category (
	category_id SERIAL PRIMARY KEY,
	category_name VARCHAR(25) NOT NULL,
	description VARCHAR
)


-- Now that the Category table is created, we can add the FK from post_category
-- ALTER TABLE table_name ADD FOREIGN KEY(col_in_domestic_table) REFERENCES foreign_table_name(col_in_foreign_table)
ALTER TABLE post_category
ADD FOREIGN KEY(category_id) REFERENCES category(category_id);


-- Add comment table
CREATE TABLE post_comment (
	comment_id SERIAL PRIMARY KEY,
	body VARCHAR NOT NULL,
	date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	user_id INTEGER NOT NULL,
	FOREIGN KEY(user_id) REFERENCES blog_user(user_id),
	post_id INTEGER NOT NULL,
	FOREIGN KEY(post_id) REFERENCES post(post_id)
);


-- DROPPING 
-- create a table to eventually be deleted
CREATE TABLE delete_me(
	test_id SERIAL PRIMARY KEY,
	col_1 INTEGER,
	col_2 BOOLEAN
);

SELECT * FROM delete_me dm 

-- How to remove a column 
-- Syntax: ALTER TABLE table_name DROP COLUMN column_name
ALTER TABLE delete_me DROP COLUMN col_2;


-- Remove entire table 
-- Syntax: use DROP TABLE table_name, can use IF EXISTS 
DROP TABLE delete_me;

