insert into generals.g_core 
(name,active)
--one in ten is not active
select 'General ' || i as name,
 cast(i%10 != 0 as Bool) as active
from generate_series(1,500) as i ;

insert into particulars.p_core 
(name,active)
--one in ten is not active
select
 'Particular ' || i as name,
 cast(i%10 != 0 as Bool) as active
from generate_series(1,100000) as i ;


--two "main" general terms (eg Costumers, Products)
insert into relations.g1_in_g2
(g1_core_id,g2_core_id)
select 
	g_core_id as g1_core_id,
	g_core_id%2 +1 as g2_core_id
from 
	generals.g_core
where
	g_core_id > 2 ;

--random relations after g[1] and g[2]
insert into relations.g1_in_g2 
(g1_core_id,g2_core_id)
select
	g1_core_id,
	g2_core_id
from
	(
	select
		g_core_id as g1_core_id
	from
		generals.g_core
	where
		g_core_id > 2) as g1
cross join (
	select
		g_core_id as g2_core_id
	from
		generals.g_core
	where
		g_core_id > 2) as g2
order by
	random()
limit 10000;


--assume 1/3 are main actors, and 1/3 are properties of the main actors
insert into   relations.p1_in_p2 
(p1_core_id,p2_core_id)
	select
	    p_core_id -1 as p1_core_id,
		p_core_id as p2_core_id
	from
		particulars.p_core where p_core_id % 3=0
    ;

-- relate the other part to a secondary actor (one every 6)
insert into  relations.p1_in_p2 
(p1_core_id,p2_core_id)
	select
	    p_core_id - 3 as p1_core_id, 
		p_core_id as p2_core_id
	from
		particulars.p_core where
		p_core_id % 6=1 and p_core_id > 1
    ;

-- relate every main actor to a random secondary actor (eg. employee to department)
with 
secondary_actor_array as 
(
select
	array_agg(x) as saa
from
	(
	select
		generate_series(1, 100000 / 6)* 6 + 1 as x) as p )

insert
	into
	relations.p1_in_p2 
(p1_core_id,
	p2_core_id)
	select
	    p_core_id as p1_core_id, 
		saa[random()*(100000 / 6)] as p2_core_id
from
		particulars.p_core ,
	secondary_actor_array
where
		p_core_id % 3 = 0 
    ;

-- main and secondary actors to G1 and G2
insert into  relations.p_in_g
	(p_core_id,g_core_id,active)
select
	p_core_id, 
	CASE
		WHEN p_core_id % 3 = 0 THEN 1
		WHEN p_core_id % 6 = 1 AND p_core_id > 1 THEN 2
		ELSE random()*(500-2+1)+1
	END as g_core_id,
	True as active 
from 
	particulars.p_core 
   

    
   
   