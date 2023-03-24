CREATE OR ALTER PROCEDURE AddCity
   @name varchar(255),
   @countryCode varchar(2),
   @postalCode varchar(5),
   @cityid INT = NULL OUTPUT
AS
BEGIN
   DECLARE @row_exists INT = 0
   SELECT @row_exists = COUNT(*)
   FROM Cities
   WHERE name=@name
     AND CountryCode=@countryCode
     AND PostalCode=@postalCode


   IF @row_exists = 0
   begin
       INSERT INTO Cities(name, countrycode, postalcode) VALUES (@name, @countryCode, @postalCode)
       SET @cityid = SCOPE_IDENTITY()
   end
   else
   begin
       SELECT @cityid = CityId
       FROM Cities
       WHERE name=@name
       AND CountryCode=@countryCode
       AND PostalCode=@postalCode
   end
END
