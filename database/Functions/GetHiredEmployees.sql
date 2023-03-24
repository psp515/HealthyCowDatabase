CREATE FUNCTION getHiredEmployees()
RETURNS TABLE
AS


RETURN (SELECT
  E.EmployeeId AS ID,
  E.FirstName + ' ' + E.LastName AS "Imię i nazwisko",
  E.HiredDate AS "Data zatrudnienia",
  A.Street + ' ' + A.HouseNumber + ', ' +  C.Name AS "Adres zamieszkania",
  E.Avatar AS AvatarURL,
  E.Role AS "Stanowisko"
 
 
FROM Employees AS E
INNER JOIN Addresses AS A ON E.AddressId = A.AddressId
INNER JOIN Cities AS C ON A.CityId = C.CityId


WHERE E.FiredDate IS NULL)
