CREATE PROCEDURE AddEmployee
          (@Firstname varchar(32),
          @Lastname varchar(64),
          @HouseNumber varchar(32),
          @Street varchar(255),
          @City varchar(255),
          @Country varchar(2),
      @PostalCode varchar(255),
          @Avatar varchar(255) = null,
          @Role nvarchar(255),
          @HiredDate datetime)
AS
BEGIN
  


   BEGIN


  Declare @addressId int = NULL
  EXEC AddAddress
          @street,
          @houseNumber,
          @city,
          @country,
          @postalCode,
          @addressId output




       INSERT INTO Employees(FirstName, LastName, Avatar, Role, HiredDate, AddressId)
       VALUES(@Firstname, @Lastname, @Avatar, @Role, @HiredDate, @addressId)


   END
END
