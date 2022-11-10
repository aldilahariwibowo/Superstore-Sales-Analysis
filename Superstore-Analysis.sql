/*Case 1: Number of orders Same Day Ship Mode which is delays in delivery. */

--Check Same Day Ship Mode orders
select 
	order_id, 
	order_date, 
	ship_date, 
	ship_mode
from orders
where ship_mode = 'Same Day';

--Counting Same Day orders that are delays

select count(order_id) as total_delayed_sameday
from orders
where ship_mode = 'Same Day' and ship_date > order_date;


/* Case 2 : Analyze the performance of the Category and Subcategory of the products */

select 
	p.category,
	p.sub_category,
	avg(o.discount) as avg_discount,
	avg(o.profit) as avg_profit
from orders as o
left join product as p
on o.product_id =  p.product_id
group by p.category, p.sub_category
order by avg_profit desc;

/* Case 3 : Performance of each customer segment in State California, Texas, and Georgia. */

select
	segment,
	sum(sales) as total_sales,
	avg(profit) as avg_profit
from 
	orders as o
left join 
	customer as c on c.customer_id = o.customer_id
where 
	c.state in ('California', 'Texas', 'Georgia') and
	o.order_date between '2016-01-01' and '2016-12-31'
group by segment
order by avg_profit desc;

/* Case 4 : Number of people/customers who have an average discount above 0.4 for each existing region. */

select 
	count(subq.customer_id) as total_cust_avgdisc_morethan_40,
	c.region
from	
(
	select 
		customer_id,
		avg(discount) as avg_discount
	from orders
	group by customer_id
	having avg(discount) >= 0.4
	order by avg_discount desc
) subq
left join customer as c on subq.customer_id = c.customer_id
group by c.region;
