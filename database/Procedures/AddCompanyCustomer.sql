CREATE OR ALTER PROCEDURE AddCompanyCustomer
  @name varchar(255),
  @NIP varchar(32),
  @customerId INT = NULL OUTPUT ,
  @email varchar(255),
  @phoneNumber varchar(15),
  @addressId INT = NULL,
  @street varchar(255) = NULL,
  @houseNumber varchar(32) = NULL,
  @city varchar(255) = NULL,
  @countryCode varchar(2) = NULL,
  @postalCode varchar(5) = NULL
AS
BEGIN
  IF @customerId is null
      EXEC AddCustomer
          @email,
          @phoneNumber,
          @customerId output


  if @addressId is null and
     @street is null and
     @houseNumber is null and
     @city is null and
     @countryCode is null and
     @postalCode is null
      THROW 51000, 'Invalid arguments, pass @addressId or pass data to new specific address',1




  if @addressId is null
      EXEC AddAddress
          @street,
          @houseNumber,
          @city,
          @countryCode,
          @postalCode,
          @addressId output


  INSERT INTO CompanyCustomers(CustomerId, CompanyName, NIP, AddressId) VALUES (@customerId, @name, @NIP, @addressId)
END
