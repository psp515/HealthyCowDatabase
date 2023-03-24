CREATE FUNCTION GetCustomerById(@id int)
   RETURNS @Customer TABLE
                     (
                         CustomerId    int,
                         Name          varchar(510),
                         Email         varchar(255),
                         Number        varchar(15),
                         Address       varchar(255),
                         AdditonalData varchar(255),
                         CreatedAt     datetime
                     )
AS
BEGIN
   IF @id IN (SELECT CC.CustomerId FROM CompanyCustomers AS CC)
       INSERT INTO @Customer
       SELECT CC.CustomerId,
              CC.CompanyName,
              CC.Email,
              CC.PhoneNumber,
              CC.Address,
              '{"Nip":"' + CC.NIP + '"}',
              C.CreationDate
       FROM GetCompanyCustomers() as CC
           JOIN Customers AS C ON C.CustomerId = CC.CustomerId
       WHERE CC.CustomerId = @id
      
   ELSE
       INSERT INTO @Customer
       SELECT IC.CustomerId,
              IC.Name,
              IC.Email,
              IC.Number,
              IC.Address,
              '{}',
              C.CreationDate
       From GetIndividualCustomers() AS IC
           JOIN Customers AS C ON C.CustomerId = IC.CustomerId
       WHERE IC.CustomerId = @id


   RETURN
end
