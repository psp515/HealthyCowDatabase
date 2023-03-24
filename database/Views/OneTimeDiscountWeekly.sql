SELECT COUNT(*) AS "Liczba przyznanych zniżek",
   DATEPART(year, ActivationDate) AS "Rok",
   DATEPART(week, ActivationDate) AS "Numer tygodnia"
FROM OneTimeDiscounts
WHERE ActivationDate IS NOT NULL
GROUP BY DATEPART(year, ActivationDate),
   DATEPART(week, ActivationDate)