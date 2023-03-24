CREATE PROCEDURE addBigDiscount(@R2 float, @K2 money, @Duration datetime)
AS
BEGIN
   INSERT INTO BigDiscounts(R2, K2, Duration)
   VALUES(@R2, @K2, @Duration)
END
GO
