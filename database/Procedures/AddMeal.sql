CREATE OR ALTER PROCEDURE AddMeal
   @name varchar(255),
   @category varchar(255),
   @isPremium bit,
   @mealId INT = NULL OUTPUT
AS
BEGIN
   DECLARE @categoryId int = NULL


   SELECT @categoryId = CategoryId
   from Categories
   WHERE Name=@category


   IF @categoryId is null
   begin
       THROW 51000, 'Invalid category name',1
   end


   INSERT INTO Meals( CategoryId, Name, IsPremium) VALUES (@categoryId, @name, @isPremium)


   SET @mealId = SCOPE_IDENTITY()
END
