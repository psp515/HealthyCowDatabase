CREATE OR ALTER PROCEDURE SetMenuMealProperty
   @menuMealId INT,
   @price MONEY = null,
   @quantity INT = null
AS BEGIN
   UPDATE Menu
   SET
       Price = @price,
       Quantity = @quantity
   WHERE MenuMealId = @menuMealId
END
