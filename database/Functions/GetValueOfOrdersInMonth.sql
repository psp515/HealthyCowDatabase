CREATE FUNCTION getValueOfOrderInMonth(@month int, @year int)
RETURNS float
AS
BEGIN
DECLARE @OrderToSum TABLE
(orderVal float)


INSERT INTO @OrderToSum
select Sum(OI.Value) from OrdersInfo AS OI
WHERE MONTH(OI.OrderDate) = @month AND
     YEAR(OI.OrderDate) = @year


RETURN isnull((Select SUM(orderVal) from @OrderToSum), 0)
END
