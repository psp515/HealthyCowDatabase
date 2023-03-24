CREATE PROCEDURE AddOrderDetail @OrderId int,
                               @Quantity int,
                               @MenuMealId int
AS
BEGIN
   SET NOCOUNT ON
   BEGIN TRY
       IF NOT EXISTS(SELECT * FROM Orders as O WHERE O.OrderId = @OrderId)
           BEGIN
               THROW 52000, N'Nieprawidłowe id zamówienia.', 1
           END


       IF @Quantity < 0
           BEGIN
               THROW 52000, N'Nieprawidłowa liczba zamówionych przedmiotów', 1
           END


       select dbo.GetMenuByDate(GETDATE()) as Menu


       IF @MenuMealId NOT IN (SELECT x.MenuMealId FROM dbo.GetMenuByDate(GETDATE()) as x)
           BEGIN
               THROW 52000, N'Nieprawidłowa liczba zamówionych przedmiotów', 1
           END


       INSERT INTO OrderDetails(OrderId, MenuMealId, Quantity)
       VALUES (@OrderId,@MenuMealId,@Quantity)
   END TRY
   BEGIN CATCH
       DECLARE @msg nvarchar(2048)
           =N'Błąd wykonywania procedury.' + ERROR_MESSAGE();
       THROW 52000, @msg, 1
   END CATCH
END
