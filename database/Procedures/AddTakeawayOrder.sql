CREATE PROCEDURE AddTakeawayOrder @OrderId int,
                                 @TakeawayDate datetime
AS
BEGIN
   SET NOCOUNT ON
   BEGIN TRY
       IF NOT EXISTS(SELECT * FROM Orders as O WHERE O.OrderId = @OrderId)
           BEGIN
               THROW 52000, N'Nieprawidłowe id zamówienia.', 1
           END


       IF @TakeawayDate < GETDATE()
           BEGIN
               THROW 52000, N'Nieprawidłowa data odbioru', 1
           END


       INSERT INTO TakeawayOrders(OrderId, TakeawayDate)
       values (@OrderId, @TakeawayDate)
   END TRY
   BEGIN CATCH
       DECLARE @msg nvarchar(2048)
           =N'Błąd wykonywania procedury.' ' + ERROR_MESSAGE();
       THROW 52000, @msg, 1
   END CATCH
END
go
