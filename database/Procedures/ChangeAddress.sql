CREATE PROCEDURE [dbo].[changeAddress] (@AddressID int, @HouseNumber varchar(32), @Street varchar(255), @CityName varchar(255), @Country varchar(2), @PostalCode varchar(5))
AS
BEGIN




  IF @AddressID not in (select addressID from Addresses)
     BEGIN
     ;
     THROW 51000, 'nie ma takiego adresu', 1
  END


  ELSE
     BEGIN
     DECLARE @row_exists INT = 0
     SELECT @row_exists = COUNT(*)
     FROM Cities
     WHERE name=@CityName
     AND CountryCode=@country
     AND PostalCode=@postalCode


     DECLARE @CityId int
  -- wiersz nie istnieje
     IF @row_exists = 0
     begin
        INSERT INTO Cities(name, countrycode, postalcode) VALUES (@Cityname, @country, @postalCode)
        SET @cityid = SCOPE_IDENTITY()
     end
     else
     begin
        SELECT @cityid = CityId
        FROM Cities
        WHERE name=@Cityname
        AND CountryCode=@country
        AND PostalCode=@postalCode
     end


         UPDATE Addresses
         SET HouseNumber = @HouseNumber, Street = @Street, CityId = @CityId
          WHERE AddressId = @AddressID


  END
END
GO
