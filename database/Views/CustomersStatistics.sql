CREATE VIEW CustomerStatistics AS


SELECT C.CustomerId as [Customer Id],
    SUM(OI.Value) as MoneySpent,
    COUNT(*) as OrdersNumber
FROM Customers as C
   JOIN OrdersInfo as OI ON OI.CustomerId = C.CustomerId
GROUP BY C.CustomerId
UNION
SELECT C.CustomerId as [Customer Id],
    0 as MoneySpent,
    0 as OrdersNumber
FROM Customers as C
  LEFT JOIN OrdersInfo as OI ON OI.CustomerId = C.CustomerId
GROUP BY C.CustomerId
having SUM(OI.Value) IS NULL