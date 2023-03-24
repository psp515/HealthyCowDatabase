CREATE FUNCTION GetXBestMeals(@x int)
   RETURNS TABLE AS
       RETURN SELECT TOP (@x) M.MealId         AS MealId,
                            M.Name           AS [Meal name],
                            SUM(OD.Quantity) AS [Ordered Units]
              FROM Meals as M
                       LEFT JOIN Menu Me on M.MealId = Me.MealId
                       LEFT JOIN OrderDetails OD on Me.MenuMealId = OD.MenuMealId
              GROUP BY M.MealId, M.Name
              ORDER BY [Ordered Units] desc
