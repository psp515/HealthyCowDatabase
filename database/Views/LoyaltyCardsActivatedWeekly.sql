CREATE VIEW LoyaltyCardsActivatedWeek AS
SELECT YEAR(LC.ActivationDate)            AS Year,
       DATEPART(week , LC.ActivationDate) AS Week,
       ISNULL(COUNT(*), 0) AS [Activated Discounts]
FROM LoyaltyCards AS LC
WHERE LC.ActivationDate IS NOT NULL
GROUP BY YEAR(LC.ActivationDate), DATEPART(week, LC.ActivationDate)