CREATE FUNCTION getClientsOrderedMoreThanXTimes(@x int)
RETURNS TABLE
AS
RETURN select CustomerId FROM Orders  Group By CustomerId HAving Count(OrderId) > @x
