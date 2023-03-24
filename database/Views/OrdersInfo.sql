CREATE VIEW OrdersInfo AS
(
SELECT O.OrderId                             AS OrderId,
      O.CustomerId                          as CustomerId,
      O.OrderDate                           AS OrderDate,
      ISNULL(SUM(OD.Quantity * M.Price), 0) AS Value
FROM Orders AS O
        JOIN OrderDetails AS OD on O.OrderId = OD.OrderId
        JOIN Menu M on M.MenuMealId = OD.MenuMealId
        JOIN LoyaltyCards LC on LC.CustomerId = O.CustomerId
WHERE (LC.ActivationDate IS NULL OR LC.ActivationDate > O.OrderDate)
 AND NOT EXISTS(SELECT * FROM OneTimeDiscounts AS OTD where OTD.OrderId = O.OrderId)
GROUP BY O.OrderId, O.CustomerId, O.OrderDate
UNION
SELECT O.OrderId                                          as OrderId,
      O.CustomerId                                       as CustomerId,
      O.OrderDate                                        as OrderDate,
      ISNULL(SUM(OD.Quantity * M.Price * (1 - D.R1)), 0) as Value
FROM Orders AS O
        JOIN OrderDetails AS OD on O.OrderId = OD.OrderId
        JOIN Menu M on M.MenuMealId = OD.MenuMealId
        JOIN LoyaltyCards LC on LC.CustomerId = O.CustomerId
        JOIN Discounts D on D.DiscountId = LC.DiscountId
WHERE LC.ActivationDate IS NOT NULL
 AND LC.ActivationDate < O.OrderDate
 AND NOT EXISTS(SELECT * FROM OneTimeDiscounts AS OTD where OTD.OrderId = O.OrderId)
GROUP BY O.OrderId, O.CustomerId, O.OrderDate
UNION
SELECT O.OrderId                                           as OrderId,
      O.CustomerId                                        as CustomerId,
      O.OrderDate                                         as OrderDate,
      ISNULL(SUM(OD.Quantity * M.Price * (1 - BD.R2)), 0) as Value
FROM Orders AS O
        JOIN OrderDetails AS OD on O.OrderId = OD.OrderId
        JOIN Menu M on M.MenuMealId = OD.MenuMealId
        JOIN OneTimeDiscounts OTD on O.OrderId = OTD.OrderId
        JOIN BigDiscounts BD on BD.BigDiscountId = OTD.BigDiscountId
GROUP BY O.OrderId, O.CustomerId, O.OrderDate)