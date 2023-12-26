-- month
-- product name
-- variant
-- sold quantity
-- gross price per item
-- gross price total



select * from dim_customer where customer like"%croma%"

select s.date, s.product_code, p.product, p.variant, 
s.sold_quantity, g.gross_price, g.gross_price*s.sold_quantity as gross_price_total
from fact_sales_monthly s
join dim_product p on s.product_code=p.product_code
join fact_gross_price g on s.product_code=g.product_code and fiscal_year(s.date)=g.fiscal_year
where customer_code=90002002 and fiscal_year(s.date)=2021
order by s.date asc
limit 100000