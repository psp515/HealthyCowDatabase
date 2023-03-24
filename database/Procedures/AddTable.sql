CREATE PROCEDURE AddTable @Size int
AS
BEGIN
   SET NOCOUNT ON
   BEGIN TRY


       IF @Size > 0
           BEGIN
               THROW 52000, N'Nieprawidłowa wielkość stołu.', 1
           END


       INSERT INTO Tables(Size)
       values (@Size)
   END TRY
   BEGIN CATCH
       DECLARE @msg nvarchar(2048)5200
           =N'Błąd wykonywania procedury.' + ERROR_MESSAGE();
       THROW 52000, @msg, 1
   END CATCH
END
go
