CREATE OR ALTER PROCEDURE AddAddress
   @street varchar(255),
   @houseNumber varchar(32),
   @city varchar(255),
   @countryCode varchar(2),
   @postalCode varchar(5),
   @addressId INT = NULL OUTPUT
AS
BEGIN
   DECLARE @cityId INT


   EXEC AddCity @city,@countryCode, @postalCode, @cityId OUTPUT


   INSERT INTO Addresses(cityid, street, housenumber) VALUES (@cityId, @street, @houseNumber)


   SET @addressId = SCOPE_IDENTITY()
END
