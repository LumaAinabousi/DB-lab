
select TITLE as "Title", to_char(RELEASEDATE, 'd/mon/yyyy') as "Release Date"
from games;

select TITLE as "Title", RELEASEDATE as "Release Date Before "
from games
where RELEASEDATE < '05-SEP-10';

select TITLE as "Title", RELEASEDATE as "Release Date at November"
from games
where to_char(RELEASEDATE,'MON') = 'NOV';

select TITLE as "Title", nvl(GENRE,'No Genre') as "Genre"
from games;

select TITLE as "Title", RELEASEDATE as "Release Month Starting with an N"
from games
where to_char(RELEASEDATE, 'Mon') like 'N%';

select TITLE as "Title", RELEASEDATE as "Releasedate not at November"
from games
where to_char(RELEASEDATE,'MON') != 'NOV';

select TITLE as "Title", RELEASEDATE as "Release year before or after 1998"
from games
where to_char(RELEASEDATE,'yyyy') != '1998';

select TITLE as "Title", RELEASEDATE as "Release month and year nov-1998"
from games
where to_char(RELEASEDATE,'mon-yyyy') = 'nov-1998';

select  next_day(add_months('24-OCT-90',6) ,'WEDNESDAY') as "First Wednesday after specified date "
from dual;

select *
from developer;

select DEVELOPEREMAIL as "Email", decode( substr( DEVELOPEREMAIL, instr(DEVELOPEREMAIL,'@')+1 , 5 )  ,
                                  'yahoo','Yahoo company',
                                  'gmail','Gmail company',
                                  'hotma','Other') as "Email company"
from developer;

