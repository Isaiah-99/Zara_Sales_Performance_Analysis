create database zara_sales;
select * from sales_data;
-- DATA CLEANING
-- renaming dataset
alter table sales_data rename column promotion to product_promotion;
alter table sales_data rename column Sales_Volume to quantity;
alter table sales_data rename column quantity to Quantity_Sold;
alter table sales_data rename column sku to Stock_number;
alter table sales_data rename column name to product;
alter table sales_data rename column terms to product_confition;
alter table sales_data rename column product_confition to product_condition;

-- changing date format
update sales_data set Orderdate = date_format(str_to_date(Orderdate, '%m/%d/%Y'), '%Y/%m/%d');
-- change date format
alter table sales_data modify column Orderdate Date;

-- create calculated fields 
-- creating calculated column (Total sales) by multiplying sales by price
alter table sales_data add column total_sales int;
update sales_data set total_sales = Quantity_sold * Price;
select * from sales_data;

-- EDA (SALES TRENDS BY DAY, MONTH,YEAR)
SELECT 
    DATE(Orderdate) AS daily_sales, SUM(total_sales) as total_revenue
FROM
    sales_data
GROUP BY daily_sales order by total_revenue ;
-- monthly sales 
SELECT 
    MONTHNAME(Orderdate) AS monthly_sales,year(Orderdate) as yearly_sales, SUM(total_sales) as total_revenue
FROM
    sales_data
GROUP BY monthly_sales, yearly_sales order by total_revenue desc;

-- Top selling products
-- 1. select top selling product
SELECT 
    product, SUM(total_sales) AS Total_revenue, sum(Quantity_sold) as Quantity_sold
FROM
    sales_data
GROUP BY product
ORDER BY total_revenue desc;

-- 2. write a query to select top selling product category in each section
SELECT 
    product_category, section, SUM(total_sales) AS Total_revenue, sum(Quantity_Sold) as Quantity_sold
FROM
    sales_data
GROUP BY product_category , section order by total_revenue desc;


-- sales / quantity sold distribution by product promotion
SELECT 
    product_promotion,
    SUM(total_sales) AS Total_revenue,
    SUM(Quantity_sold) AS Quantity_sold
FROM
    sales_data
GROUP BY product_promotion
ORDER BY Total_revenue DESC;
-- sales / quantity sold distribution by product condition
SELECT 
    product_condition,
    SUM(total_sales) AS Total_revenue,
    SUM(Quantity_sold) AS Quantity_sold
FROM
    sales_data
GROUP BY Product_condition
ORDER BY Total_revenue DESC;
-- sales / quantity sold distribution by seasonal product
SELECT 
    seasonal,
    SUM(total_sales) AS Total_revenue,
    SUM(Quantity_sold) AS Quantity_sold
FROM
    sales_data
GROUP BY seasonal
ORDER BY Total_revenue DESC;
-- sales / quantity sold distribution by product position
SELECT 
    Product_Position,
    SUM(total_sales) AS Total_revenue,
    SUM(Quantity_sold) AS Quantity_sold
FROM
    sales_data
GROUP BY Product_Position order by Total_revenue desc;

-- write a query to select the year with the highest sales
SELECT 
    YEAR(Orderdate) AS Year, SUM(total_sales) AS Total_revenue
FROM
    sales_data
GROUP BY Year
ORDER BY Total_revenue DESC;
