select
 *, gross_price_total*(1-pre_invoice_discount_pct) as net_invoice_sales,
 poiv.discounts_pct+poiv.other_deductions_pct as post_invoice_discount
 from sales_preinv_discount sp join fact_post_invoice_deductions poiv
 on sp.customer_code=poiv.customer_code and sp.product_code=poiv.product_code
 and sp.date=poiv.date
 
 
select s.date, s.fiscal_yr, s.customer_code, c.customer, 
c.market, s.product_code, p.product, p.variant,
s.sold_quantity, g.gross_price as gross_price_per_item, 
s.sold_quanity*g.gross_price as gross_price_total
from fact_sales_monthly s join dim_customer c
on s.customer_code=c.customer_code
join fact_gross_price g 
on s.product_code=g.product_code
	and s.fiscal_yr=g.fiscal_year
join dim_product p
on s.product_code=p.product_code

select market, sum(net_sales)/1000000 as sales_by_market_mln
from
net_sales
where fiscal_yr=2021
group by market
order by sales_by_market_mln desc
limit 5

select c.customer, sum(net_sales)/1000000 as sales_to_customer_mln
from
net_sales n join dim_customer c
on n.customer_code=c.customer_code
where fiscal_yr=2021
group by c.customer
order by sales_to_customer_mln desc
limit 5


select product, sum(net_sales)/1000000 as sales_of_product_mln
from
net_sales
where fiscal_yr=2021
group by product
order by sales_of_product_mln desc
limit 5

with cte1 as(
select c.customer,c.region, sum(net_sales)/1000000 as sales_to_region_mln
from
net_sales n join dim_customer c
on n.customer_code=c.customer_code
where fiscal_yr=2021 
group by c.customer,c.region)

select *, sales_to_region_mln*100/sum(sales_to_region_mln) over(partition by region) as pct_share_region
from 
cte1
order by region,sales_to_region_mln desc
limit n

with cte1 as (select p.division, p.product, sum(s.sold_quantity) as total_qty
from
fact_sales_monthly s join dim_product p
on s.product_code=p.product_code
where fiscal_yr=2021
group by p.product,p.division),
cte2 as (
select 
*, dense_rank() over(partition by division order by total_qty desc) as d_rank
 from cte1)
 select * from cte2 
 where d_rank <= 3
 
 with cte1 as (select c.market, c.region, sum(s.gross_price_total)/1000000 as gross_sales_mln
from
net_sales s join dim_customer c
on s.customer_code=c.customer_code
where fiscal_yr=2021
group by c.market,c.region),
cte2 as (
select 
*, dense_rank() over(partition by region order by gross_sales_mln desc) as d_rank
 from cte1)
 select * from cte2 
 where d_rank <= 2
 
 



