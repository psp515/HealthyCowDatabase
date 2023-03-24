CREATE PROCEDURE AddCategory @CategoryName varchar(255)
AS
BEGIN
   SET NOCOUNT ON
   BEGIN TRY
       INSERT INTO Categories(Name)
       values (@CategoryName)
   END TRY
   BEGIN CATCH
       DECLARE @msg nvarchar(2048)
           =N'Błąd wykonywania procedury.'  + ERROR_MESSAGE();
       THROW 52000, @msg, 1
   END CATCH
END
go
