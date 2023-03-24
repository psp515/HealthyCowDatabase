CREATE OR ALTER TRIGGER DeleteOrderOnReservationRejection
ON Reservations
FOR UPDATE
AS BEGIN
   SET NOCOUNT OFF
   DECLARE @reservationId INT
   DECLARE @status VARCHAR(MAX)




   SELECT TOP 1
       @reservationId = inserted.ReservationId,
       @status = inserted.Status
   FROM inserted


   PRINT 'Reservation [' + CAST(@reservationId as VARCHAR(max) )+ '] update'


   IF @status <> 'Rejected'
       RETURN;


   --- DELETE ALL ORDER DETAILS ---


   DELETE FROM OrderDetails WHERE OrderDetailId IN (
       SELECT OrderDetailId FROM OrderDetails
           INNER JOIN Orders
       ON OrderDetails.OrderId = Orders.OrderId
       WHERE Orders.ReservationId = @reservationId
   );


   --- DELETE ALL ORDERS ---


   DELETE FROM Orders WHERE OrderId IN (
       SELECT OrderId FROM Orders
       WHERE Orders.ReservationId = @reservationId
   );


   --- RESULT ---


   PRINT 'Deleted orders: ' + CAST(@@ROWCOUNT as VARCHAR(MAX))
END
