-- month
-- total gross sales to croma

with cte1 as (
select s.date, sum(g.gross_price*s.sold_quantity) as gross_price_total,
fiscal_year(s.date) as Fiscal_Year
from fact_sales_monthly s join fact_gross_price g 
on s.product_code=g.product_code and g.fiscal_year=fiscal_year(s.date)
where customer_code=90002002
group by s.date
order by s.date asc
limit 100000)

select Fiscal_Year, sum(gross_price_total) 
from cte1
group by Fiscal_Year
order by Fiscal_Year asc

select sum(s.sold_quantity),c.market from fact_sales_monthly s join dim_customer c
on s.customer_code=c.customer_code
where fiscal_year(s.date)=2021
group by c.market

select c.market, sum(s.sold_quantity) as sales_in_year from fact_sales_monthly s join dim_customer c
on s.customer_code=c.customer_code
where fiscal_year(s.date)=2021 and c.market="India"
group by c.market


DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `market_badge2`(in in_market varchar(45), in in_fiscal_year year, out m_badge varchar(45))
BEGIN
    DECLARE qty INT DEFAULT 0;

    SELECT SUM(s.sold_quantity) 
    INTO qty 
    FROM fact_sales_monthly s 
    JOIN dim_customer c ON s.customer_code = c.customer_code
    WHERE fiscal_year(s.date) = in_fiscal_year AND c.market = in_market
    GROUP BY c.market;

    IF qty > 5000000 THEN 
        SET m_badge = "gold";
    ELSE 
        SET m_badge = "silver";
    END IF;
END$$

DELIMITER ;


