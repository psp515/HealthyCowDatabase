CREATE VIEW ReservedTablesWeekly AS
SELECT 
    T.TableId AS "Numer stolika", 
    COUNT(T.TableId) AS "Liczba rezerwacji", 
    DATEPART(year, R.StartDate) AS "Rok", 
    DATEPART(week, R.StartDate) AS "Numer tygodnia"
FROM Tables AS T 
    INNER JOIN ReservationDetails AS RD ON T.TableId = RD.TableId 
    INNER JOIN Reservations AS R ON R.ReservationId = RD.ReservationId
GROUP BY T.TableId, DATEPART(year, R.StartDate), DATEPART(week, R.StartDate)
