CREATE VIEW OneTimeDiscountMonthly AS
SELECT COUNT(*) AS "Liczba przyznanych zniżek", 
    DATEPART(year, ActivationDate) AS "Rok", 
    DATEPART(month, ActivationDate) AS "Numer miesiąca"
FROM OneTimeDiscounts
WHERE ActivationDate IS NOT NULL AND ExpireDate < GETDATE()
GROUP BY DATEPART(year, ActivationDate), 
    DATEPART(month, ActivationDate)