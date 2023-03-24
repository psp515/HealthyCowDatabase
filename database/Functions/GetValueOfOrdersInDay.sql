CREATE FUNCTION getValueOfOrderInDay(@day int, @month int, @year int)
RETURNS float
AS
BEGIN


DECLARE @OrderToSum TABLE
(orderVal float)




INSERT INTO @OrderToSum
select OI.Value from OrdersInfo AS OI
WHERE day(OI.OrderDate) = @day AND
     MONTH(OI.OrderDate) = @month AND
     YEAR(OI.OrderDate) = @year


RETURN (Select SUM(orderVal) from @OrderToSum)


END
go
