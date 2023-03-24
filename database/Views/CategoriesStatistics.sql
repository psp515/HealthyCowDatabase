CREATE VIEW CategoriesStatistics AS
SELECT C.Name, SUM(ISNULL(Od.Quantity,0)) 
FROM Categories AS C 
   LEFT JOIN Meals AS M ON C.CategoryId = M.CategoryId 
   LEFT JOIN Menu AS Mn ON Mn.MealId = M.MealId 
   LEFT JOIN OrderDetails AS Od ON Od.MenuMealId = Mn.MenuMealId 
GROUP BY C.CategoryId, C.Name