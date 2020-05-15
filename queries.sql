-- 1) List all the data in the books database
SELECT * FROM AUTHORS;

SELECT * FROM PUBLISHERS;

SELECT * FROM ROYALTIES;

SELECT * FROM TITLES;

SELECT * FROM TITLE_AUTHORS;

-- 2) Find all the info on authors whose last name starts with 'H.'
SELECT * FROM AUTHORS where AU_LNAME like 'H%';

-- 3) Find the title, type, salesprice, published date for all titles published between July 15, 2014 and August 15, 2014
SELECT TITLE_NAME, "TYPE", PRICE, PUBDATE From TITLES
where PUBDATE between '07/15/2014' and '08/15/2014';

-- 4) Find all the information for titles T01, T04, and T07
SELECT * FROM TITLES WHERE TITLE_ID in ('T01', 'T04', 'T07');

-- 5) Find the last name, first name, address, city, state for all authors, Display them in alphabetical order by city within state
SELECT AU_LNAME, AU_LNAME, ADDRESS, CITY, "STATE" from AUTHORS
order by "STATE", CITY;

-- 6) Find the title and sales price for all books that sell for more than $20
SELECT TITLE_NAME, PRICE FROM TITLES where PRICE > 20;