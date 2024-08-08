select * from movie;
select * from producer;
select * from actor;

select m.name as "Movie Name", releasedate as "Release Date", p.name as "Producer Name"
from movie m, producer p
where m.prod_id = p.id;

select m.name as "Movie Name", p.name as "Producer Name", releasedate as "Release Date"
from movie m, producer p
where m.prod_id = p.id AND to_char(RELEASEDATE, 'YYYY') = '2010';

select m.name as "Movie Name", releasedate as "Release Date"
from movie m, producer p
where m.prod_id = p.id AND to_char(RELEASEDATE, 'YYYY') = '2010';

select m.name as "Movie Name", a.name as "Actor Name"
from movie m, actor a, movie_actor ma
where m.id = ma.mov_id
  AND a.id = ma.act_id;

select m.name as "Movie Name", a.name as "Actor Name"
from movie m, actor a, movie_actor ma, producer p
where m.id = ma.mov_id
  AND a.id = ma.act_id
  AND m.prod_id = p.id
  AND length(substr(p.email,1,instr(p.email,'@'))) > 7;


select m.name as "Movies Produced by DISNEY"
from movie m, producer p
where m.prod_id = p.id
  AND lower(p.name) = 'disney';

select m.name as "Movie Name", p.name as "Producer Name"
from movie m, producer p
where m.prod_id(+) = p.id;

select m.name as "Movie Name", m.releasedate as "Release Date"
from movie m, movie incep
where lower(incep.name) = 'inception'
  AND m.releasedate < incep.releasedate;

select m1.name as "Movie1", m2.name as "Movie2"
from movie m1, movie m2
where m1.prod_id = m2.prod_id
  AND m1.id != m2.id;