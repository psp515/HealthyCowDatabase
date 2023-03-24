CREATE VIEW OrderStatsWeekly AS
SELECT YEAR(OC.OrderDate) as year,
     DATEPART(week, OC.OrderDate) as week,
     SUM(OC.Value) as Income,
     COUNT(*) as OrdersNumber
FROM OrdersInfo as OC
GROUP BY YEAR(OC.OrderDate), DATEPART(week, OC.OrderDate)