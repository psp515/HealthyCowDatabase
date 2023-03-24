CREATE OR ALTER FUNCTION IsMenuCorrectByDate(@date datetime)
  RETURNS BIT AS
      BEGIN
          DECLARE @count int =
              (SELECT COUNT(*) FROM (SELECT M.MenuMealId FROM dbo.GetMenuByDate(@date) AS M
              INTERSECT
              SELECT M.MenuMealId FROM dbo.GetMenuByDate(DATEADD(week, -2, @date)) AS M
              INTERSECT
              SELECT M.MealId FROM Meals M WHERE dbo.isSeafood (M.MealId) = 0
           ) as A)


       DECLARE @response bit = 0
          IF @count <= 10
              set @response = 1


      RETURN @response
  END
