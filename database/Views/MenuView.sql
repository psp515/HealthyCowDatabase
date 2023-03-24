CREATE OR ALTER VIEW MenuView AS
SELECT M.MenuMealId,
      Meals.Name,
      M.StartDate AS [In Menu Since],
      M.Price,
      M.Quantity as [Total],
      M.Quantity - ISNULL(SUM(OD.Quantity),0) as [Avaliable]
FROM Menu as M
   JOIN Meals ON M.MealId = Meals.MealId
   LEFT JOIN OrderDetails OD on M.MenuMealId = OD.MenuMealId
WHERE M.StartDate < GETDATE()
                AND (M.EndDate IS NULL OR
                     M.EndDate > GETDATE())
GROUP BY M.MenuMealId, Meals.Name, M.StartDate, M.Price, M.Quantity
