CREATE DEFINER=`root`@`localhost` PROCEDURE `monthly_gross_sales_for_customer`(in_customer_code text)
BEGIN
select s.date, sum(g.gross_price*s.sold_quantity) as gross_price_total,
fiscal_year(s.date) as Fiscal_Year
from fact_sales_monthly s join fact_gross_price g 
on s.product_code=g.product_code and g.fiscal_year=fiscal_year(s.date)
where find_in_set(customer_code,in_customer_code)>0
group by s.date
order by s.date asc;

END
