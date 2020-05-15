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

-- 7) Find the title and number of pages for all books that have sold < 5000 copies
SELECT TITLE_NAME, PAGES FROM TITLES where SALES < 5000;

-- 8) Find the title of all books that have been published by 'Core Dump Books'
SELECT TITLE_NAME FROM PUBLISHERS inner join TITLES
ON PUBLISHERS.PUB_ID = TITLES.PUB_ID 
WHERE PUB_NAME = 'Core Dump Books';

-- 9) Find the title of all books that have not been published by 'Core Dump Books'
SELECT TITLE_NAME FROM PUBLISHERS inner join TITLES
ON PUBLISHERS.PUB_ID = TITLES.PUB_ID 
WHERE PUB_NAME != 'Core Dump Books';

-- 10) List all the different types of books
SELECT DISTINCT "TYPE" FROM TITLES;

-- 11) Find the publisher name of all books that were published in august 2014
SELECT distinct PUB_NAME FROM PUBLISHERS natural join TITLES
where year(PUBDATE) = 2014 and month(PUBDATE) = 8;

-- 12) Find the author that live in the same state as their publisher
SELECT distinct AU_FNAME, AU_LNAME, AUTHORS."STATE" 
from AUTHORS inner join TITLE_AUTHORS 
on AUTHORS.AU_ID = TITLE_AUTHORS.AU_ID inner join TITLES on
TITLE_AUTHORS.TITLE_ID = TITLES.TITLE_ID inner join PUBLISHERS on
TITLES.PUB_ID = PUBLISHERS.PUB_ID
where AUTHORS."STATE" = PUBLISHERS."STATE";

-- 13) Find the list of authors that write history books
SELECT distinct AUTHORS.* from AUTHORS natural join TITLE_AUTHORS natural join TITLES
where "TYPE" = 'history';

-- 14) Find the publisher name of all books whose title starts with 'E'
SELECT distinct PUB_NAME from PUBLISHERS natural join TITLES
where TITLE_NAME like 'E%';