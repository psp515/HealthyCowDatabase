CREATE VIEW MealsSold AS
SELECT 'Meal'=M.Name, 'Category'=C.Name, 'Sold units' = isnull(SUM(OD.Quantity),0)
FROM Meals AS M
       LEFT JOIN Categories C on C.CategoryId = M.CategoryId
       LEFT JOIN Menu M2 on M.MealId = M2.MealId
       LEFT JOIN OrderDetails OD on M2.MenuMealId = OD.MenuMealId
GROUP BY M.MealId, M.Name, C.CategoryId, C.Name
