CREATE TABLE c(
    c_id int PRIMARY KEY,
    c_name varchar(10)
);

CREATE TABLE S(
    s_id int PRIMARY KEY,  -- 原为 id，改为 s_id
    s_name varchar(10)
);

CREATE TABLE SC(
    sc_id int PRIMARY KEY,
    s_id int,
    c_id int,
    score int
);


insert into c (c_id, c_name)
select null as c_id, concat('c', ID) as c_name
from information_schema.`COLLATIONS`
order by ID asc
limit 0, 10;
 
insert into s (s_id, s_name)
select null as s_id, '' as s_name
from ( 
    select 1 as column_order_id
    from information_schema.`COLUMNS`
    limit 0, 3500
) as t
    cross join (
        select 1 as collation_order_id
        from information_schema.`COLUMNS`
        limit 0, 200
    ) as t2;
     
update s
set s_name = concat('s', s_id)
where s_name = '';
 
insert into sc (sc_id, s_id, c_id, score)
select null as sc_id, t2.s_id, t.c_id, ceiling(rand()*100) as score
from c as t
    cross join s as t2;
