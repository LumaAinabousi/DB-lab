    select *
    from books;

select *
from books
where publishingdate between '01-jan-2017' and '31-dec-2017' or publishingdate between '01-jan-1990' and '31-dec-1999'
order by title;

select *
from books
where lower(title) like '%the%' and ID like '9%';

select *
from books
where price is null;

select *
from books
where price > '7' and lower(title) = 'the hobbit' or lower(title) = 'how to lie with statistics';

select title,price
from books
where lower(title) like 'the%' and price between '5' and '50';



    select *
    from publisher;

select * 
from publisher
where city like 'U__';

select *
from publisher
where lower(PUBLISHEREMAIL) like '%gmail%';

select id,title,price 
from books
where publisherid = '1' or publisherid = '2' and price != '4' and price != '20';

select upper(name) as "Publisher Name", lower(city) as "Address"
from publisher;

select concat( upper(substr(title,1,3)),lower(substr(title,4,length(title))) ) as "Name" , lpad(price,length(title),'*') as "Price"
from books
where length(price) < 9;

select title, price*0.35 as "TAX"
from books
order by price*0.35;

select * 
from books 
order by price desc, title asc;