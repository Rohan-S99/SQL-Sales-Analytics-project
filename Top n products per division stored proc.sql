CREATE DEFINER=`root`@`localhost` PROCEDURE `top_n_products_per_division_by_qty_sold`(n int, in_fiscal_year int)
BEGIN
with cte1 as (select p.division, p.product, sum(s.sold_quantity) as total_qty
from
fact_sales_monthly s join dim_product p
on s.product_code=p.product_code
where fiscal_yr=in_fiscal_year
group by p.product,p.division),
cte2 as (
select 
*, dense_rank() over(partition by division order by total_qty desc) as d_rank
 from cte1)
 select * from cte2 
 where d_rank <= n;
END
