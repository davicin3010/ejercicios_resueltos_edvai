--1
select c.category_name, p.product_name, p.unit_price,
avg(p.unit_price) over (partition by c.category_id) as avgpricebycategory
from categories c 
inner join products p 
on c.category_id = p.category_id

--2
select avg(od.unit_price*od.quantity) over (partition by o.customer_id) as avgorderamount, o.*
from order_details od
inner join orders o 
on od.order_id = o.order_id

--3
select  p.product_name, c.category_name, p.quantity_per_unit, od.unit_price, od.quantity,
avg(od.quantity) over (partition by c.category_name) as avgquantity
from products p
inner join categories c 
on p.category_id = c.category_id 
inner join order_details od
on p.product_id = od.product_id
order by c.category_name, p.product_name

--4
select customer_id, order_date,
min(order_date) over(partition by customer_id) as earliestorderdate
from orders

--5
select product_id, product_name, unit_price, category_id,
max(unit_price) over (partition by category_id) as maxunitprice
from products

--6
select row_number() over (order by sum(od.quantity) desc), p.product_name, sum(od.quantity) as totalquantity
from products p 
inner join order_details od
on p.product_id = od.product_id
group by p.product_name

--7
select row_number() over (order by customer_id) as rownumber, * 
from customers

--8
select row_number() over (order by birth_date desc) as ranking, concat(first_name, ' ', last_name) as employeename, birth_date
from employees 

--9
select sum(od.unit_price * od.quantity) over (partition by o.customer_id) as sumorderamount, o.* 
from orders o
inner join order_details od
on o.order_id = od.order_id

--10
select c.category_name, p.product_name, od.unit_price, od.quantity,
sum(od.unit_price * od.quantity) over (partition by c.category_name)
from categories c 
inner join products p
on c.category_id = p.category_id
inner join order_details od
on p.product_id = od.product_id
order by c.category_name, p.product_name

--11
select c.country, o.order_id, o.shipped_date, o.freight,
sum(o.freight) over (partition by c.country)
from customers c
inner join orders o
on c.customer_id = o.customer_id
where o.shipped_date is not null
order by c.country, o.order_id

--12
select c.customer_id, c.company_name, sum(od.unit_price * od.quantity) as "Total Sales",
rank() over (order by sum(od.unit_price * od.quantity) desc)
from customers c 
inner join orders o
on c.customer_id = o.customer_id
inner join order_details od
on o.order_id = od.order_id
group by 1

--13
select employee_id, first_name, last_name, hire_date,
rank() over (order by hire_date) as "Rank"
from employees

--14
select product_id, product_name, unit_price,
rank() over (order by unit_price desc) as "Rank"
from products

--15
select order_id, product_id, quantity,
lag(quantity) over (order by order_id) as prevquantity
from order_details

--16
select order_id, order_date, customer_id,
lag(order_date) over (partition by customer_id order by order_date) as prevquantity
from orders

--17
select product_id, product_name, unit_price, 
lag(unit_price) over (order by product_id) as lastunitprice,
unit_price - lag(unit_price) over (order by product_id) as pricedifference
from products

--18
select product_name, unit_price, 
lead(unit_price) over (order by product_id) as nextprice
from products

--19
select c.category_name, sum(od.unit_price * od.quantity) as totalsales,
lead(sum(od.unit_price * od.quantity)) over (order by c.category_name)
from categories c
inner join products p
on c.category_id = p.category_id
inner join order_details od
on p.product_id =od.product_id
group by 1


                     
