CREATE OR ALTER PROCEDURE PayForOrder @OrderId int,
                            @IsPaid bit
AS
BEGIN
   SET NOCOUNT ON
   BEGIN TRY


       IF @IsPaid != 1
           BEGIN;
               THROW 52000, N'Nieprawidłowe wartośc wejściowa.', 1
           END


       IF NOT EXISTS(SELECT * FROM Orders as O WHERE O.OrderId = @OrderId)
           BEGIN;
               THROW 52000, N'Nieprawidłowe id zamówienia.', 1
           END


       UPDATE Orders
       SET IsPaid = @IsPaid
       WHERE Orders.OrderId=@OrderId


       DECLARE @cstId int = (SELECT TOP 1 O.CustomerId from Orders as O WHERE O.OrderId = @OrderId)
       IF EXISTS (SELECT * FROM IndividualCustomers WHERE CustomerId = @cstId)
           Exec CheckCustomerDiscounts @customerId = @cstId


   END TRY
   BEGIN CATCH
       DECLARE @msg nvarchar(2048)
           =N'Błąd wykonywania procedury.' + ERROR_MESSAGE();
       THROW 52000, @msg, 1
   END CATCH
END
