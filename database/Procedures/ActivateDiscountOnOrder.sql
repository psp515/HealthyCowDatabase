CREATE PROCEDURE ActivateDiscountOnOrder
  @customerId INT = NULL,
  @orderId INT = NULL
AS
BEGIN
  IF @customerId is null or NOT EXISTS(SELECT * FROM Customers AS C WHERE C.CustomerId = @customerId)
      THROW 52000, 'Invalid argument: customerId', 1


  IF @customerId is null or NOT EXISTS(SELECT * FROM Orders AS O WHERE O.OrderId = @orderId)
      THROW 52000, 'Invalid argument: orderId', 1


  IF EXISTS(SELECT * FROM OneTimeDiscounts WHERE CustomerId = @customerId
                                             AND ExpireDate is not null
                                             AND ExpireDate < GETDATE())
      begin
             UPDATE OneTimeDiscounts
             SET OrderId = @orderId
             where CustomerId = @CustomerId
      end
   else
       THROW 52000, 'Customer doest have free discount', 1


END
