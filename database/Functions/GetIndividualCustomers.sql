CREATE FUNCTION GetIndividualCustomers()
   RETURNS TABLE AS
       RETURN SELECT C.CustomerId AS CustomerId,
                     C.Email as Email,
                     C.PhoneNumber AS Number,
                     IC.FirstName + ' ' + IC.LastName AS Name,
                     C.CreationDate AS CreatedAt,
                     a.HouseNumber + ' ' + a.Street + ' ' + cc.Name + ' ' + cc.PostalCode as Address      
              FROM Customers AS C
                       JOIN IndividualCustomers AS IC on C.CustomerId = IC.CustomerId
                       LEFT JOIN IndividualCustomersAddresses as ICA ON ICA.CustomerId = C.CustomerId 
                       LEFT JOIN Addresses A on ICA.AddressId = A.AddressId
                       LEFT JOIN Cities AS CC ON CC.CityId = A.CityId


