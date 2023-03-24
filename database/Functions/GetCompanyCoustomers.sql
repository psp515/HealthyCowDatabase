CREATE FUNCTION GetCompanyCustomers()
   RETURNS TABLE AS
       RETURN SELECT C.CustomerId AS CustomerId,
                     C.Email as Email,
                     C.PhoneNumber AS PhoneNumber,
                     IC.CompanyName AS CompanyName,
                     IC.NIP AS NIP,
                     C.CreationDate AS CreatedAt,
                     a.HouseNumber + ' ' + a.Street + ' ' + C2.Name + ' ' + C2.PostalCode as Address
              FROM Customers AS C
                       JOIN CompanyCustomers AS IC on C.CustomerId = IC.CustomerId
                       JOIN Addresses A on IC.AddressId = A.AddressId
                       JOIN Cities C2 on C2.CityId = A.CityId
