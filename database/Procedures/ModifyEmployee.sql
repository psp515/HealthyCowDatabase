CREATE PROCEDURE ModifyEmployee
          (@EmployeeId int,
          @LastName varchar(64) = null,
          @HouseNumber varchar(32) = null,
          @Street varchar(255) = null,
          @City varchar(255) = null,
          @Country varchar(2) = null,
          @Avatar varchar(255) = null,
          @Role nvarchar(255) = null,
          @Fire bit = 0,
          @Hire bit = 0)
AS
BEGIN
  
   IF @LastName IS NOT NULL
   BEGIN
       UPDATE Employees
       SET LastName = @LastName
       WHERE EmployeeId = @EmployeeId
   END
  
   IF @HouseNumber IS NOT NULL
   BEGIN
       UPDATE Addresses
       SET HouseNumber = @HouseNumber
       WHERE AddressId = (SELECT AddressId FROM Employees WHERE EmployeeId = @EmployeeId)
   END


   IF @Street IS NOT NULL
   BEGIN
       UPDATE Addresses
       SET Street = @Street
       WHERE AddressId = (SELECT AddressId FROM Employees WHERE EmployeeId = @EmployeeId)
   END


   IF @City IS NOT NULL
   BEGIN
       UPDATE Cities
       SET Name = @City
       WHERE CityId = (SELECT CityId FROM Addresses WHERE AddressId = (SELECT AddressId FROM Employees WHERE EmployeeId = @EmployeeId))
   END


   IF @Country IS NOT NULL
   BEGIN
       UPDATE Cities
       SET CountryCode = @Country
       WHERE CityId = (SELECT CityId FROM Addresses WHERE AddressId = (SELECT AddressId FROM Employees WHERE EmployeeId = @EmployeeId))
   END


   IF @Avatar IS NOT NULL
   BEGIN
       UPDATE Employees
       SET Avatar = @Avatar
       WHERE EmployeeId = @EmployeeId
   END


   IF @Role iS NOT NULL
   BEGIN
       UPDATE Employees
       SET Role = @Role
       WHERE EmployeeId = @EmployeeId
   END


   IF @Hire = 1 AND @Fire = 1
   BEGIN
       ;
       THROW 51000, 'You try to hire and fire the employee at the same time!', 1
   END


   ELSE IF @Hire = 1
   BEGIN
       UPDATE Employees
       SET HiredDate = GETDATE(), FiredDate = NULL
   WHERE EmployeeId = @EmployeeId
   END


   ELSE IF @Fire = 1
   BEGIN
       UPDATE Employees
       SET FiredDate = GETDATE()
   WHERE EmployeeId = @EmployeeId
   END
END


