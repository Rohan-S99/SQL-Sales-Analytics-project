CREATE DEFINER=`root`@`localhost` FUNCTION `fiscal_year`( calendar_date date) RETURNS int
    DETERMINISTIC
BEGIN
	declare fyear int;
    set fyear= year(date_add(calendar_date, interval 4 month));
    return fyear;
END
