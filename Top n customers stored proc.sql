CREATE DEFINER=`root`@`localhost` PROCEDURE `top_n_customers`(n int, in_fiscal_year int,
in_market varchar(45))
BEGIN
select c.customer, sum(net_sales)/1000000 as sales_to_customer_mln
from
net_sales n join dim_customer c
on n.customer_code=c.customer_code
where fiscal_yr=in_fiscal_year and n.market=in_market
group by c.customer
order by sales_to_customer_mln desc
limit n;

END
