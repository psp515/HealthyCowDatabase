CREATE PROCEDURE [dbo].[ChangeReservationStatus](@ReservationId int, @Status varchar(255))
AS
BEGIN
  IF @ReservationId NOT IN (Select ReservationId from Reservations where ReservationId = @ReservationId)
  BEGIN
     ;
     THROW 51000, 'There is no such reservation!', 1
  END


  IF @Status NOT IN ('Confirmed', 'Rejected', 'Awaiting')
  BEGIN
     ;
     THROW 51000, 'Incorrect status!', 1
  END


  UPDATE Reservations
  SET Status = @Status
  WHERE ReservationId = @ReservationId


END
