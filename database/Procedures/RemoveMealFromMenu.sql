CREATE OR ALTER PROCEDURE RemoveMealFromMenu
   @mealId int = NULL,
   @menuMealId int = null,
   @endDate datetime = null
AS
BEGIN


   IF @mealId is null and @menuMealId is null
       THROW 52000, 'Invalid arguments, at least one of @mealId or @menuMealId must be passed', 1


   IF @endDate is null
       SET @endDate = GETDATE()


   IF @menuMealId is not null
       UPDATE Menu
       SET EndDate=@endDate
       WHERE MenuMealId=@menuMealId
   else
       UPDATE Menu
       SET EndDate=@endDate
       WHERE MealId = @mealId
           and (
               EndDate is null OR
               EndDate < GETDATE()
           )
END
