CREATE DEFINER=`root`@`localhost` FUNCTION `fiscal_quarter`(calendar_date date) RETURNS char(2) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	declare fq char(2);
	case
		when month(calendar_date) in (9,10,11) then set fq= "Q1";
        when month(calendar_date) in (12,1,2) then set fq= "Q2";
        when month(calendar_date) in (3,4,5) then set fq= "Q3";
        when month(calendar_date) in (6,7,8) then set fq= "Q4";
	end case;
return fq;
END
