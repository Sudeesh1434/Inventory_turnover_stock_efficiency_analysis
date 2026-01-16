create database inventory_analysis;
use inventory_analysis;

CREATE TABLE inventory (
  product_id VARCHAR(10),
  product_name VARCHAR(50),
  category VARCHAR(30),
  warehouse VARCHAR(30),
  month VARCHAR(10),
  opening_stock INT,
  units_sold INT,
  closing_stock INT,
  unit_cost INT,
  unit_price INT
);

SELECT * FROM inventory;

-- 1.sales volume & stock levels
select sum(opening_stock)opening_stock,
sum(closing_stock)closing_stock,
sum(units_sold)units_sold
from inventory;

-- 2.average inventory
select avg((opening_stock+closing_stock)/2)avg_inventory
from inventory;

-- 3.Inventory Turnover
select round(sum(units_sold)/avg(opening_stock+closing_stock/2),2)inventory_turnover
from inventory;

-- 4.Product-wise Inventory Turnover
select product_name,
round(sum(units_sold)/avg(opening_stock+closing_Stock/2),2)Product_turnover
from inventory
group by product_name;

-- 5.Category-wise Inventory Turnover 
select category,
round(sum(units_sold)/avg(opening_stock+closing_stock/2),2)inventory_turnover
from inventory
group by category;

-- 6.Identify Slow-Moving Products
select product_name,
sum(units_sold)total_sold,
sum(closing_stock)remaining_stock
from inventory
group by product_name
having total_sold<remaining_stock;

-- 7.Blocked Capital in Inventory
select product_name,
sum(closing_stock*units_sold)blocked_value
from inventory
group by product_name
order by blocked_value desc;