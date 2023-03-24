CREATE PROCEDURE [dbo].[AddTableToReservation] (@ReservationId int, @Tables TableList READONLY)
AS
BEGIN
 
  DECLARE @Seats int = (select seats from Reservations where ReservationId = @ReservationId)
  DECLARE @GivenSeats int = (SELECT SUM(ET.Size) FROM EmptyTables AS ET inner join @Tables as T on T.TableId = ET.TableId)


  IF @GivenSeats < @Seats
  BEGIN
     PRINT @GivenSeats;
     THROW 51000, 'Given tables are to small for this reservation!', 1
  END




  INSERT INTO ReservationDetails(ReservationId, TableId)
  SELECT @ReservationId, Tableid FROM @Tables
END
GO
