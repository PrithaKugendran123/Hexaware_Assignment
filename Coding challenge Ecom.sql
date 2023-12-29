Create database Ecom
use Ecom

create table Customers(
Customer_id int Primary key,
name varchar(50),
email varchar(50),
password varchar(50));

create table Products(
Product_id int Primary key,
name varchar(50),
description varchar(100),
price decimal(10, 2),
stockQuantity int);

create table cart (
    cart_id int Primary key,
    customer_id int,
    product_id int,
    quantity int,
    Foreign key(customer_id) references customers(customer_id),
    Foreign key (product_id) references products(product_id)
);


create table orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    total_price decimal(10, 2),
    Foreign key (customer_id) references customers(customer_id)
);

create table order_items (
    order_item_id int primary key,
    order_id int,
    product_id int,
    quantity int,
	item_amount int,
    Foreign key (order_id) references orders(order_id),
    Foreign key (product_id) references products(product_id)
);


insert into Products values 
(1, 'Laptop High-performance', 'laptop', 800.00, 10),
(2, 'Smartphone', 'Latest smartphone', 600.00, 15),
(3, 'Tablet', 'Portable tablet', 300.00, 20),
(4, 'Headphones', 'Noise-canceling', 150.00, 30),
(5, 'TV', '4K Smart TV', 900.00, 5),
(6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25),
(7, 'Refrigerator', 'Energy-efficient', 700.00, 10),
(8, 'Microwave Oven', 'Countertop microwave', 80.00, 15),
(9, 'Blender', 'High-speed blender', 70.00, 20),
(10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);

INSERT INTO customers VALUES
(1, 'John Doe', 'johndoe@example.com', 'John@123'),
(2, 'Jane Smith', 'janesmith@example.com', 'Jane@123'),
(3, 'Robert Johnson', 'robert@example.com', 'Robert@123'),
(4, 'Sarah Brown', 'sarah@example.com', 'Sarah@123'),
(5, 'David Lee', 'david@example.com', 'David@123'),
(6, 'Laura Hall', 'laura@example.com', 'Laura@123'),
(7, 'Michael Davis', 'michael@example.com', 'Michael@123'),
(8, 'Emma Wilson', 'emma@example.com', 'Emma@123'),
(9, 'William Taylor', 'william@example.com', 'William@123'),
(10, 'Olivia Adams', 'olivia@example.com', 'Olivia@123');

insert into orders values
(1, 1, '2023-01-05', 1200.00),
(2, 2, '2023-02-10', 900.00),
(3, 3, '2023-03-15', 300.00),
(4, 4, '2023-04-20', 150.00),
(5, 5, '2023-05-25', 1800.00),
(6, 6, '2023-06-30', 400.00),
(7, 7, '2023-07-05', 700.00),
(8, 8, '2023-08-10', 160.00),
(9, 9, '2023-09-15', 140.00),
(10, 10, '2023-10-20', 1400.00);

   
   


insert into order_items values
(1, 1, 1, 2, 1600.00),
(2, 1, 3, 1, 300.00),
(3, 2, 2, 3, 1800.00),
(4, 3, 5, 2, 1800.00),
(5, 4, 4, 4, 600.00),
(6, 4, 6, 1, 50.00),
(7, 5, 1, 1, 800.00),
(8, 5, 2, 2, 1200.00),
(9, 6, 10, 2, 240.00),
(10, 6, 9, 3, 210.00);




insert into cart values
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 4, 4),
(5, 3, 5, 2),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 6, 10, 2),
(9, 6, 9, 3),
(10, 7, 7, 2);


select*from Products
select*from Customers
select*From cart
select*from orders
select*from order_items

--Update refrigerator product price to 800.
update Products set price=800 where name ='Refrigerator'
select*from Products

--Remove all cart items for a specific customer

delete from  cart where customer_id = 7;
select*from cart;


--Retrieve Products Priced Below $100.

select * from Products where price < 100


--Find Products with Stock Quantity Greater Than 5.select * from Products where stockQuantity > 5

--Retrieve Orders with Total Amount Between $500 and $1000

select * from orders where total_price between 500 and 1000


--Find Products which name end with letter ‘r’.

select* from Products where name like '%r'


--Retrieve Cart Items for Customer 5.

select*from cart where customer_id=5


-- Find Customers Who Placed Orders in 2023.

select*from Customers 
join orders on Customers.Customer_id=orders.customer_id
where YEAR(order_date)=2023


--Determine the Minimum Stock Quantity for Each Product Category.

select  name,min(stockQuantity) as MinimumStockQuantity from Products
group by  name



-- Calculate the Total Amount Spent by Each Customer

select c.name, sum(o.total_price) as Total_Spent_by_Customer
from customers c
left join orders o on c.customer_id = o.customer_id
group by  c.name;


--Find the Average Order Amount for Each Customer.

select c.name, avg(o.total_price) as AverageAmt
from customers c
left join orders o on c.customer_id = o.customer_id
group by  c.name;


--Count the Number of Orders Placed by Each Customer

select  c.name as CustomerName, COUNT(order_id)  orderCount
from customers c 
left join orders o on c.customer_id = o.customer_id
group by c.customer_id,c.name;


-- Find the Maximum Order Amount for Each Customer.
select c.name, max(o.total_price) as maximum_Order_Amount from Customers c
left join orders o on  c.Customer_id=o.customer_id
group by c.name


--Get Customers Who Placed Orders Totaling Over $1000.

select c.name, o.total_price from Customers c
join orders o on c.Customer_id=o.customer_id
where o.total_price>1000


-- Subquery to Find Products Not in the Cart

select*from Products where Product_id not in(select Product_id from cart)


-- Subquery to Find Customers Who Haven't Placed Orders.

select * from Customers where Customer_id not in (select Customer_id from orders)

--Subquery to Calculate the Percentage of Total Revenue for a Product.

select p.name, (p.price * 100/sum(item_amount)) AS TotalRevenuePercentage FROM products p
join order_items o on p.product_id = o.product_id
group by p.name,p.price




  --Subquery to Find Products with Low Stock.
select * from products
where stockQuantity < (select avg(stockQuantity)from  products);


--Subquery to Find Customers Who Placed High-Value Orders.

select c.Customer_id,c.name, sum(o.total_price) from
Customers c join orders o on c.Customer_id=o.customer_id
where  o.total_price>(select avg(total_price) from orders)
group by c.Customer_id,c.name,o.total_price 

























