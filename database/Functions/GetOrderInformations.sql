CREATE FUNCTION GetOrderInformations(@id int)
   RETURNS @Order TABLE
                  (
                      OrderId    int,
                      CustomerId int,
                      CostWithDiscount      money,
                      Discount   float,
                      IsPaid     bit
                  )
AS
BEGIN
   IF NOT EXISTS(SELECT * FROM Orders AS O WHERE O.OrderId = @id)
       RETURN


   Declare @OrderDate datetime = (SELECT O.OrderDate FROM Orders AS O WHERE O.OrderId = @id)


   IF EXISTS(SELECT * FROM OneTimeDiscounts AS OTD WHERE OTD.OrderId = @id)
       INSERT INTO @Order
       SELECT O.OrderId,
              O.CustomerId,
              ISNULL(SUM(OD.Quantity * M.Price * (1 - BD.R2)), 0),
              BD.R2,
              O.IsPaid
       FROM Orders as O
                JOIN OrderDetails OD on O.OrderId = OD.OrderId
                JOIN Menu as M on M.MenuMealId = OD.MenuMealId
                JOIN OneTimeDiscounts D on O.OrderId = D.OrderId
                JOIN BigDiscounts BD on D.BigDiscountId = BD.BigDiscountId
       WHERE O.OrderId = @id
       GROUP BY O.OrderId, O.CustomerId, O.IsPaid, BD.R2
   ELSE
       IF (SELECT LC.ActivationDate
                               FROM Orders AS O
                                        JOIN LoyaltyCards LC on O.CustomerId = LC.CustomerId
                               WHERE O.OrderId = @id) is NULL or @OrderDate < ISNULL((SELECT LC.ActivationDate
                               FROM Orders AS O
                                        JOIN LoyaltyCards LC on O.CustomerId = LC.CustomerId
                               WHERE O.OrderId = @id), GETDATE())
           INSERT INTO @Order
           SELECT O.OrderId,
                  O.CustomerId,
                  ISNULL(SUM(OD.Quantity * M.Price), 0),
                  0,
                  O.IsPaid
           FROM Orders as O
                    JOIN OrderDetails OD on O.OrderId = OD.OrderId
                    JOIN Menu as M on M.MenuMealId = OD.MenuMealId
           WHERE O.OrderId = @id
           GROUP BY O.OrderId, O.CustomerId, O.IsPaid
       ELSE
           INSERT INTO @Order
           SELECT O.OrderId,
                  O.CustomerId,
                  ISNULL(SUM(OD.Quantity * M.Price * (1 - D2.R1)), 0),
                  D2.R1,
                  O.IsPaid
           FROM Orders as O
                    JOIN OrderDetails OD on O.OrderId = OD.OrderId
                    JOIN Menu as M on M.MenuMealId = OD.MenuMealId
                    JOIN LoyaltyCards L on O.CustomerId = L.CustomerId
                    JOIN Discounts D2 on D2.DiscountId = L.DiscountId
           WHERE O.OrderId = @id
           GROUP BY O.OrderId, O.CustomerId, O.IsPaid, D2.R1


           RETURN
END
go
