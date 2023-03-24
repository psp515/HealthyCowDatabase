CREATE FUNCTION getEmployees()
RETURNS TABLE
AS


RETURN (SELECT
  E.EmployeeId AS ID,
  E.FirstName + ' ' + E.LastName AS "Imię i nazwisko",
  A.Street + ' ' + A.HouseNumber + ', ' +  C.Name AS "Adres zamieszkania",
  E.Avatar AS AvatarURL,
  IIF(E.FiredDate IS NULL, E.Role, NULL) AS Stanowisko,
  IIF(E.FiredDate IS NULL, 'Zatrudniony', 'Niezatrudniony') AS "Stan zatrudnienia"
FROM Employees AS E
INNER JOIN Addresses AS A ON E.AddressId = A.AddressId
INNER JOIN Cities AS C ON A.CityId = C.CityId)