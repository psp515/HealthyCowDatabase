CREATE OR ALTER PROCEDURE CheckCustomerDiscounts @customerId INT = NULL
AS
BEGIN
  IF @customerId is null or @customerId = 0 or NOT EXISTS(SELECT * FROM IndividualCustomers AS C WHERE C.CustomerId = @customerId)
   begin
       THROW 52000, 'Invalid argument', 1
   end




   IF EXISTS(SELECT * FROM LoyaltyCards AS LC WHERE CustomerId = @customerId AND ActivationDate is null)
       begin


           declare @z1 int = (SELECT top 1 D.Z1
                             FROM LoyaltyCards AS LC
                                      join Discounts D on D.DiscountId = LC.DiscountId
                             WHERE LC.CustomerId = @CustomerId)


           declare @z1c int = (SELECT COUNT(*)
                              FROM OrdersInfo AS OI
                                       JOIN LoyaltyCards as LC on LC.CustomerId = OI.CustomerId
                                       JOIN Discounts D2 on LC.DiscountId = D2.DiscountId
                              WHERE OI.CustomerId = @CustomerId
                                AND OI.Value > D2.K1)


           if (@z1c > @z1)
               begin
                   UPDATE LoyaltyCards
                   SET ActivationDate = GETDATE()
                   WHERE CustomerId = @customerId
               end


       end




   IF EXISTS(SELECT * FROM OneTimeDiscounts AS LC WHERE CustomerId = @customerId AND ActivationDate is null)
       begin


           declare @k1 money = (SELECT top 1 D.Z1
                                FROM LoyaltyCards AS LC
                                         join Discounts D on D.DiscountId = LC.DiscountId
                                WHERE LC.CustomerId = @CustomerId)


           declare @k1c money = (SELECT SUM(OI.Value)
                                FROM OrdersInfo as OI
                                WHERE CustomerId = @customerId
                                GROUP BY CustomerId)


           IF @k1 < @k1c
               begin
                   UPDATE OneTimeDiscounts
                   SET ActivationDate = GETDATE()
                   where CustomerId = @CustomerId


                   declare @span int = (SELECT TOP 1 BigDiscounts.Duration
                                        FROM BigDiscounts
                                                 JOIN OneTimeDiscounts OTD on BigDiscounts.BigDiscountId = OTD.BigDiscountId
                                        WHERE CustomerId = @CustomerId)


                   UPDATE OneTimeDiscounts
                   SET ExpireDate = DATEADD(day, @span, GETDATE())
                   where CustomerId = @customerId


               end


       end


END


