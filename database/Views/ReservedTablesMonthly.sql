CREATE VIEW ReservedTablesMonthly AS
SELECT 
    T.TableId AS "Numer stolika", 
    COUNT(T.TableId) AS "Liczba rezerwacji", 
    DATEPART(year, R.StartDate) AS "Rok", 
    DATEPART(month, R.StartDate) AS "Numer miesiąca"
FROM Tables AS T 
    INNER JOIN ReservationDetails AS RD ON T.TableId = RD.TableId 
    INNER JOIN Reservations AS R ON R.ReservationId = RD.ReservationId
GROUP BY T.TableId, DATEPART(year, R.StartDate), DATEPART(month, R.StartDate)
