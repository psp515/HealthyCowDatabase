CREATE OR ALTER PROCEDURE RefreshMenu
   @date DATETIME = NULL
AS
BEGIN


   IF @date is null
       SET @date = CONVERT(date, DATEADD(day, 1, getdate()))


   --- GET CURRENT MENU ---


   DECLARE @sharedMeals TABLE (MealId int);


   INSERT INTO @sharedMeals (MealId) SELECT TOP 10 MealId FROM (
       SELECT M.MealId FROM dbo.GetMenuByDate(@date) AS M
       INTERSECT
       SELECT M.MealId FROM dbo.GetMenuByDate(DATEADD(week , -2, @date)) AS M
       INTERSECT
       SELECT M.MealId FROM Meals M WHERE dbo.isSeafood ( M.MealId ) = 0
   ) T


   DECLARE @sharedMealsCount int;
   SELECT  @sharedMealsCount = COUNT(*) FROM @sharedMeals


   IF @sharedMealsCount < 10
       INSERT INTO @sharedMeals
       SELECT TOP (10 - @sharedMealsCount) M.MealId
       FROM dbo.GetMenuByDate(@date) M
       WHERE NOT EXISTS (
           SELECT *
           FROM @sharedMeals
           WHERE MealId = M.MealId
           ) AND dbo.isSeafood (M.MealId) = 0
       ORDER BY NEWID()


   --- GENERATE NEW MEALS ---


   DECLARE @newMeals TABLE (MealId Int);


   INSERT INTO @newMeals (MealId)
   SELECT TOP 10 MealId
   FROM Meals
   WHERE dbo.isSeafood (MealId) = 0 and MealId not in (
       SELECT MealId from dbo.GetMenuByDate (@date)
   )
   ORDER BY NEWID()


   select * from @newMeals


   -- REMOVE OLD MENU ---


   DECLARE @mealIdToHandle INT
   DECLARE @lastMealIdToHandle INT


   SELECT TOP 1 @lastMealIdToHandle = mealid
   from @sharedMeals
   ORDER BY mealid


   SET @mealIdToHandle = @lastMealIdToHandle


   WHILE @mealIdToHandle IS NOT NULL
   BEGIN
       EXEC RemoveMealFromMenu @mealId = @mealIdToHandle, @endDate = @date


       PRINT 'Removed: ' + cast( @mealIdToHandle as VARCHAR)


       SET @lastMealIdToHandle = @mealIdToHandle
       SET @mealIdToHandle = null


       SELECT TOP 1 @mealIdToHandle = mealid
       FROM @sharedMeals
       WHERE MealId > @lastMealIdToHandle
       ORDER BY mealid
   END


   --- ADD NEW MEALS ---


   SELECT TOP 1 @lastMealIdToHandle = mealid
   from @newMeals
   ORDER BY mealid


   SET @mealIdToHandle = @lastMealIdToHandle


   SELECT TOP 1 mealid
       FROM @newMeals
       WHERE MealId > @lastMealIdToHandle
       ORDER BY mealid


   WHILE @mealIdToHandle IS NOT NULL
   BEGIN
       EXEC AddMealToMenu @mealId = @mealIdToHandle, @startDate = @date


       PRINT 'Added ' + cast( @mealIdToHandle as VARCHAR)
       SET @lastMealIdToHandle = @mealIdToHandle
       SET @mealIdToHandle = null


       SELECT TOP 1 @mealIdToHandle = mealid
       FROM @newMeals
       WHERE MealId > @lastMealIdToHandle
       ORDER BY mealid
   END


   SELECT * from MenuView
END
