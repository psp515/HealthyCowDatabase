CREATE VIEW EmptyTables AS 
SELECT TableId FROM Tables
EXCEPT
SELECT T.TableId
FROM Reservations R
  INNER JOIN ReservationDetails Rd ON R.ReservationId= Rd.ReservationId
  INNER JOIN Tables T ON Rd.TableId = T.TableId
WHERE R.StartDate < GETDATE() AND GETDATE() < R.EndDate AND R.Status = 'Confirmed'