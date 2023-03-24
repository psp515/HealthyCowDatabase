CREATE PROCEDURE addEmployeeToOrder
          (@EmployeeId int,
          @OrderId int)
AS
BEGIN


   IF NOT EXISTS (SELECT * FROM Employees AS E WHERE E.EmployeeId = @EmployeeId)
   BEGIN
       ;
       THROW 51000, 'This person does not exist in database', 1
   END
   ELSE IF NOT EXISTS (SELECT * FROM Orders WHERE OrderId = @OrderId)
   BEGIN
       ;
       THROW 51001, 'Such order was never ordered', 1
   END
   ELSE IF DATEDIFF(hour,  (SELECT OrderDate FROM Orders WHERE Orderid = @OrderId), GETDATE()) > 12
   BEGIN
       ;
       THROW 51002, 'Cannot modify order employee in orders ordered more than 12 hours ago!', 1
   END


   ELSE


   BEGIN
       INSERT INTO EmployeesDetails(EmployeeId, OrderId)
       VALUES(@EmployeeId, @OrderId)
   END
END
