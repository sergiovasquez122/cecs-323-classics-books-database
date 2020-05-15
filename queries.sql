-- 1) List all the data in the books database
SELECT * FROM AUTHORS;

SELECT * FROM PUBLISHERS;

SELECT * FROM ROYALTIES;

SELECT * FROM TITLES;

SELECT * FROM TITLE_AUTHORS;

-- 2) Find all the info on authors whose last name starts with 'H.'
SELECT * FROM AUTHORS where AU_LNAME like 'H%';

-- 3) Find the title, type salesprice, and published date for all books published between July 15,2014 and August 15, 2014
SELECT TITLE_NAME, 'TYPE', PRICE, PUBDATE FROM TITLES WHERE PUBDATE BETWEEN '07/15/2014' and '08/15/2014';
