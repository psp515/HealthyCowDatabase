CREATE FUNCTION GetMenuByDate(@date datetime)
   RETURNS TABLE AS
       RETURN SELECT DISTINCT M.MealId,
                              M.MenuMealId,
                              Me.Name,
                              M.Price,
                              M.StartDate,
                              M.EndDate
              FROM Menu AS M
                       JOIN Meals Me on Me.MealId = M.MealId
              WHERE M.StartDate < @date
                AND (M.EndDate IS NULL OR
                     M.EndDate > @date)
