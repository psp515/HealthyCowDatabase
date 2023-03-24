CREATE OR ALTER PROCEDURE AddCustomer
  @email varchar(255),
  @phoneNumber varchar(15),
  @customerId INT = NULL OUTPUT
AS
BEGIN
  INSERT INTO Customers(Email, PhoneNumber, CreationDate) VALUES (@email, @phoneNumber, GETDATE())


  SET @customerId = SCOPE_IDENTITY()
END
