CREATE VIEW ClientsAwaitingPayments AS
SELECT OI.CustomerId            as [Customer Id],
      ISNULL(SUM(OI.Value), 0) as MoneyToPay,
      ISNULL(COUNT(*), 0)      as OrdersToPay
FROM Customers as C
        JOIN OrdersInfo as OI ON OI.CustomerId = C.CustomerId
where OI.IsPaid = 'false'
GROUP BY OI.CustomerId