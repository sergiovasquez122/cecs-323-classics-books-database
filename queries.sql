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

-- 15) List all the books and their authors of all books that have been published by 'Schadenfreude Press'
SELECT AU_FNAME, AU_LNAME, TITLE_NAME from AUTHORS natural join TITLE_AUTHORS natural join TITLES
where PUB_ID = (SELECT PUB_ID from PUBLISHERS where PUB_NAME = 'Schadenfreude Press');

-- 16) List the authors and titles and all the advanced paid for all books
select au_fname, au_lname, title_name, advance*royalty_share from authors inner join title_authors on authors.au_id=title_authors.au_id inner join titles on title_authors.title_id=titles.title_id 
 right outer join royalties on titles.title_id=royalties.title_id;

-- 17) How many books were published by each publisher
SELECT PUB_NAME, count(*) as number_of_books from PUBLISHERS natural join TITLES
group by PUB_NAME order by number_of_books desc;

-- 18) How many books were published by each publisher where the number of books published is greater than 2
SELECT PUB_NAME, count(*) as number_of_books from PUBLISHERS natural join TITLES
group by PUB_NAME having count(*) > 2 order by number_of_books desc;

-- 19) What is the highest advanced paid for a book
SELECT max(ADVANCE) as highest_advance from ROYALTIES;

-- 20) What is the average royalty rate paid
SELECT avg(ROYALTY_RATE) as average_royalty_rate from ROYALTIES;

-- 21) List the total royalties paid out for each book
select title_name, royalty_rate*sales*price from titles 
inner join royalties on titles.title_id=royalties.title_id;

-- 22) What is the total money paid out to each author to date
select au_fname, au_lname, sum ((advance + royalty_rate*price*sales)*royalty_share) as "total money" from authors 
inner join title_authors on authors.au_id=title_authors.au_id inner join titles on title_authors.title_id=titles.title_id 
 inner join royalties on titles.title_id=royalties.title_id
 group by au_fname,au_lname;

-- 23) How many authors live in each state
SELECT "STATE", count(*) as number_of_authors from AUTHORS
group by "STATE" order by number_of_authors desc;

-- 24) How many books were written by each author
SELECT AU_FNAME, AU_LNAME, count(*) as number_of_books from authors natural join title_authors natural join titles
group by au_fname, au_lname order by number_of_books desc;

-- 25) Find the first name and last name for all authors who live in the same state as sarah buchman
SELECT AU_FNAME, AU_LNAME FROM AUTHORS
where "STATE" = (select "STATE" from AUTHORS where AU_FNAME = 'Sarah' and AU_LNAME = 'Buchman');

-- 26) Find the title of all books that have less pages than 'I Blame My Mother'
SELECT TITLE_NAME from TITLES where PAGES < (select pages from titles where title_name = 'I Blame My Mother');

-- 27) Find the books that pay out a lower royalty rate than 'Ask Your System Adminstrator'
SELECT TITLE_NAME, ROYALTY_RATE from TITLES natural join ROYALTIES
where ROYALTY_RATE > (select ROYALTY_RATE from TITLES natural join ROYALTIES where TITLE_NAME = 'Ask Your System Administrator');

-- 28) What is the title and price of the lowest priced book
select title_name, PRICE from titles
where PRICE = (select min(PRICE) from titles);

-- 29) Find the publisher of all books that are the same type as "How About Never?"
SELECT distinct PUBLISHERS.* from publishers natural join titles
where "TYPE" = (select "TYPE" from titles where TITLE_NAME = 'How About Never?');

-- 30) List all city and states where we do business -- where we have authors or publishers. identify each row as either an author or a publisher
SELECT CITY, "STATE", 'author' as category from authors
union
select city, state, 'publisher' as category from PUBLISHERS;

-- 31) list the state in which we have both authors and publishers
SELECT state from authors intersect select state from publishers
order by state;

-- 32) find the list of all authors who have not been published
SELECT AU_FNAME, AU_LNAME from authors except
select AU_FNAME, AU_LNAME from authors inner join 
title_authors on authors.au_id = title_authors.au_id
inner join titles on title_authors.title_id = titles.TITLE_ID
inner join PUBLISHERS on 
TITLES.PUB_ID = PUBLISHERS.PUB_ID;

-- 33) List the publishers that did not publish a book during 2014
SELECT distinct pub_name from PUBLISHERS
except
select distinct pub_name from publishers natural join titles
where year(PUBDATE) = 2014;

-- 34) List the state that in which we have authors, publisher or both. 
select state, 'author' as category from (SELECT "STATE" from AUTHORS
except select "STATE" from PUBLISHERS) as tmp1
union
select state, 'publisher' as category from (
SELECT "STATE" from PUBLISHERS
except select "STATE" from AUTHORS) as tmp2
union
select state, 'both' as category from
(
SELECT "STATE" from PUBLISHERS
intersect
Select state from authors) as tmp3
order by state;

-- 35) List author name, and book title in which the author is the last author listed
select  au.au_fname, au.au_lname, ti.title_name
from    authors au inner join title_authors ta on ta.au_id = au.AU_ID
        inner join titles ti on ti.title_id = ta.TITLE_ID
where   ta.au_order = (
        select  max (au_order)
        from    title_authors ta_inner
        where   ta_inner.title_id = ta.TITLE_ID);

-- 36) Display the title_name and number of author for that title
SELECT TITLE_NAME, count(*) as number_of_authors from titles natural join title_authors
group by TITLE_NAME order by number_of_authors desc;

-- 37) list the authors of the books with the highest sales
SELECT distinct AU_FNAME, AU_LNAME from AUTHORS 
natural join title_authors
natural join titles
where SALES = (select max(SALES) from TITLES);