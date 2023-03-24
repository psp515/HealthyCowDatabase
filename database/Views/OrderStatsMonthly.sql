CREATE VIEW OrderStatsMonthly AS
SELECT YEAR(OC.OrderDate) as year,
     DATEPART(month, OC.OrderDate) as month,
     SUM(OC.Value) as Income,
     COUNT(*) as OrdersNumber
FROM OrdersInfo as OC
GROUP BY YEAR(OC.OrderDate), DATEPART(month, OC.OrderDate)