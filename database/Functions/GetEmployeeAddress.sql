CREATE FUNCTION GetEmployeeAddress(@id int)
   RETURNS TABLE AS RETURN
       SELECT e.EmployeeId,
              C.Name,
              A.Street,
              A.HouseNumber
       FROM Employees AS E
                JOIN Addresses A on A.AddressId = E.AddressId
                JOIN Cities C on C.CityId = A.CityId
       WHERE E.EmployeeId = @id


