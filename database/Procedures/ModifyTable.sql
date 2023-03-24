CREATE PROCEDURE ModifyTable @Size int,
                            @TableId int
AS
BEGIN
   SET NOCOUNT ON
   BEGIN TRY


       IF @Size > 0
           BEGIN
               THROW 52000, N'Nieprawidłowa wielkość stołu.', 1
           END


       IF NOT EXISTS(SELECT * FROM Tables as T WHERE T.TableId=@TableId)
           BEGIN;
               THROW 52000, N'Stolik nie istnieje.', 1
           END


       Update Tables
       SET Size = @Size
       WHERE Tables.TableId=@TableId
   END TRY
   BEGIN CATCH
       DECLARE @msg nvarchar(2048)
           =N'Błąd wykonywania procedury.' + ERROR_MESSAGE();
       THROW 52000, @msg, 1
   END CATCH
END
go
