CREATE OR ALTER PROCEDURE AddMealToMenu
   @mealId int,
   @price int = 0,
   @quantity int = 0,
   @startDate datetime = null,
   @endDate datetime = null,
   @menuMealId int = null output
AS
BEGIN
   IF @startDate is null
       SET @startDate = GETDATE()


   INSERT INTO Menu(MealId, StartDate, EndDate, Price, Quantity) VALUES (@mealId, @startDate, @endDate, @price, @quantity)
   SET @menuMealId = SCOPE_IDENTITY()
END
