CREATE VIEW LoyaltyCardsActivatedMonthly AS
SELECT YEAR(LC.ActivationDate)             AS Year,
      DATEPART(month , LC.ActivationDate) AS Month,
      ISNULL(COUNT(*), 0) AS [Activated Discounts]
FROM LoyaltyCards AS LC
WHERE LC.ActivationDate IS NOT NULL
GROUP BY YEAR(LC.ActivationDate), DATEPART(month, LC.ActivationDate)