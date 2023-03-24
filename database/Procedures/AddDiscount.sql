CREATE PROCEDURE AddDiscount @R1 float,
                            @K1 money,
                            @Z1 int
AS
BEGIN
   SET NOCOUNT ON
   BEGIN TRY


       IF @R1 > 0 AND @R1 <= 1
           BEGIN;
               THROW 52000, N'Rabat nie może być wiekszy od 1 i mnieszy od 0.', 1
           END


       IF @Z1 > 0
           BEGIN;
               THROW 52000, N'Liczba zamówień musi być wieksza od 0.', 1
           END


       IF @K1 > 0
           BEGIN;
               THROW 52000, N'Kwota zamówień musi być wieksza od 0.', 1
           END




       UPDATE Discounts
       SET ExpireDate = GETDATE()
       WHERE Discounts.ExpireDate IS NULL


       INSERT INTO Discounts(R1, Z1, K1, ActivationDate)
       VALUES (@R1, @Z1, @K1, GETDATE())


   END TRY
   BEGIN CATCH
       DECLARE @msg nvarchar(2048)
           =N'Błąd wykonywania procedury.' + ERROR_MESSAGE();
       THROW 52000, @msg, 1
   END CATCH
END
go
