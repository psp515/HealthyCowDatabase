CREATE PROCEDURE [dbo].[AcceptReservation] (@ReservationId int, @Tables TableList READONLY)
AS
BEGIN
   IF @ReservationId NOT IN (SELECT ReservationId from Reservations)
   BEGIN
         ;
         THROW 51000, 'There is no such ReservationId', 1
   END
  




  EXEC AddTableToReservation @ReservationId, @Tables






      EXEC ChangeReservationStatus @ReservationId, 'Confirmed'
   
END
GO
