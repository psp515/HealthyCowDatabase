CREATE PROCEDURE ModifyOrderDetail @Quantity int,
                                  @OrderDetailId int
AS
BEGIN
   SET NOCOUNT ON
   BEGIN TRY
       IF NOT EXISTS(SELECT * FROM OrderDetails as O WHERE O.OrderDetailId = @OrderDetailId)
           BEGIN
               THROW 52000, N'Nieprawidłowe id szczegółu zamówienia.', 1
           END


       IF @Quantity < 0
           BEGIN
               THROW 52000, N'Nieprawidłowa liczba zamówionych przedmiotów', 1
           END


       UPDATE OrderDetails
       SET Quantity = @Quantity
       WHERE OrderDetails.OrderDetailId = @OrderDetailId
   END TRY
   BEGIN CATCH
       DECLARE @msg nvarchar(2048)
           =N'Błąd wykonywania procedury.'  + ERROR_MESSAGE();
       THROW 52000, @msg, 1
   END CATCH
END
go
