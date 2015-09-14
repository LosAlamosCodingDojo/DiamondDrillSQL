-- Problem 1. Make a new data set that has the average depth and price
-- of the diamonds in the data set.
select avg(depth), avg(price) from diamonds;

-- Problem 2. Add a new column to the data set that records each diamond's
-- price per carat.
select *, price/carat as price_per_carat from diamonds;

-- Problem 3. Make a data set that only includes diamonds with an Ideal cut.
select * from diamonds where cut = "Ideal";

-- Problem 4. Create a new data set that groups diamonds by their cut and
-- displays the average price of each group.
select cut, avg(price) from diamonds group by cut;

-- Proble 5. Create a new data set that groups diamonds by color and
-- displays the average depth and average table for each group.
select color, avg(depth) , avg("table") from diamonds group by color;

-- Proble 6. Add two columns to the diamonds data set. The first column
-- should display the average depth of diamonds in the diamond's color
-- group. The second column should display the average table of diamonds
-- in the diamonds color group.

-- Hint 0: This problem requires the concepts of Subquery and Join.

-- Hint 1: Start with the average depth and average table.
 select color, avg(depth) as avg_depth, avg("table") as avg_table  
from diamonds group by color;

-- Hint 2: Then append (join) avg_depth and avg_table to diamonds.
select * 
from diamonds natural join (
	select color, avg(depth) as avg_depth, avg("table") as avg_table  
	from diamonds group by color) ;

-- Problem 7. Make a data set that contains all of the unique
-- combinations of cut, color, and clarity, as well the average
-- price of diamonds in each group.
select cut, color,  clarity, avg(price) as avg_price
from diamonds group by cut, color, clarity;

-- Problem 8. Add a column to the diamonds data set that
-- displays the average price for all diamonds with a
-- diamond's cut, color, and clarity.

-- Hint 1: This is a combination of Problem 6 and 7.
select *
from diamonds natural join (
	select cut, color, clarity, avg(price) as avg_price
	from diamonds group by cut, color, clarity 
	) ;

-- Problem 9. Do diamonds with the best cut fetch the
-- best price for a given amount of carats?
select cut, avg(price/carat) as price_per_carat
from diamonds
group by cut;

-- Problem 10. Which color diamonds seem to be largest
-- on average (in terms of carats)?
select color, avg(carat) as avg_carat
from diamonds
group by color order by avg_carat;

-- Problem 11. What color of diamonds occurs the most
-- frequently among diamonds with ideal cuts?
select color, count(*) as counts
from diamonds
where cut = "Ideal"
group by color order by counts;

-- Problem 12. Which clarity of diamonds has the
-- largest average table per carats?
select clarity, avg("table"/carat) as table_per_carat
from diamonds
group by clarity order by table_per_carat;

-- Problem 13. Which diamond has the largest price
-- per carat compared other diamonds with its cut,
-- color, and clarity?
-- Hint: Max with in groups, subquery needed.
-- TODO: NOT CORRECT compared to the official answer.
select *, max(price/carat -  price_per_carat) as diff from (
	select *,  avg(price/carat) as price_per_carat
	from diamonds
	group by cut, color, clarity)
group by cut, color, clarity order by diff;

select *, max(price/carat) 
from diamonds
group by cut, color, clarity;

-- Problem 14. What is the average price per
-- carat of diamonds that cost more than $10000? 
select avg(price/carat) 
from  diamonds
where price > 10000;

-- Problem 15. Display the largest diamond depth
-- observed for each clarity group.
select clarity, max(depth)
from diamonds
group by clarity;