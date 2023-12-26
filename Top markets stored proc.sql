CREATE DEFINER=`root`@`localhost` PROCEDURE `top_markets`(in_year int, top_n int)
BEGIN

select market, sum(net_sales)/1000000 as sales_by_market_mln
from
net_sales
where fiscal_yr=in_year
group by market
order by sales_by_market_mln desc
limit top_n;
END
