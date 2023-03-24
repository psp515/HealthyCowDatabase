CREATE OR ALTER PROCEDURE AddIndividualCustomer
  @firstName varchar(64),
  @lastName varchar(128),
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


  if @customerId is null
      EXEC AddCustomer
          @email,
          @phoneNumber,
          @customerId output


   if @addressId is null and
      @street is not null and
      @houseNumber is not null and
      @city is not null and
      @countryCode is not null and
      @postalCode is not null
          EXEC AddAddress
              @street,
              @houseNumber,
              @city,
              @countryCode,
              @postalCode,
              @addressId OUTPUT


   if @addressid is not null
       INSERT INTO IndividualCustomersAddresses(customerid, addressid)
       VALUES (@customerId, @addressId)


   INSERT INTO IndividualCustomers(CustomerId, FirstName, LastName) VALUES (@customerId, @firstName, @lastName)
   INSERT INTO LoyaltyCards( CustomerId, DiscountId ) VALUES( @customerId, (select MAX(DiscountId) from Discounts))
END
