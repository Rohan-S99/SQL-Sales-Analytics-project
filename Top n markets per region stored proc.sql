CREATE DEFINER=`root`@`localhost` PROCEDURE `top_n_markets_per_region`(in_fiscal_year int, n int)
BEGIN
 with cte1 as (select c.market, c.region, sum(s.gross_price_total)/1000000 as gross_sales_mln
from
net_sales s join dim_customer c
on s.customer_code=c.customer_code
where fiscal_yr=in_fiscal_year
group by c.market,c.region),
cte2 as (
select 
*, dense_rank() over(partition by region order by gross_sales_mln desc) as d_rank
 from cte1)
 select * from cte2 
 where d_rank <= n;
END
