CREATE FUNCTION IsTodaysMenuCorrect()
   RETURNS BIT AS
       BEGIN


           DECLARE @count int =
               (SELECT COUNT(*) FROM (SELECT M.MealId FROM dbo.GetMenuByDate(GETDATE()) AS M
               INTERSECT
               SELECT M.MealId FROM dbo.GetMenuByDate(DATEADD(week , -2, GETDATE())) AS M) as A)


       RETURN @count <= 10


       end
