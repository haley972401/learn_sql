/*
	Solving SQL Interview Query | Ungroup given input data | FAANG Interview Query
	https://www.youtube.com/watch?v=xJVWL7eMir0
-- Dataset:
drop table travel_items;
create table travel_items
(
id              int,
item_name       varchar(50),
total_count     int
);
insert into travel_items values
(1, 'Water Bottle', 2),
(2, 'Tent', 1),
(3, 'Apple', 4);


-->> EXPECTED OUTPUT:
ID    ITEM_NAME
1	  Water Bottle
1	  Water Bottle
2	  Tent
3	  Apple
3	  Apple
3	  Apple
3	  Apple
*/
select * from travel_items;
with recursive 
-- SOLUTION 1:
	cte1 as
		(
			select id, item_name, total_count, 1 as cnt
			from travel_items 
			union 
			select id, item_name, total_count, cnt + 1
			from cte  
			where cnt + 1 <= cte.total_count
		)
-- SOLUTION 2:
	, cte2 as
		(
			select id, item_name, total_count, 1 as level
			from travel_items
			union all
			select cte.id, cte.item_name, cte.total_count - 1, level+1 as level
			from cte
			join travel_items t on t.item_name = cte.item_name and t.id = cte.id
			where cte.total_count > 1
		)
        
select * 
from cte
order by 1
