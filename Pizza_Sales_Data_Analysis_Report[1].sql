create database Analysis;
use analysis;

-- data importing using "Table data Import Wizard"


select * from pizza_sales;










-- ================== Now check the data types of all columns ==============================

-- 1. pizza_id has correct data type 
-- 2. order_id has correct data type 
-- 3. pizza_name_id
Alter table pizza_sales modify column pizza_name_id varchar(100);

-- 4. quantity has correct data type 
-- 5. oder_date
ALTER TABLE pizza_sales ADD COLUMN ordered_date DATE; -- step1

UPDATE pizza_sales
SET ordered_date = STR_TO_DATE(order_date, '%d-%m-%Y'); -- step2

ALTER TABLE pizza_sales DROP COLUMN order_date; -- step3

-- 6. order time
Alter table pizza_sales modify column order_time time;

-- 7. unit_price
Alter table pizza_sales modify column unit_price decimal(10,2);

-- 8. total_price
Alter table pizza_sales modify column total_price decimal(10,2);

-- 9. pizza_size
Alter table pizza_sales modify column pizza_size varchar(20);

-- 10. pizza_category
Alter table pizza_sales modify column pizza_category varchar(100);

-- 11. pizza_ingreditents
Alter table pizza_sales modify column pizza_ingredients varchar(200);

-- 12. pizza_name
Alter table pizza_sales modify column pizza_name varchar(50);


-- =========== Basic Analysis ==========================================

-- 1. the sum of the total price of all pizza orders
SELECT SUM(total_price) as Total_sales 
from pizza_sales;


-- 2. avg spend per order
select SUM(total_price)/COUNT(distinct order_id) as Avg_price_per_order 
from pizza_sales;


-- 3. total pizza sold
select SUM(quantity) as pizza_sold 
from pizza_sales;


-- 4. total number of orders
select count(distinct order_id) as total_orders 
from pizza_sales;

-- 5. avg pizzas per order
select sum(quantity)/count(distinct order_id) as avg_pizzas_per_order 
from pizza_sales;





-- ===================== Problem statments Analysis =============================================
-- 1.daywise sales
select date_format(ordered_date, '%W') as day, 
	   count(distinct order_id) as total_sales 
from pizza_sales 
group by day;


-- 2. monthwise sales
SELECT DATE_FORMAT(ordered_date, '%M') AS month, 
	   count(distinct order_id) as total_sales 
from pizza_sales 
group by month;

-- 3. % of sales by pizza size
select pizza_size, 
	   CAST(sum(total_price)*100/(select sum(total_price) from pizza_sales) AS decimal(10,2)) as PTS 
from pizza_sales 
group by pizza_size;


-- 4. total pizzas sold by pizza category
select pizza_category, 
	   sum(quantity) 
from pizza_sales 
group by 1;


-- 5.1 top 5 best sellers by qty
select pizza_name, 
	   sum(quantity) as sold_qty 
from pizza_sales 
group by pizza_name 
order by sold_qty desc 
limit 5;

-- 5.2 top 5 best sellers by revenue
select pizza_name, 
	   sum(total_price) as revenue 
from pizza_sales 
group by pizza_name 
order by revenue desc 
limit 5;

-- 5.3 top 5 best sellers by orders
select pizza_name, 
	   count(distinct order_id) as orders 
from pizza_sales 
group by 1 
order by orders desc 
limit 5;

-- 6.1 bottom 5 sellers by qty
select pizza_name, 
	   sum(quantity) as sold_qty 
from pizza_sales 
group by pizza_name 
order by sold_qty 
limit 5 ;

-- 6.2 bottom 5 sellers by revenue
select pizza_name, 
	   sum(total_price) as revenue 
from pizza_sales 
group by pizza_name 
order by revenue 
limit 5;

-- 6.3 bottom 5 sellers by orders
select pizza_name, 
	   count(distinct order_id) as orders 
from pizza_sales 
group by 1 
order by orders 
limit 5;