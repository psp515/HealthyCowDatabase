CREATE PROCEDURE [dbo].[RejectReservation] (@ReservationId int)
AS
BEGIN
  EXEC ChangeReservationStatus @ReservationId, 'Rejected'
END
GO
