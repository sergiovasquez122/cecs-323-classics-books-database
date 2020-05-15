-- 1) List all the data in the books database
SELECT * FROM AUTHORS;

SELECT * FROM PUBLISHERS;

SELECT * FROM ROYALTIES;

SELECT * FROM TITLES;

SELECT * FROM TITLE_AUTHORS;

-- 2) Find all the info on authors whose last name starts with 'H.'
SELECT * FROM AUTHORS where AU_LNAME like 'H%';
