CREATE OR ALTER FUNCTION isSeafood( @mealId int )
RETURNS BIT
AS BEGIN
   DECLARE @category VARCHAR(max)


   SELECT @category=Categories.name FROM Meals
   INNER JOIN Categories
   ON Meals.CategoryId = Categories.CategoryId
   WHERE Meals.MealId = @mealId


   return IIF( @category = 'Seafood', 1, 0)
END
