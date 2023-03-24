CREATE FUNCTION GetMealsSoldAtLeastXTimes(@x int)
   RETURNS TABLE AS
       RETURN SELECT M2.MealId,
                     M2.Name,
                     SUM(OD.Quantity) AS UnitsSold
              FROM Menu AS M
                       JOIN Meals M2 on M2.MealId = M.MealId
                       JOIN OrderDetails OD on M.MenuMealId = OD.MenuMealId
              WHERE M.EndDate IS NULL
              GROUP BY M2.MealId, M2.Name
              HAVING SUM(OD.Quantity) > @x
