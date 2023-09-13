USE stores7new_sqlserver

-- 1

SELECT
	c.customer_num,
	c.company,
	o.order_num
FROM
	customer c
INNER JOIN orders o on
	c.customer_num = o.customer_num
ORDER BY
	customer_num 
	
-- 2
SELECT
	i.order_num ,
	i.item_num ,
	pt.description ,
	p.manu_code ,
	quantity ,
	(i.unit_price * quantity) precio_total
FROM
	items i
LEFT JOIN products p on
	i.order_num = p.stock_num
LEFT JOIN product_types pt on
	p.stock_num = pt.stock_num
WHERE
	i.order_num = 1004

-- 4
SELECT
	c.customer_num,
	company,
	fname,
	lname,
	o.order_num
FROM
	customer c
INNER JOIN orders o ON
	o.customer_num = c.customer_num
	
-- 5
SELECT
	DISTINCT(c.customer_num),
	fname,
	lname,
	company
FROM
	customer c
JOIN orders o ON
	c.customer_num = o.customer_num

-- 6
SELECT
	m.manu_name,
	pt.stock_num,
	pt.description,
	u.unit,
	unit_price,
	(p.unit_price + 0.2 * p.unit_price) AS precioJunio
FROM
	manufact m
JOIN products p ON
	m.manu_code = p.manu_code
JOIN units u ON
	p.unit_code = u.unit_code
JOIN product_types pt ON
	pt.stock_num = p.stock_num 

-- 7
SELECT i.item_num, 
FROM
	items i
JOIN products p on
	i.order_num = p.stock_num
JOIN product_types pt on
	p.stock_num = pt.stock_num
WHERE
	i.order_num = 1004 

-- 8
SELECT
	m.manu_name,
	m.lead_time,
	i.item_num,
	o.order_num,
	o.customer_num
FROM
	manufact m
INNER JOIN items i ON
	m.manu_code = i.manu_code
INNER JOIN orders o ON
	i.order_num = o.order_num
WHERE
	o.customer_num = 104

-- 9
SELECT
	o.order_num,
	o.order_date,
	i.item_num,
	pt.description,
	i.quantity,
	(i.unit_price * i.quantity) as precio_total
FROM
	orders o
INNER JOIN items i ON
	o.order_num = i.order_num
INNER JOIN product_types pt ON
	pt.stock_num = i.stock_num
	
-- 10
SELECT lname, fname , phone, '(' + SUBSTRING(phone, 1, 3) + ')' + ' ' + SUBSTRING(phone, 5, 12) phone
FROM customer c 
ORDER BY lname, fname

-- 11
SELECT
	ship_date,
	c.lname + ', ' + c.fname full_name,
	count(order_num) order_count
FROM
	orders o
JOIN customer c ON
	o.customer_num = c.customer_num
JOIN state s ON
	c.state = s.state
WHERE
	s.sname = 'California'
	AND c.zipcode BETWEEN 94000 AND 94100
GROUP BY
	ship_date,
	c.lname,
	c.fname
ORDER BY
	o.ship_date,
	c.lname,
	c.fname

-- 12
SELECT
	m.manu_name,
	pt.description,
	COUNT(i.order_num) count_sold,
	(i.quantity * i.unit_price) total_amount_sold
FROM
	products p
JOIN manufact m ON
	p.manu_code = m.manu_code
JOIN product_types pt ON
	p.stock_num = pt.stock_num
JOIN items i ON
	p.stock_num = i.stock_num
JOIN orders o ON
	i.order_num = o.order_num
WHERE
	i.manu_code IN ('ANZ', 'HRO', 'HSK', 'SMT')
	AND o.order_date BETWEEN '2015-05-01' AND '2015-06-30'
GROUP BY
	m.manu_name,
	pt.description,
	i.quantity,
	i.unit_price 
ORDER BY total_amount_sold DESC

-- 13
SELECT
	FORMAT(o.order_date, 'yyyy/MM') month,
	count(*) sold_units_count,
	SUM(i.quantity * i.unit_price) total_amount_sold
FROM
	items i
JOIN orders o ON
	i.order_num = o.order_num
GROUP BY
	FORMAT(o.order_date, 'yyyy/MM')
ORDER BY
	total_amount_sold DESC


